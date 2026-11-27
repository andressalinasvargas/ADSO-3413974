# B6 · Políticas de Seguridad de Datos y Matriz de Roles (`Fotocopiadora SyP`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`

---

## 1. Políticas de Seguridad Aplicadas al Modelo (`9` Políticas: `3` por Principio)

| Principio | ID | Política y medida técnica concreta sobre las tablas de `Fotocopiadora SyP` | Control de verificación |
| :--- | :--- | :--- | :--- |
| **Integridad** | **POL-INT-01** | Aplicar integridad referencial y restricciones de dominio directamente en el motor mediante `12` FK con acción explícita (`RESTRICT` en productos referenciados y categoría, `CASCADE` en detalles y notificaciones, `SET NULL` en pedidos/cotizaciones/citas al dar de baja un usuario) y `33` `CHECK` nombrados (`precio_cop >= 0`, `cantidad >= 1`, `total >= subtotal`). | Ejecución real del script `05-script-creacion.sql` (`4/4` pruebas negativas `IntegrityError`). |
| **Integridad** | **POL-INT-02** | Prohibir borrado físico de pedidos, cotizaciones y cuentas con historial aplicando **desactivación lógica (`activo = 0`)** en `usuario` y `producto`, y prevenir doble envío/registro de contadores duplicados con `UNIQUE uk_rep_usuario_eq_mes(id_usuario, modelo_equipo, mes_reportado)`. | Pruebas E2E anti-doble envío (`orderSubmissionInFlight`) y rechazo SQL de lectura repetida en el mismo mes. |
| **Integridad** | **POL-INT-03** | Recalcular `pedido.subtotal`, `pedido.iva` (`19 %`), `pedido.total` y `detalle_pedido.subtotal_linea` **exclusivamente en servidor** usando `producto.precio_cop` vigente (congelado en `precio_unitario_pactado` al confirmar) y validar `estado_stock <> 'out'`. | Pruebas automatizadas `pytest` rechazando precios manipulados o productos inexistentes (`HTTP 400`). |
| **Confidencialidad** | **POL-CON-01** | **Credenciales con hash y sal única:** `usuario.clave_hash` almacena **únicamente un hash criptográfico unidireccional con sal única por usuario (`BCrypt`)**, nunca texto plano ni cifrado reversible; las respuestas JSON/admin omiten siempre `clave_hash`. | Revisión de esquemas Pydantic de salida y auditoría sobre `usuario`. |
| **Confidencialidad** | **POL-CON-02** | **Cifrado en tránsito (`TLS 1.3`) y sesión `HttpOnly`:** todo tráfico entre `N1`/`N2` y `N3`/`N4` viaja por **`HTTPS 443`**, el token JWT viaja exclusivamente en cookie **`HttpOnly` `syp_session`** (nunca en `localStorage`) con clave `SYP_JWT_SECRET` (`≥ 32` caracteres) y cabeceras `CSP`/`HSTS`. | Auditoría de cookies en navegador y cabeceras TLS del borde `N3`. |
| **Confidencialidad** | **POL-CON-03** | **Privacidad de datos personales (Ley 1581 de 2012) y enmascaramiento (`is_owner`):** las consultas públicas por `codigo_pedido` o `codigo_cotizacion` enmascaran `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente` y `direccion_entrega` cuando el solicitante no es titular autenticado ni administrador; exportación CSV protege contra inyección de fórmulas (`'`). | Pruebas E2E verificando enmascaramiento de PII y sanitización de celdas CSV (`=,+,-,@`). |
| **Disponibilidad** | **POL-DIS-01** | **Respaldo diario automatizado:** ejecución diaria a las `02:00 a. m.` (`America/Bogota`) de volcado lógico cifrado `AES-256` hacia almacenamiento externo S3 con retención mínima de `30` días. | Bitácora diaria de ejecución y checksum SHA-256 del volcado. |
| **Disponibilidad** | **POL-DIS-02** | **Prueba mensual de restauración:** el primer lunes de cada mes se restaura el último volcado en instancia aislada comprobando `12/12` tablas e integridad referencial (`RPO ≤ 24 h`, `RTO ≤ 2 h`). | Acta mensual de simulacro de restauración. |
| **Disponibilidad** | **POL-DIS-03** | **Contingencia estática y PWA (`RNF-06`):** cuando el backend `N4` no está disponible (modo estático en Render), el navegador opera catálogo/cotizaciones/reservas vía `dist/`, `sw.js` y respaldo en `localStorage` con derivación directa a WhatsApp oficial. | Pruebas de modo estático sin backend y verificación offline PWA. |

---

## 2. Matriz de Permisos por Rol frente a las `12` Tablas

| Tabla (`B2`/`B5`) | Rol 1: **Visitante** *(sin sesión)* | Rol 2: **Cliente Registrado** | Rol 3: **Administrador** | Rol 4: **Admin BD / Operador Infra** |
| :--- | :--- | :--- | :--- | :--- |
| **`usuario`** | `INSERT` *(solo auto-registro con `rol = 'cliente'`)* | `SELECT` *(propia fila, sin `clave_hash`)*, `UPDATE` *(perfil/clave propia)* | `SELECT` *(sin `clave_hash`)*, `UPDATE` *(`activo`)* | `SELECT`, `INSERT`, `UPDATE` *(operación y soporte)* |
| **`notificacion`** | Sin acceso | `SELECT`, `UPDATE` *(`leida = 1` solo donde `id_usuario` propio)* | `SELECT`, `INSERT`, `UPDATE` *(avisos operativos)* | `SELECT`, `DELETE` *(depuración retención)* |
| **`categoria`** | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE` |
| **`producto`** | `SELECT` *(solo `activo = 1`)* | `SELECT` *(solo `activo = 1`)* | `SELECT`, `INSERT`, `UPDATE` *(inactivación lógica `activo = 0`)* | `SELECT`, `INSERT`, `UPDATE` |
| **`compatibilidad_producto`** | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `DELETE` | `SELECT`, `INSERT`, `DELETE` |
| **`pedido`** | `INSERT` *(como invitado)*, `SELECT` *(solo resumen sin PII por código)* | `INSERT`, `SELECT` *(completo solo si es propietario `is_owner`)* | `SELECT`, `UPDATE` *(`estado_pago`, `estado_envio`)* + Export CSV | `SELECT` *(solo lectura para auditoría contable)* |
| **`detalle_pedido`** | `INSERT` *(al crear pedido)* | `SELECT` *(propios pedidos)* | `SELECT` | `SELECT` *(solo lectura)* |
| **`cotizacion`** | `INSERT`, `SELECT` *(con código y PII oculto si no es titular)* | `INSERT`, `SELECT` *(completo si `is_owner`)* | `SELECT`, `UPDATE` *(observaciones/vigencia)* | `SELECT` *(solo lectura)* |
| **`detalle_cotizacion`** | `INSERT` *(al cotizar)* | `SELECT` *(propias cotizaciones)* | `SELECT` | `SELECT` *(solo lectura)* |
| **`solicitud_servicio`** | `INSERT` *(cita técnica pública)* | `INSERT`, `SELECT` *(propias solicitudes)* | `SELECT`, `UPDATE` *(`estado_atencion`, `notas_admin`)* | `SELECT` *(solo lectura)* |
| **`reporte_contador`** | Sin acceso | `SELECT`, `INSERT` *(exclusivamente propios equipos)* | `SELECT` *(auditoría renting)* + Export CSV | `SELECT` *(solo lectura)* |
| **`mensaje_contacto`** | `INSERT` *(formulario público)* | `INSERT` | `SELECT`, `UPDATE` *(`leido = 1`)* | `SELECT` |

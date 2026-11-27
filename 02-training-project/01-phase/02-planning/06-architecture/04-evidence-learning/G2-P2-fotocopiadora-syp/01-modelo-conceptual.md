# B1 · Modelo Conceptual Ajustado (`Fotocopiadora SyP`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Diagrama conceptual:** [01-modelo-conceptual.svg](01-modelo-conceptual.svg) · **Fuente editable:** [01-modelo-conceptual.drawio](01-modelo-conceptual.drawio)

---

## 1. Justificación del Tipo de Base de Datos (Relacional)

Se selecciona un **Sistema Gestor de Base de Datos Relacional (`PostgreSQL 16` en producción / `SQLite 3` en desarrollo y validación)** en lugar de una base documental NoSQL por cuatro razones concretas de `Fotocopiadora SyP`:

1. **Integridad estricta en cabecera y detalle (`RF-05`, `RF-06`):** Cada `PEDIDO` y `COTIZACION` requiere garantizar la existencia real de los `PRODUCTO`s referenciados y preservar el precio unitario pactado en `DETALLE_PEDIDO` / `DETALLE_COTIZACION`.
2. **Resolución explícita de relaciones `N:M` y recursiva (`RF-03`):** La compatibilidad entre equipos multifuncionales e insumos/repuestos (`PRODUCTO ↔ PRODUCTO`) y el desglose de artículos por transacción se modelan limpiamente con tablas puente e integridad referencial.
3. **Reglas de negocio verificables en motor (`CHECK` y `UNIQUE`):** Códigos únicos (`codigo_pedido`, `codigo_cotizacion`, `codigo_seguimiento`), unicidad mensual por cliente y equipo en `REPORTE_CONTADOR`, y límites de dominio (`cantidad >= 1`, `total >= subtotal`).
4. **Control de propiedad y auditoría (`RF-11`, `RNF-05`):** Permite verificar titularidad (`id_usuario`) para enmascarar PII a terceros y generar reportes agregados/CSV seguros mediante consultas SQL parametrizadas.

---

## 2. Catálogo de `11` Entidades y Trazabilidad a Requisitos (`G1-P2 → G2-P2`)

| # | Entidad | Tipo | Identificador | Atributos clave | Requisitos que soporta |
| :- | :--- | :--- | :--- | :--- | :--- |
| `1` | **`USUARIO`** | Fuerte | `id_usuario` | `correo_unico`, `clave_hash`, `nombre_completo`, `telefono`, `rol`, `activo`, `fecha_creacion`, `ultimo_acceso` | `RF-07`, `RF-11`, `RNF-05` |
| `2` | **`NOTIFICACION`** | **Débil** *(depende de `USUARIO`)* | `(id_usuario, id_notificacion)` | `titulo`, `mensaje`, `tipo`, `enlace_destino`, `leida`, `fecha_creacion` | `RF-05`, `RF-09`, `RF-12` |
| `3` | **`CATEGORIA`** | Fuerte | `id_categoria` | `slug_unico`, `nombre`, `orden_visual` | `RF-01`, `RF-02` |
| `4` | **`PRODUCTO`** | Fuerte *(con relación recursiva)* | `id_producto` | `codigo_sku`, `nombre`, `marca`, `precio_cop`, `especificacion`, `estado_stock`, `activo`, `velocidad_ppm`, `rendimiento_toner` | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RF-11` |
| `5` | **`PEDIDO`** | Fuerte | `id_pedido` | `codigo_pedido`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega`, `subtotal`, `iva`, `total`, `metodo_pago`, `estado_pago`, `estado_envio`, `fecha_creacion` | `RF-05`, `RF-11` |
| `6` | **`DETALLE_PEDIDO`** | Asociativa (`N:M`) | `(id_pedido, id_producto)` | `cantidad`, `precio_unitario_pactado`, `subtotal_linea`, `especificacion_linea` | `RF-05`, `RF-11` |
| `7` | **`COTIZACION`** | Fuerte | `id_cotizacion` | `codigo_cotizacion`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `subtotal`, `iva`, `total`, `observaciones`, `vigencia_dias`, `fecha_creacion` | `RF-06`, `RF-11` |
| `8` | **`DETALLE_COTIZACION`** | Asociativa (`N:M`) | `(id_cotizacion, id_producto)` | `cantidad`, `precio_unitario_cotizado`, `subtotal_linea`, `especificacion_linea` | `RF-06`, `RF-11` |
| `9` | **`SOLICITUD_SERVICIO`** | Fuerte | `id_solicitud` | `codigo_seguimiento`, `nombre_solicitante`, `telefono_contacto`, `modelo_equipo`, `tipo_servicio`, `fecha_deseada`, `franja_horaria`, `descripcion_problema`, `estado_atencion`, `notas_admin`, `fecha_creacion` | `RF-09`, `RF-11` |
| `10` | **`REPORTE_CONTADOR`** | Fuerte | `id_reporte` | `modelo_equipo`, `contador_bn`, `contador_color`, `mes_reportado`, `observaciones`, `fecha_creacion` | `RF-10`, `RF-11` |
| `11` | **`MENSAJE_CONTACTO`** | Fuerte *(autónoma)* | `id_mensaje` | `nombre`, `correo`, `telefono`, `asunto`, `mensaje`, `leido`, `fecha_creacion` | `RF-08`, `RF-11` |

---

## 3. Relaciones, Verbos y Cardinalidades Mínimas/Máximas (`Crow's Foot`)

| Entidad A | Verbo | Entidad B | Cardinalidad y participación | Tipo |
| :--- | :--- | :--- | :--- | :---: |
| `USUARIO` | genera | `NOTIFICACION` | `1` (`\|\|`) obligatorio a `0..*` (`o<`) | `1:N` identificadora (débil) |
| `CATEGORIA` | agrupa | `PRODUCTO` | `1` (`\|\|`) obligatorio a `1..*` (`\|<`) | `1:N` |
| `PRODUCTO` | es compatible con | `PRODUCTO` | `0..*` (`o<`) a `0..*` (`o<`) | **`N:M` recursiva** |
| `USUARIO` | realiza | `PEDIDO` | `0..1` (`o\|`) opcional a `0..*` (`o<`) | `1:N` *(permite invitados)* |
| `PEDIDO` ↔ `PRODUCTO` | incluye | `DETALLE_PEDIDO` | `1:N` (`1..*`) desde `PEDIDO` y `1:N` (`0..*`) desde `PRODUCTO` | **`N:M` resuelta** |
| `USUARIO` | solicita | `COTIZACION` | `0..1` (`o\|`) opcional a `0..*` (`o<`) | `1:N` *(permite invitados)* |
| `COTIZACION` ↔ `PRODUCTO` | detalla | `DETALLE_COTIZACION` | `1:N` (`1..*`) desde `COTIZACION` y `1:N` (`0..*`) desde `PRODUCTO` | **`N:M` resuelta** |
| `USUARIO` | radica | `SOLICITUD_SERVICIO` | `0..1` (`o\|`) opcional a `0..*` (`o<`) | `1:N` |
| `USUARIO` | reporta | `REPORTE_CONTADOR` | `1` (`\|\|`) obligatorio a `0..*` (`o<`) | `1:N` *(solo clientes autenticados)* |

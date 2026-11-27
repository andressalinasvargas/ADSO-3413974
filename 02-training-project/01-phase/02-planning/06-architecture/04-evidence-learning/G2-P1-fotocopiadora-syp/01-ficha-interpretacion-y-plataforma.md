# A1 · Ficha de Interpretación del Análisis y Plataforma Tecnológica (`Fotocopiadora SyP`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP** — Ficha `3413974`  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Insumo de origen:** [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) y [`G1-P2-fotocopiadora-syp/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/10-informe-analisis.md)

---

## 1. Requisitos Seleccionados del SRS (`12 RF` y `8 RNF`)

Se incorporan el **100 %** de los requisitos funcionales (`RF-01`–`RF-12`) y no funcionales (`RNF-01`–`RNF-08`) consolidados en Guía 1:

### Requisitos Funcionales (`12`)
- **`RF-01` Visualizar inicio y propuesta de valor:** Portada, carrusel informativo, accesos por categoría, resumen de servicio técnico/renting y buscador rápido.
- **`RF-02` Explorar catálogo, filtrar y comparar:** Listado paginado (`12` elementos), filtros por categoría, búsqueda en vivo y comparador técnico lado a lado.
- **`RF-03` Consultar ficha y compatibilidades:** Detalle de producto en COP, disponibilidad y equipos/insumos compatibles.
- **`RF-04` Gestionar carrito de compras persistente:** Alta/baja/cantidad (`≥ 1`), persistencia y recálculo de subtotal, IVA (`19 %`) y total.
- **`RF-05` Confirmar pedido de compra:** Entrega/facturación, métodos de pago, bloqueo de doble envío, validación de existencias y código único.
- **`RF-06` Generar y consultar cotización formal:** Cotización numerada imprimible con ocultamiento de datos sensibles a terceros no titulares.
- **`RF-07` Gestionar cuenta de usuario e historial:** Registro seguro, autenticación y consulta del historial propio.
- **`RF-08` Enviar consulta por canal de contacto:** Ubicación en mapa, WhatsApp oficial y formulario validado.
- **`RF-09` Solicitar servicio técnico y diagnóstico:** Registro de mantenimiento preventivo/correctivo, consulta de códigos de error y simulador de renting.
- **`RF-10` Reportar contadores de renting:** Registro mensual de lecturas B/N y color por clientes autenticados.
- **`RF-11` Administrar catálogo y operaciones:** Panel restringido con KPIs, gestión de catálogo/pedidos/solicitudes/contadores y exportación CSV segura.
- **`RF-12` Gestionar notificaciones de estado:** Avisos de pedidos/citas y marcado como leídas.

### Requisitos No Funcionales (`8`)
- **`RNF-01` Usabilidad:** Acceso a cualquier categoría o producto en `≤ 3` clics y jerarquía semántica clara.
- **`RNF-02` Responsividad:** Cero desbordamiento horizontal desde `320 px` y controles táctiles `24–44 px`.
- **`RNF-03` Accesibilidad:** Contraste `≥ 4.5:1` (claro/oscuro), foco visible, trampa de foco en modales y textos alternativos.
- **`RNF-04` Rendimiento:** Imágenes WebP con descarga diferida, caché offline (`sw.js`) y compresión.
- **`RNF-05` Seguridad y privacidad:** Hash+sal en claves, RBAC, control de intentos, bloqueo ante abuso y enmascaramiento de PII (`is_owner`).
- **`RNF-06` Disponibilidad y contingencia:** Respaldo de catálogo estático (`localStorage`/JSON) y canal WhatsApp cuando no hay backend activo.
- **`RNF-07` Localización:** Interfaz `es-CO`, moneda `COP` y fechas locales.
- **`RNF-08` Mantenibilidad y verificación:** Módulos desacoplados y suite automatizada E2E + regresión (`19` pruebas).

### Actores y Restricciones Clave
- **Actores (`5`):** `Visitante`, `Cliente Registrado` (especialización de visitante), `Administrador`, `Pasarela de Pagos` (secundario), `Servicio de Mensajería` (secundario).
- **Restricciones:** Operación obligatoria sin login previo para explorar catálogo, cotizar o comprar como invitado (`RNF-06`); enmascaramiento estricto de PII ante consultas públicas de cotizaciones/pedidos; cero ejecución de fórmulas CSV al exportar (`RF-11`); repositorio público libre de secretos y datos personales reales.

---

## 2. Selección y Justificación de Plataforma Tecnológica

| Capa / Dimensión | Tecnología elegida | Justificación con `4` condiciones concretas del caso `Fotocopiadora SyP` |
| :--- | :--- | :--- |
| **Lenguaje OO y Backend API** | **Python `3.12` + FastAPI (POO + Pydantic v2)** | **1.** Permite modelar explícitamente entidades OO, puertos e interfaces (`ABC`/`Protocol`) y patrones GoF (**Comando** y **Fábrica Abstracta**) con tipado estricto.<br>**2.** La validación automática de esquemas Pydantic protege `RF-05` (`cantidad >= 1`, existencia en catálogo) y `RF-10` antes de tocar la BD.<br>**3.** Genera contratos OpenAPI verificables para pruebas automatizadas (`pytest` + `Playwright`, `RNF-08`).<br>**4.** Librerías estándar maduras (`bcrypt`, `pyjwt`) resuelven `RNF-05` sin depender de componentes pesados. |
| **Base de Datos** | **Base de Datos Relacional (`PostgreSQL 16` en producción / `SQLite 3` en dev y pruebas)** | **1.** `RF-03` (compatibilidad recursiva equipo-insumo) y `RF-05`/`RF-06` (cabecera + líneas `detalle_pedido`/`detalle_cotizacion`) exigen **integridad referencial estricta** y llaves compuestas `UNIQUE`/`PK`.<br>**2.** El recálculo comercial y congelamiento de precios pactados requiere transacciones ACID para evitar sobreventa o pérdida de consistencia.<br>**3.** La tabla débil `notificacion` y las búsquedas por titularidad (`id_usuario`) se resuelven eficientemente con índices SQL y `ON DELETE CASCADE`/`RESTRICT`.<br>**4.** La auditoría administrativa (`RF-11`) requiere consultas agregadas precisas sobre pedidos, contadores y solicitudes sin duplicidad. |
| **Frontend Web / Contingencia** | **HTML5 / CSS3 / JS Modular (PWA `sw.js`)** | Responde directamente a `RNF-02` (`≥ 320 px`), `RNF-03` (`4.5:1`), `RNF-04` (`WebP` + `lazy`) y `RNF-06` (modo estático en `dist/` con respaldo `localStorage`). |

---

## 3. Lista de Entregables de Diseño (`G2-P1`)

- `A1` Ficha de interpretación y plataforma ([01-ficha-interpretacion-y-plataforma.md](01-ficha-interpretacion-y-plataforma.md))
- `A2` + `A3` Diagrama de clases OO (`24` elementos) y `2` patrones GoF ([02-diagrama-clases-y-patrones.md](02-diagrama-clases-y-patrones.md) · `.drawio` · `.svg`)
- `A4` Arquitectura Hexagonal y tabla de `8` RNF ([03-arquitectura-software.md](03-arquitectura-software.md) · `.drawio` · `.svg`)
- `A5` Vista de componentes con `7` componentes ([04-vista-componentes.md](04-vista-componentes.md) · `.drawio` · `.svg`)
- `A6` Vista de despliegue con `5` nodos ([05-vista-despliegue.md](05-vista-despliegue.md) · `.drawio` · `.svg`)
- `A7` Matriz de trazabilidad análisis → diseño ([06-matriz-trazabilidad-diseno.md](06-matriz-trazabilidad-diseno.md))

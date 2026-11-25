# Matriz de Trazabilidad Requisito → Artefactos de Análisis · Fotocopiadora SyP

Matriz elaborada según el **Anexo C** de `Plantilla_README_Entrega_G1.md`, trazando el **100 % (`12 / 12`)** de los requisitos funcionales desde su definición en el SRS hasta el caso de uso, comportamiento, modelo de dominio, entidad del MER y prototipo visual correspondiente.

---

## 1. Trazabilidad Completa (`RF-01` a `RF-12`)

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| `RF-01` Visualizar inicio y propuesta de valor | `CU-01` Consultar inicio y catálogo de productos | — *(navegación de consulta)* | — | `Categoria`, `Producto` | `CATEGORIA`, `PRODUCTO` | [Pantalla 01 (`CU-01/02`)](06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-02` Explorar catálogo, filtrar y comparar | `CU-01` Consultar inicio y catálogo de productos | — *(consulta interactiva)* | — | `Categoria`, `Producto` | `CATEGORIA`, `PRODUCTO` | [Pantalla 01 (`CU-01/02`)](06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-03` Consultar ficha y compatibilidades | `CU-01` Consultar inicio y catálogo de productos | — *(consulta interactiva)* | — | `Producto`, `Categoria` | `PRODUCTO` *(incluye recursiva compatibilidad)* | [Pantalla 01 (`CU-01/02`)](06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-04` Gestionar carrito de compras persistente | `CU-02` Gestionar carrito de compras | — *(prepara `CU-03`)* | Referenciado en `CU-03` *(precondición)* | `CarritoCompra`, `Producto` | `PRODUCTO` *(estado previo antes de `PEDIDO`/`DETALLE_PEDIDO`)* | [Pantalla 01 (`CU-01/02`)](06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-05` Confirmar pedido de compra | `CU-03` Confirmar pedido de compra, `CU-05` Consultar documento comercial | [CU-03 Confirmar pedido](01-actividad-cu03-confirmar-pedido.svg) | [Plantilla 1 (`CU-03`)](03-plantillas-casos-uso.md#plantilla-1--cu-03--confirmar-pedido-de-compra) | `Pedido`, `DetallePedido`, `Cliente`, `Producto` | `PEDIDO`, `DETALLE_PEDIDO`, `PRODUCTO`, `USUARIO` | [Pantalla 02 (`CU-03`)](06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |
| `RF-06` Generar y consultar cotización formal | `CU-04` Generar cotización formal, `CU-05` Consultar documento comercial | Flujo extendido desde `CU-02` / paralelo a `CU-03` | — *(mencionado en `CU-11` gestión)* | `Cotizacion`, `Producto`, `Cliente` | `COTIZACION`, `DETALLE_COTIZACION`, `PRODUCTO` | [Pantalla 02 (`CU-03` / opción Cotización)](06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |
| `RF-07` Gestionar cuenta de usuario e historial | `CU-06` Autenticar cuenta, `CU-07` Gestionar perfil e historial | — | Requisito previo citado en `CU-11` | `Persona`, `Cliente`, `Pedido`, `SolicitudServicio` | `USUARIO`, `PEDIDO`, `SOLICITUD_SERVICIO` | [Pantalla 02 (`CU-03`)](06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) / [Pantalla 04 (`CU-11`)](06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-08` Enviar consulta por canal de contacto | `CU-08` Enviar consulta de contacto | — | Referenciado en gestión admin (`CU-11`) | `Persona` *(remitente)*, `Administrador` | `MENSAJE_CONTACTO` | [Pantalla 03 (`CU-09` soporte directo)](06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |
| `RF-09` Solicitar servicio técnico y diagnóstico | `CU-09` Solicitar servicio técnico y diagnóstico | [CU-09 Servicio técnico](02-actividad-cu09-servicio-tecnico.svg) | [Plantilla 2 (`CU-09`)](03-plantillas-casos-uso.md#plantilla-2--cu-09--solicitar-servicio-técnico-y-diagnóstico) | `SolicitudServicio`, `Cliente`, `Producto` | `SOLICITUD_SERVICIO`, `USUARIO` | [Pantalla 03 (`CU-09`)](06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |
| `RF-10` Reportar contadores de renting | `CU-10` Reportar contadores de renting *(incluye `CU-06`)* | — | Referenciado en dominio y gestión `CU-11` | `ReporteContador`, `Cliente` | `REPORTE_CONTADOR`, `USUARIO` | [Pantalla 03 (`CU-09`/Renting)](06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) y [Pantalla 04 (`CU-11`)](06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-11` Administrar catálogo y operaciones | `CU-11` Administrar catálogo y operaciones comerciales | — *(extensión hacia `CU-12`)* | [Plantilla 3 (`CU-11`)](03-plantillas-casos-uso.md#plantilla-3--cu-11--administrar-catálogo-y-operaciones-comerciales) | `Administrador`, `Producto`, `Categoria`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador` | `USUARIO`, `CATEGORIA`, `PRODUCTO`, `PEDIDO`, `COTIZACION`, `SOLICITUD_SERVICIO`, `REPORTE_CONTADOR` | [Pantalla 04 (`CU-11`)](06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-12` Gestionar notificaciones de estado | `CU-12` Gestionar notificaciones de estado | Rama paralela en [CU-03](01-actividad-cu03-confirmar-pedido.svg) y [CU-09](02-actividad-cu09-servicio-tecnico.svg) | Punto de extensión en `CU-11` paso 5 | `Notificacion`, `Persona`, `Cliente`, `Administrador` | `NOTIFICACION` *(entidad débil)*, `USUARIO` | [Pantalla 04 (`CU-11` alertas)](06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |

---

## 2. Resumen Cuantitativo de Cobertura

- **Requisitos funcionales trazados hasta caso de uso, clase de dominio y entidad del MER:** `12 / 12` (**`100 %`**).
- **Casos de uso críticos con traza completa hasta diagrama de actividades, plantilla extendida y pantalla rotulada:** `3 / 3` (`CU-03`, `CU-09`, `CU-11`, además de `CU-01`/`CU-02` en Pantalla 01).
- **Entidades del MER sin soporte en requisitos (`huérfanas`):** `0`.
- **Clases del dominio sin trazabilidad en casos de uso o requisitos:** `0`.

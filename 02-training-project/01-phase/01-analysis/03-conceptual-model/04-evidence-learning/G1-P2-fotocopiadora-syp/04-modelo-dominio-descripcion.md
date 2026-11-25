# Modelo de Dominio Conceptual · Fotocopiadora SyP

Diagrama visual: [04-modelo-dominio.svg](04-modelo-dominio.svg) · [04-modelo-dominio.png](04-modelo-dominio.png) · Fuente editable: [04-modelo-dominio.drawio](04-modelo-dominio.drawio)

El modelo de dominio abstrae exclusivamente **conceptos del negocio, atributos conceptuales, generalizaciones, asociaciones y multiplicidades**. Por regla metodológica de análisis (`Rubricas_G1.md`, sección 7.5 y 7.10), **no incluye métodos ni claves foráneas** ni conceptos técnicos de software.

---

## 1. Catálogo de Clases Conceptuales (`12` Clases)

| # | Clase conceptual | Rol en el negocio | Atributos de negocio |
|---|---|---|---|
| 1 | `Persona` *(abstracta)* | Generalización de los actores humanos que operan con cuentas en el negocio. | `nombreCompleto`, `correoElectronico`, `telefono`, `estadoCuenta` |
| 2 | `Cliente` *(hereda de `Persona`)* | Comprador registrado o usuario titular de equipos en mantenimiento/renting. | `documentoOIdentificacionTributaria`, `direccionPrincipal`, `ciudad` |
| 3 | `Administrador` *(hereda de `Persona`)* | Personal autorizado para gestionar catálogo, órdenes, citas y analíticas. | `cargoOperativo`, `fechaUltimoIngreso` |
| 4 | `Categoria` | Agrupación comercial del catálogo (Fotocopiadoras, Impresoras, Tóners, Repuestos, Accesorios, Mantenimiento). | `codigoCategoria`, `nombreCategoria`, `ordenVisualizacion` |
| 5 | `Producto` | Bien o servicio técnico comercializable dentro de la tienda y cotizaciones. | `codigoCatalogo`, `nombreProducto`, `precioUnitario`, `especificacionTecnica`, `estadoDisponibilidad`, `activoEnCatalogo`, `modelosCompatibles` |
| 6 | `CarritoCompra` | Contenedor temporal donde el comprador reúne productos antes de ordenar o cotizar. | `fechaActualizacion`, `subtotalEstimado`, `cantidadArticulos` |
| 7 | `Pedido` | Transacción formal de compra confirmada por un cliente o visitante. | `codigoPedido`, `nombreCliente`, `direccionEntrega`, `ciudadEntrega`, `subtotal`, `impuestoIva`, `totalCobrado`, `medioPago`, `estadoPago`, `estadoDespacho`, `fechaCreacion` |
| 8 | `DetallePedido` *(clase de asociación)* | Registra el desglose exacto de cantidad y precio pactado de cada producto dentro de un pedido. | `cantidad`, `precioUnitarioPactado`, `subtotalLinea` |
| 9 | `Cotizacion` | Propuesta comercial formal numerada generada para evaluación o compra institucional. | `codigoCotizacion`, `nombreSolicitante`, `observaciones`, `subtotal`, `impuestoIva`, `totalCotizado`, `fechaEmision` |
| 10 | `SolicitudServicio` | Petición formal de mantenimiento preventivo, correctivo o revisión técnica de un equipo. | `codigoSeguimiento`, `nombreSolicitante`, `modeloEquipo`, `tipoServicio`, `fechaDeseada`, `franjaHoraria`, `descripcionFalla`, `estadoAtencion` |
| 11 | `ReporteContador` | Lectura mensual de contadores de páginas reportada por clientes con plan de renting. | `modeloEquipo`, `lecturaBlancoNegro`, `lecturaColor`, `periodoMes`, `observaciones` |
| 12 | `Notificacion` | Aviso operativo enviado a un cliente o administrador sobre eventos o cambios de estado. | `titulo`, `mensaje`, `tipoAviso`, `leida`, `fechaEmision` |

---

## 2. Relaciones y Multiplicidades Principales

| Relación | Tipo | Multiplicidad | Significado en el negocio |
|---|---|---|---|
| `Cliente --|> Persona` y `Administrador --|> Persona` | Generalización | `—` | Ambos comparten datos de identidad y acceso, diferenciando sus responsabilidades comerciales u operativas. |
| `Categoria "1" -- "1..*" Producto` | Agregación lógica | `1` a `1..*` | Toda categoría agrupa uno o más productos comercializables; cada producto pertenece a una categoría principal. |
| `CarritoCompra "1" o-- "0..*" Producto` | Agregación | `1` a `0..*` | Un carrito agrupa cero o más productos seleccionados con su cantidad provisional antes de confirmar compra o cotizar. |
| `Cliente "0..1" -- "0..*" Pedido` | Asociación | `0..1` a `0..*` | Un cliente registrado puede realizar múltiples pedidos; también existen pedidos realizados por visitantes invitados (`0..1`). |
| `Pedido "0..*" -- "1..*" Producto` *(vía `DetallePedido`)* | Clase de asociación | `1` a `1..*` | Todo pedido incluye al menos un producto con cantidad y precio unitario congelado al momento de comprar. |
| `Cotizacion "0..*" -- "1..*" Producto` | Asociación | `0..*` a `1..*` | Una cotización formal detalla uno o más productos presupuestados con cantidades y vigencia comercial. |
| `Cliente "0..1" -- "0..*" SolicitudServicio` | Asociación | `0..1` a `0..*` | Un visitante o cliente registrado puede solicitar visitas de servicio técnico asociadas a su equipo. |
| `Cliente "1" -- "0..*" ReporteContador` | Asociación | `1` a `0..*` | Solo clientes registrados en plan de renting reportan lecturas mensuales de sus equipos. |
| `Persona "1" *-- "0..*" Notificacion` | Composición | `1` a `0..*` | Toda notificación pertenece a una persona destinataria y carece de sentido comercial sin su titular. |
| `Administrador "1" -- "0..*" Producto` / `Pedido` / `SolicitudServicio` | Asociación operativa | `1` a `0..*` | El administrador mantiene el catálogo actualizado y gestiona estados y notas de seguimiento operativo. |

---

## 3. Coherencia con las Plantillas Extendidas de Casos de Uso

Todo concepto clave citado en [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md) tiene representación directa en este dominio:
- **`CU-03` Confirmar pedido de compra**: `CarritoCompra`, `Producto`, `Cliente`, `Pedido`, `DetallePedido`, `Notificacion`.
- **`CU-09` Solicitar servicio técnico y diagnóstico**: `Cliente`, `SolicitudServicio`, `Producto` (referencia de equipo/insumos), `Notificacion`.
- **`CU-11` Administrar catálogo y operaciones comerciales**: `Administrador`, `Categoria`, `Producto`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador`, `Notificacion`.

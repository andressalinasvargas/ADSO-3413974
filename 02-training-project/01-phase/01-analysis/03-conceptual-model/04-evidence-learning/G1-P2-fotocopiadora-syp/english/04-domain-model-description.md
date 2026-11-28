> **Spanish version (official rubric root):** [../04-modelo-dominio-descripcion.md](../04-modelo-dominio-descripcion.md)

# Conceptual Domain Model · Fotocopiadora SyP

Visual diagram: [../04-modelo-dominio.svg](../04-modelo-dominio.svg) · [../04-modelo-dominio.png](../04-modelo-dominio.png) · Editable source: [../04-modelo-dominio.drawio](../04-modelo-dominio.drawio)

The domain model exclusively abstracts **business concepts, conceptual attributes, generalizations, associations, and multiplicities**. By methodological analysis rule (`Rubricas_G1.md`, §7.5 and §7.10), **it contains no methods, foreign keys, or technical software concepts**.

---

## 1. Conceptual Class Catalog (`12` Classes)

| # | Conceptual class | Role in the business | Business attributes |
|---|---|---|---|
| 1 | `Persona` *(abstract)* | Generalization of human actors operating accounts in the business. | `nombreCompleto`, `correoElectronico`, `telefono`, `estadoCuenta` |
| 2 | `Cliente` *(inherits from `Persona`)* | Registered buyer or account holder of equipment under maintenance/renting. | `documentoOIdentificacionTributaria`, `direccionPrincipal`, `ciudad` |
| 3 | `Administrador` *(inherits from `Persona`)* | Authorized staff managing catalog, orders, appointments, and analytics. | `cargoOperativo`, `fechaUltimoIngreso` |
| 4 | `Categoria` | Commercial catalog grouping (Photocopiers, Printers, Toners, Spare Parts, Accessories, Maintenance). | `codigoCategoria`, `nombreCategoria`, `ordenVisualizacion` |
| 5 | `Producto` | Commercializable good or technical service within the store and quotes. | `codigoCatalogo`, `nombreProducto`, `precioUnitario`, `especificacionTecnica`, `estadoDisponibilidad`, `activoEnCatalogo`, `modelosCompatibles` |
| 6 | `CarritoCompra` | Temporary container where buyers collect products prior to ordering or quoting. | `fechaActualizacion`, `subtotalEstimado`, `cantidadArticulos` |
| 7 | `Pedido` | Formal purchase transaction confirmed by a customer or guest visitor. | `codigoPedido`, `nombreCliente`, `direccionEntrega`, `ciudadEntrega`, `subtotal`, `impuestoIva`, `totalCobrado`, `medioPago`, `estadoPago`, `estadoDespacho`, `fechaCreacion` |
| 8 | `DetallePedido` *(association class)* | Records the exact breakdown of quantity and frozen unit price for each product inside an order. | `cantidad`, `precioUnitarioPactado`, `subtotalLinea` |
| 9 | `Cotizacion` | Formal numbered commercial proposal generated for evaluation or institutional procurement. | `codigoCotizacion`, `nombreSolicitante`, `observaciones`, `subtotal`, `impuestoIva`, `totalCotizado`, `fechaEmision` |
| 10 | `SolicitudServicio` | Formal request for preventive, corrective, or diagnostic technical service on equipment. | `codigoSeguimiento`, `nombreSolicitante`, `modeloEquipo`, `tipoServicio`, `fechaDeseada`, `franjaHoraria`, `descripcionFalla`, `estadoAtencion` |
| 11 | `ReporteContador` | Monthly page counter reading reported by customers on a renting plan. | `modeloEquipo`, `lecturaBlancoNegro`, `lecturaColor`, `periodoMes`, `observaciones` |
| 12 | `Notificacion` | Operational notice sent to a customer or administrator regarding events or status changes. | `titulo`, `mensaje`, `tipoAviso`, `leida`, `fechaEmision` |

---

## 2. Main Relationships and Multiplicities

| Relationship | Type | Multiplicity | Business meaning |
|---|---|---|---|
| `Cliente --|> Persona` & `Administrador --|> Persona` | Generalization | `—` | Both share identity and access details while differentiating commercial vs. operational duties. |
| `Categoria "1" -- "1..*" Producto` | Logical aggregation | `1` to `1..*` | Every category groups one or more products; each product belongs to a main category. |
| `CarritoCompra "1" o-- "0..*" Producto` | Aggregation | `1` to `0..*` | A cart groups zero or more selected products with provisional quantity before checkout or quoting. |
| `Cliente "0..1" -- "0..*" Pedido` | Association | `0..1` to `0..*` | A registered customer can place many orders; guest visitors (`0..1`) can also place orders. |
| `Pedido "0..*" -- "1..*" Producto` *(via `DetallePedido`)* | Association class | `1` to `1..*` | Every order includes at least one product with quantity and unit price frozen at checkout. |
| `Cotizacion "0..*" -- "1..*" Producto` | Association | `0..*` to `1..*` | A formal quote details one or more budgeted products with quantities and commercial validity. |
| `Cliente "0..1" -- "0..*" SolicitudServicio` | Association | `0..1` to `0..*` | A visitor or registered customer can request technical service visits associated with equipment. |
| `Cliente "1" -- "0..*" ReporteContador` | Association | `1` to `0..*` | Only registered customers on a renting plan report monthly equipment counter readings. |
| `Persona "1" *-- "0..*" Notificacion` | Composition | `1` to `0..*` | Every notification belongs to a recipient person and has no business existence without its owner. |
| `Administrador "1" -- "0..*" Producto` / `Pedido` / `SolicitudServicio` | Operational association | `1` to `0..*` | The administrator keeps the catalog updated and manages operational statuses and follow-up notes. |

---

## 3. Consistency with Extended Use Case Templates

Every key concept referenced in [03-extended-use-case-templates.md](03-extended-use-case-templates.md) is directly represented in this domain model:
- **`CU-03` Confirm purchase order**: `CarritoCompra`, `Producto`, `Cliente`, `Pedido`, `DetallePedido`, `Notificacion`.
- **`CU-09` Request technical service**: `Cliente`, `SolicitudServicio`, `Producto` (equipment/supplies reference), `Notificacion`.
- **`CU-11` Administer catalog & operations**: `Administrador`, `Categoria`, `Producto`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador`, `Notificacion`.

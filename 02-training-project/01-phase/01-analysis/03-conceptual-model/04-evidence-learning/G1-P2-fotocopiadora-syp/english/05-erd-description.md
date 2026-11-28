> **Spanish version (official rubric root):** [../05-mer-descripcion.md](../05-mer-descripcion.md)

# Entity-Relationship Model (ERD) · Fotocopiadora SyP

Visual diagram: [../05-modelo-entidad-relacion.svg](../05-modelo-entidad-relacion.svg) · [../05-modelo-entidad-relacion.png](../05-modelo-entidad-relacion.png) · Editable source: [../05-modelo-entidad-relacion.drawio](../05-modelo-entidad-relacion.drawio)

- **Declared notation:** **Crow's Foot** — uses double bars (`||` mandatory/total participation) and circles (`o|` optional/partial participation) alongside crow's feet (`|<` mandatory one-or-many, `o<` optional zero-or-many).
- **`N:M` resolution**: many-to-many relationships between commercial transactions and products are resolved via associative entities carrying own attributes (`DETALLE_PEDIDO` and `DETALLE_COTIZACION`).
- **Weak entity**: `NOTIFICACION` is an existentially dependent weak entity of `USUARIO` (uses a per-user discriminator within a composite key and cascades deletion with its owner).
- **Recursive relationship**: `PRODUCTO` maintains a recursive compatibility association (`compatibilidad`) between multifunctional equipment and compatible supplies/spare parts.

*(Schema identifiers stay in Spanish as used in the diagrams and database model; English glosses are provided in parentheses).*

---

## 1. Entities, Identifiers, and Attributes (`11` Entities)

| Entity | Type | Identifier (`PK`) | Foreign keys (`FK`) | Main attributes |
|---|---|---|---|---|
| `USUARIO` *(User)* | Strong | `id_usuario` | `—` | `correo_unico`, `clave_cifrada`, `nombre_completo`, `telefono`, `rol`, `activo`, `fecha_creacion`, `ultimo_acceso` |
| `CATEGORIA` *(Category)* | Strong | `id_categoria` | `—` | `slug_unico`, `nombre`, `orden_visual` |
| `PRODUCTO` *(Product)* | Strong *(recursive)* | `id_producto` | `id_categoria` (→ `CATEGORIA`) | `nombre`, `marca`, `precio_cop`, `especificacion`, `estado_stock`, `activo`, `velocidad_ppm`, `rendimiento_toner` |
| `PEDIDO` *(Order)* | Strong | `id_pedido` | `id_usuario` *(optional, guests `NULL`)* | `codigo_pedido_unico`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega`, `subtotal`, `iva`, `total`, `metodo_pago`, `estado_pago`, `estado_envio`, `fecha_creacion` |
| `DETALLE_PEDIDO` *(Order Line)* | Associative (`N:M` resolved) | `(id_pedido, id_producto)` | `id_pedido`, `id_producto` | `cantidad`, `precio_unitario_pactado`, `subtotal_linea`, `especificacion_linea` |
| `COTIZACION` *(Quote)* | Strong | `id_cotizacion` | `id_usuario` *(optional)* | `codigo_cotizacion_unico`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `subtotal`, `iva`, `total`, `observaciones`, `fecha_creacion` |
| `DETALLE_COTIZACION` *(Quote Line)* | Associative (`N:M` resolved) | `(id_cotizacion, id_producto)` | `id_cotizacion`, `id_producto` | `cantidad`, `precio_unitario_cotizado`, `subtotal_linea`, `especificacion_linea` |
| `SOLICITUD_SERVICIO` *(Service Request)* | Strong | `id_solicitud` | `id_usuario` *(optional)* | `equipo`, `tipo_servicio`, `fecha_deseada`, `franja_horaria`, `descripcion_problema`, `estado_atencion`, `notas_admin`, `fecha_creacion` |
| `REPORTE_CONTADOR` *(Counter Report)* | Strong | `id_reporte` | `id_usuario` *(mandatory)* | `modelo_equipo`, `contador_bn`, `contador_color`, `mes_reportado`, `observaciones`, `fecha_creacion` |
| `NOTIFICACION` *(Notification)* | **Weak** *(depends on `USUARIO`)* | `(id_usuario, id_notificacion)` | `id_usuario` *(identifying)* | `titulo`, `mensaje`, `tipo`, `enlace_destino`, `leida`, `fecha_creacion` |
| `MENSAJE_CONTACTO` *(Contact Message)* | Strong *(standalone)* | `id_mensaje` | `—` | `nombre`, `correo`, `telefono`, `asunto`, `mensaje`, `leido`, `fecha_creacion` |

---

## 2. Cardinality and Participation (Crow's Foot)

| Relationship | Entity A (participation & cardinality) | Entity B (participation & cardinality) | Business rationale |
|---|---|---|---|
| `CATEGORIA` — `PRODUCTO` | `CATEGORIA` `(1..1, total)` | `PRODUCTO` `(1..*, total)` | Each product belongs to exactly one category; each category groups catalog products. |
| `PRODUCTO` — `PRODUCTO` *(recursive)* | `PRODUCTO` *(equipment)* `(0..*, partial)` | `PRODUCTO` *(supply/part)* `(0..*, partial)` | A multifunctional device can be compatible with zero or many catalog toners/parts. |
| `USUARIO` — `PEDIDO` | `USUARIO` `(0..1, partial)` | `PEDIDO` `(0..*, partial)` | A customer can have zero or many orders; an order can come from an unregistered guest (`0..1`). |
| `PEDIDO` — `DETALLE_PEDIDO` — `PRODUCTO` | `PEDIDO` `(1..1)` ↔ `DETALLE_PEDIDO` `(1..*, total)` | `PRODUCTO` `(1..1)` ↔ `DETALLE_PEDIDO` `(0..*, partial)` | Resolves `N:M`: an order has at least 1 detail line with own quantity and price; a product may appear in 0 or more orders. |
| `COTIZACION` — `DETALLE_COTIZACION` — `PRODUCTO` | `COTIZACION` `(1..1)` ↔ `DETALLE_COTIZACION` `(1..*, total)` | `PRODUCTO` `(1..1)` ↔ `DETALLE_COTIZACION` `(0..*, partial)` | Resolves `N:M`: every quote includes at least one quoted item with line attributes. |
| `USUARIO` — `SOLICITUD_SERVICIO` | `USUARIO` `(0..1, partial)` | `SOLICITUD_SERVICIO` `(0..*, partial)` | Visitors or registered customers may file technical service requests optionally tied to an account. |
| `USUARIO` — `REPORTE_CONTADOR` | `USUARIO` `(1..1, total)` | `REPORTE_CONTADOR` `(0..*, partial)` | Every monthly counter report requires an authenticated owner customer. |
| `USUARIO` == `NOTIFICACION` *(identifying)* | `USUARIO` `(1..1, total)` | `NOTIFICACION` `(0..*, partial)` | Weak entity: no notification exists without a recipient user, embedding `id_usuario` inside its composite PK. |

*Normalization & traceability note:* `MENSAJE_CONTACTO` remains an autonomous inbox entity receiving inquiries from anonymous visitors without requiring an account (`RF-08`).

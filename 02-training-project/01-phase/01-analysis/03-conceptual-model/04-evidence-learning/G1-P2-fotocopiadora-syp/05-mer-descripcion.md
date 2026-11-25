# Modelo Entidad-Relación (MER) · Fotocopiadora SyP

Diagrama visual: [05-modelo-entidad-relacion.svg](05-modelo-entidad-relacion.svg) · [05-modelo-entidad-relacion.png](05-modelo-entidad-relacion.png) · Fuente editable: [05-modelo-entidad-relacion.drawio](05-modelo-entidad-relacion.drawio)

- **Notación declarada:** **Pata de gallo (Crow's Foot)** — utiliza barras (`||` participación total / obligatoria) y círculos (`o|` participación parcial / opcional) junto a patas de gallo (`|<` uno o muchos obligatorio, `o<` cero o muchos opcional).
- **Resolución `N:M`**: las relaciones muchos a muchos entre transacciones comerciales y productos se resuelven mediante entidades asociativas con atributos propios (`DETALLE_PEDIDO` y `DETALLE_COTIZACION`).
- **Entidad débil**: `NOTIFICACION` es entidad débil dependiente existencialmente de `USUARIO` (lleva identificador discriminador por usuario y su borrado depende de la existencia del titular).
- **Relación recursiva**: `PRODUCTO` mantiene asociación recursiva de compatibilidad (`compatibilidad`) entre equipos multifuncionales e insumos/repuestos compatibles.

---

## 1. Entidades, Identificadores y Atributos (`11` Entidades)

| Entidad | Tipo | Identificador (`PK`) | Llaves foráneas (`FK`) | Atributos principales |
|---|---|---|---|---|
| `USUARIO` | Fuerte | `id_usuario` | `—` | `correo_unico`, `clave_cifrada`, `nombre_completo`, `telefono`, `rol`, `activo`, `fecha_creacion`, `ultimo_acceso` |
| `CATEGORIA` | Fuerte | `id_categoria` | `—` | `slug_unico`, `nombre`, `orden_visual` |
| `PRODUCTO` | Fuerte *(con recursiva)* | `id_producto` | `id_categoria` (→ `CATEGORIA`) | `nombre`, `marca`, `precio_cop`, `especificacion`, `estado_stock`, `activo`, `velocidad_ppm`, `rendimiento_toner` |
| `PEDIDO` | Fuerte | `id_pedido` | `id_usuario` *(opcional, invitados `NULL`)* | `codigo_pedido_unico`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega`, `subtotal`, `iva`, `total`, `metodo_pago`, `estado_pago`, `estado_envio`, `fecha_creacion` |
| `DETALLE_PEDIDO` | Asociativa (`N:M` resuelta) | `(id_pedido, id_producto)` | `id_pedido`, `id_producto` | `cantidad`, `precio_unitario_pactado`, `subtotal_linea`, `especificacion_linea` |
| `COTIZACION` | Fuerte | `id_cotizacion` | `id_usuario` *(opcional)* | `codigo_cotizacion_unico`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `subtotal`, `iva`, `total`, `observaciones`, `fecha_creacion` |
| `DETALLE_COTIZACION` | Asociativa (`N:M` resuelta) | `(id_cotizacion, id_producto)` | `id_cotizacion`, `id_producto` | `cantidad`, `precio_unitario_cotizado`, `subtotal_linea`, `especificacion_linea` |
| `SOLICITUD_SERVICIO` | Fuerte | `id_solicitud` | `id_usuario` *(opcional)* | `equipo`, `tipo_servicio`, `fecha_deseada`, `franja_horaria`, `descripcion_problema`, `estado_atencion`, `notas_admin`, `fecha_creacion` |
| `REPORTE_CONTADOR` | Fuerte | `id_reporte` | `id_usuario` *(obligatoria)* | `modelo_equipo`, `contador_bn`, `contador_color`, `mes_reportado`, `observaciones`, `fecha_creacion` |
| `NOTIFICACION` | **Débil** *(depende de `USUARIO`)* | `(id_usuario, id_notificacion)` | `id_usuario` *(identificadora)* | `titulo`, `mensaje`, `tipo`, `enlace_destino`, `leida`, `fecha_creacion` |
| `MENSAJE_CONTACTO` | Fuerte *(registro independiente)* | `id_mensaje` | `—` | `nombre`, `correo`, `telefono`, `asunto`, `mensaje`, `leido`, `fecha_creacion` |

---

## 2. Cardinalidad y Participación Declarada (Crow's Foot)

| Relación | Entidad A (participación y cardinalidad) | Entidad B (participación y cardinalidad) | Justificación de negocio |
|---|---|---|---|
| `CATEGORIA` — `PRODUCTO` | `CATEGORIA` `(1..1, total)` | `PRODUCTO` `(1..*, total)` | Cada producto pertenece exactamente a una categoría; cada categoría agrupa productos del catálogo. |
| `PRODUCTO` — `PRODUCTO` *(recursiva)* | `PRODUCTO` *(equipo)* `(0..*, parcial)` | `PRODUCTO` *(insumo/repuesto)* `(0..*, parcial)` | Un equipo multifuncional puede ser compatible con cero o varios tóners/repuestos del catálogo. |
| `USUARIO` — `PEDIDO` | `USUARIO` `(0..1, parcial)` | `PEDIDO` `(0..*, parcial)` | Un cliente puede tener cero o muchos pedidos; un pedido puede provenir de un visitante sin cuenta (`0..1`). |
| `PEDIDO` — `DETALLE_PEDIDO` — `PRODUCTO` | `PEDIDO` `(1..1)` ↔ `DETALLE_PEDIDO` `(1..*, total)` | `PRODUCTO` `(1..1)` ↔ `DETALLE_PEDIDO` `(0..*, parcial)` | Resuelve relación `N:M`: un pedido tiene al menos 1 línea de detalle con cantidad y precio propio; un producto puede figurar en 0 o más pedidos. |
| `COTIZACION` — `DETALLE_COTIZACION` — `PRODUCTO` | `COTIZACION` `(1..1)` ↔ `DETALLE_COTIZACION` `(1..*, total)` | `PRODUCTO` `(1..1)` ↔ `DETALLE_COTIZACION` `(0..*, parcial)` | Resuelve relación `N:M`: toda cotización incluye al menos un ítem cotizado con atributos propios de línea. |
| `USUARIO` — `SOLICITUD_SERVICIO` | `USUARIO` `(0..1, parcial)` | `SOLICITUD_SERVICIO` `(0..*, parcial)` | Visitantes o clientes registrados pueden radicar solicitudes técnicas asociadas opcionalmente a una cuenta. |
| `USUARIO` — `REPORTE_CONTADOR` | `USUARIO` `(1..1, total)` | `REPORTE_CONTADOR` `(0..*, parcial)` | Todo reporte mensual de contador exige un cliente titular autenticado. |
| `USUARIO` == `NOTIFICACION` *(identificadora)* | `USUARIO` `(1..1, total)` | `NOTIFICACION` `(0..*, parcial)` | Entidad débil: no existe notificación sin usuario destinatario, integrando su identificador dentro de la clave compuesta. |

*Nota de normalización y trazabilidad:* `MENSAJE_CONTACTO` permanece como entidad autónoma de bandeja inicial recibida desde visitantes anónimos sin requerir cuenta previa (`RF-08`).

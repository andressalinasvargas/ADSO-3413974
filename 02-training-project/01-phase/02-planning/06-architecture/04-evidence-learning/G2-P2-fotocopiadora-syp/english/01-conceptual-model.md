> **Spanish version (official rubric root):** [../01-modelo-conceptual.md](../01-modelo-conceptual.md)

# B1 · Adjusted Conceptual Model (`Fotocopiadora SyP`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593101`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Conceptual diagram:** [../01-modelo-conceptual.svg](../01-modelo-conceptual.svg) · **Editable source:** [../01-modelo-conceptual.drawio](../01-modelo-conceptual.drawio)

---

## 1. Database Type Justification (Relational)

A **Relational Database Management System (`PostgreSQL 16` in production / `SQLite 3` in dev & validation)** is selected over a NoSQL document store for four concrete reasons of `Fotocopiadora SyP`:

1. **Strict header–line integrity (`RF-05`, `RF-06`):** Every `PEDIDO` *(Order)* and `COTIZACION` *(Quote)* must guarantee the real existence of referenced `PRODUCTO`s and preserve the agreed unit price inside `DETALLE_PEDIDO` / `DETALLE_COTIZACION`.
2. **Explicit `N:M` and recursive resolution (`RF-03`):** Equipment–supply compatibility (`PRODUCTO ↔ PRODUCTO`) and per-transaction item breakdowns are cleanly modeled with bridge tables and referential integrity.
3. **Engine-enforced business rules (`CHECK` and `UNIQUE`):** Unique codes (`codigo_pedido`, `codigo_cotizacion`, `codigo_seguimiento`), monthly uniqueness per customer and machine in `REPORTE_CONTADOR`, and domain bounds (`cantidad >= 1`, `total >= subtotal`).
4. **Ownership control and audit (`RF-11`, `RNF-05`):** Supports ownership checks (`id_usuario`) to mask PII from third parties and generate aggregate/safe CSV reports via parameterized SQL queries.

---

## 2. Catalog of `11` Entities & Requirement Traceability (`G1-P2 → G2-P2`)

*(Entity and attribute identifiers match the Crow's Foot diagram and SQL script).*

| # | Entity | Type | Identifier | Key attributes | Supported requirements |
| :- | :--- | :--- | :--- | :--- | :--- |
| `1` | **`USUARIO`** *(User)* | Strong | `id_usuario` | `correo_unico`, `clave_hash`, `nombre_completo`, `telefono`, `rol`, `activo`, `fecha_creacion`, `ultimo_acceso` | `RF-07`, `RF-11`, `RNF-05` |
| `2` | **`NOTIFICACION`** *(Notification)* | **Weak** *(depends on `USUARIO`)* | `(id_usuario, id_notificacion)` | `titulo`, `mensaje`, `tipo`, `enlace_destino`, `leida`, `fecha_creacion` | `RF-05`, `RF-09`, `RF-12` |
| `3` | **`CATEGORIA`** *(Category)* | Strong | `id_categoria` | `slug_unico`, `nombre`, `orden_visual` | `RF-01`, `RF-02` |
| `4` | **`PRODUCTO`** *(Product)* | Strong *(recursive)* | `id_producto` | `codigo_sku`, `nombre`, `marca`, `precio_cop`, `especificacion`, `estado_stock`, `activo`, `velocidad_ppm`, `rendimiento_toner` | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RF-11` |
| `5` | **`PEDIDO`** *(Order)* | Strong | `id_pedido` | `codigo_pedido`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega`, `subtotal`, `iva`, `total`, `metodo_pago`, `estado_pago`, `estado_envio`, `fecha_creacion` | `RF-05`, `RF-11` |
| `6` | **`DETALLE_PEDIDO`** *(Order Detail)* | Associative (`N:M`) | `(id_pedido, id_producto)` | `cantidad`, `precio_unitario_pactado`, `subtotal_linea`, `especificacion_linea` | `RF-05`, `RF-11` |
| `7` | **`COTIZACION`** *(Quote)* | Strong | `id_cotizacion` | `codigo_cotizacion`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `subtotal`, `iva`, `total`, `observaciones`, `vigencia_dias`, `fecha_creacion` | `RF-06`, `RF-11` |
| `8` | **`DETALLE_COTIZACION`** *(Quote Detail)* | Associative (`N:M`) | `(id_cotizacion, id_producto)` | `cantidad`, `precio_unitario_cotizado`, `subtotal_linea`, `especificacion_linea` | `RF-06`, `RF-11` |
| `9` | **`SOLICITUD_SERVICIO`** *(Service Request)* | Strong | `id_solicitud` | `codigo_seguimiento`, `nombre_solicitante`, `telefono_contacto`, `modelo_equipo`, `tipo_servicio`, `fecha_deseada`, `franja_horaria`, `descripcion_problema`, `estado_atencion`, `notas_admin`, `fecha_creacion` | `RF-09`, `RF-11` |
| `10` | **`REPORTE_CONTADOR`** *(Counter Report)* | Strong | `id_reporte` | `modelo_equipo`, `contador_bn`, `contador_color`, `mes_reportado`, `observaciones`, `fecha_creacion` | `RF-10`, `RF-11` |
| `11` | **`MENSAJE_CONTACTO`** *(Contact Message)* | Strong *(standalone)* | `id_mensaje` | `nombre`, `correo`, `telefono`, `asunto`, `mensaje`, `leido`, `fecha_creacion` | `RF-08`, `RF-11` |

---

## 3. Relationships, Verbs, and Min/Max Cardinalities (`Crow's Foot`)

| Entity A | Verb | Entity B | Cardinality & participation | Type |
| :--- | :--- | :--- | :--- | :---: |
| `USUARIO` | generates | `NOTIFICACION` | `1` (`\|\|`) mandatory to `0..*` (`o<`) | `1:N` identifying (weak) |
| `CATEGORIA` | groups | `PRODUCTO` | `1` (`\|\|`) mandatory to `1..*` (`\|<`) | `1:N` |
| `PRODUCTO` | is compatible with | `PRODUCTO` | `0..*` (`o<`) to `0..*` (`o<`) | **Recursive `N:M`** |
| `USUARIO` | places | `PEDIDO` | `0..1` (`o\|`) optional to `0..*` (`o<`) | `1:N` *(allows guests)* |
| `PEDIDO` ↔ `PRODUCTO` | includes | `DETALLE_PEDIDO` | `1:N` (`1..*`) from `PEDIDO` and `1:N` (`0..*`) from `PRODUCTO` | **Resolved `N:M`** |
| `USUARIO` | requests | `COTIZACION` | `0..1` (`o\|`) optional to `0..*` (`o<`) | `1:N` *(allows guests)* |
| `COTIZACION` ↔ `PRODUCTO` | details | `DETALLE_COTIZACION` | `1:N` (`1..*`) from `COTIZACION` and `1:N` (`0..*`) from `PRODUCTO` | **Resolved `N:M`** |
| `USUARIO` | files | `SOLICITUD_SERVICIO` | `0..1` (`o\|`) optional to `0..*` (`o<`) | `1:N` |
| `USUARIO` | reports | `REPORTE_CONTADOR` | `1` (`\|\|`) mandatory to `0..*` (`o<`) | `1:N` *(authenticated only)* |

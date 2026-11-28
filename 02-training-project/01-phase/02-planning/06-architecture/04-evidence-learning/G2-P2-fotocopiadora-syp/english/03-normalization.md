> **Spanish version (official rubric root):** [../03-normalizacion.md](../03-normalizacion.md)

# B3 · Step-by-Step Normalization Evidence (`0NF → 1NF → 2NF → 3NF`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593101`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`

Two custom tables from `Fotocopiadora SyP` are normalized step by step: one with a **composite primary key** (`planilla_cotizacion_bruta`) to eliminate partial dependencies (`2NF`), and one with **transitive dependencies** (`registro_servicio_tecnico_bruto`) to demonstrate `3NF`.

---

## Case 1 · Composite-Key Normalization (`planilla_cotizacion_bruta`)

### Initial State (`0NF`)
Raw commercial spreadsheet used when consolidating quoted items prior to normalization:

> `planilla_cotizacion_bruta(`**`id_cotizacion`**, **`id_producto`**, `codigo_cotizacion, fecha_creacion, nombre_cliente, correo_cliente, observaciones, codigo_sku, nombre_producto, marca_producto, compatibilidades_texto, precio_lista_cop, cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea)`
>
> - **Composite primary key:** `(id_cotizacion, id_producto)`.
> - **Repeating / non-atomic group:** `compatibilidades_texto` packs multiple compatible toner/spare-part SKUs into one cell separated by commas (`"SKU-T01, SKU-T02"`).

### Step `0NF → 1NF` (Eliminate Repeating Groups & Achieve Atomicity)
- **Violation:** `compatibilidades_texto` holds multi-valued, non-atomic entries.
- **Fix:** extract the equipment–supply relation into **`compatibilidad_producto(id_equipo, id_insumo, nota_tecnica)`** referencing `producto`.
- **1NF outcome:** every cell holds a single atomic value.

### Step `1NF → 2NF` (Eliminate Partial Functional Dependencies on Composite Key)
- **Functional dependencies (`FD`) over `(id_cotizacion, id_producto)`:**
  - **`DF1` (partial on `id_cotizacion`):** `id_cotizacion → codigo_cotizacion, fecha_creacion, nombre_cliente, correo_cliente, observaciones, id_usuario`
  - **`DF2` (partial on `id_producto`):** `id_producto → codigo_sku, nombre_producto, marca_producto, precio_lista_cop, id_categoria`
  - **`DF3` (full on `(id_cotizacion, id_producto)`):** `(id_cotizacion, id_producto) → cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea`
- **Violation:** header fields (`DF1`) and catalog fields (`DF2`) depend on only half of the composite key, creating massive redundancy per quoted line.
- **Decomposition by FD:**
  - `cotizacion(`**`id_cotizacion`**`, id_usuario, codigo_cotizacion, nombre_cliente, correo_cliente, telefono_cliente, subtotal, iva, total, observaciones, vigencia_dias, fecha_creacion)`
  - `producto(`**`id_producto`**`, id_categoria, codigo_sku, nombre, marca, precio_cop, especificacion, estado_stock, activo, velocidad_ppm, rendimiento_toner)`
  - `detalle_cotizacion(`**`id_cotizacion, id_producto`**`, cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea)`

### Step `2NF → 3NF` (Eliminate Transitive Dependencies)
- **Detected transitive dependency:** `producto` previously stored category name and slug inline: `id_producto → id_categoria → slug_unico, nombre_categoria, orden_visual`.
- **Fix:** extract `categoria(`**`id_categoria`**`, slug_unico, nombre, orden_visual)` leaving only `id_categoria` as an FK in `producto`.
- **3NF outcome:** every non-key attribute depends on the key, the whole key, and nothing but the key.

---

## Case 2 · Transitive-Dependency Normalization (`registro_servicio_tecnico_bruto`)

### Initial State (`0NF`)
Flat workshop intake log for technical service requests:

> `registro_servicio_tecnico_bruto(`**`id_solicitud`**`, codigo_seguimiento, id_usuario, correo_cliente, nombre_cliente, telefono_cliente, rol_usuario, ultimos_avisos_texto, modelo_equipo, tipo_servicio, fecha_deseada, franja_horaria, descripcion_problema, estado_atencion, notas_admin)`
>
> - **Simple primary key:** `id_solicitud`.
> - **Repeating group:** `ultimos_avisos_texto` concatenates multiple alerts sent to the customer inside one field.

### Step `0NF → 1NF` (Atomicity)
- **Violation:** `ultimos_avisos_texto` stores multiple non-atomic notifications in a single column.
- **Fix:** extract `notificacion(`**`id_usuario, id_notificacion`**`, titulo, mensaje, tipo, enlace_destino, leida, fecha_creacion)` as a weak entity tied to `usuario`.

### Step `1NF → 2NF` (Simple Key)
- Because `id_solicitud` is a non-composite single attribute, no partial key dependencies remain: satisfies **2NF**.

### Step `2NF → 3NF` (Eliminate Transitive Dependencies)
- **Explicit transitive dependency:**
  - **`id_solicitud → id_usuario → correo_cliente, rol_usuario, clave_hash, activo`**
  - Changing a registered user's email or status would otherwise require updating every historical service ticket manually.
- **Fix:** keep `usuario(`**`id_usuario`**`, correo_unico, clave_hash, nombre_completo, telefono, rol, activo, fecha_creacion, ultimo_acceso)` and retain in `solicitud_servicio` only the nullable FK `id_usuario` plus field-contact fields needed when `id_usuario IS NULL` (guest requests).

---

## Justified Historical Integrity Note (`precio_unitario_pactado` / `subtotal_linea`)

Both `detalle_pedido` and `detalle_cotizacion` store **`precio_unitario_pactado` / `precio_unitario_cotizado`** and **`subtotal_linea`** even though live catalog prices reside in `producto.precio_cop`. **Justification:** if catalog prices update weeks later due to inflation or FX shifts, an already-paid order (`RF-05`) or an active quote (`RF-06`) **must never retroactively mutate its historical amounts**.

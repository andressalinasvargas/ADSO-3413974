> **Spanish version (official rubric root):** [../02-modelo-logico-y-transformacion.md](../02-modelo-logico-y-transformacion.md)

# B2 · Relational Logical Model & Transformation Rules (`12` Tables)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593101`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Logical diagram:** [../02-modelo-logico.svg](../02-modelo-logico.svg) · **Editable source:** [../02-modelo-logico.drawio](../02-modelo-logico.drawio)

---

## 1. Relational Logical Schema (`12` Tables in 3NF)

1. **`usuario`**(`PK id_usuario`, `correo_unico`, `clave_hash`, `nombre_completo`, `telefono`, `rol`, `activo`, `fecha_creacion`, `ultimo_acceso`)
2. **`notificacion`**(`PK (id_usuario, id_notificacion)`, `FK id_usuario -> usuario`, `titulo`, `mensaje`, `tipo`, `enlace_destino`, `leida`, `fecha_creacion`)
3. **`categoria`**(`PK id_categoria`, `slug_unico`, `nombre`, `orden_visual`)
4. **`producto`**(`PK id_producto`, `FK id_categoria -> categoria`, `codigo_sku`, `nombre`, `marca`, `precio_cop`, `especificacion`, `estado_stock`, `activo`, `velocidad_ppm`, `rendimiento_toner`)
5. **`compatibilidad_producto`**(`PK (id_equipo, id_insumo)`, `FK id_equipo -> producto`, `FK id_insumo -> producto`, `nota_tecnica`)
6. **`pedido`**(`PK id_pedido`, `FK id_usuario -> usuario NULL`, `codigo_pedido`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega`, `subtotal`, `iva`, `total`, `metodo_pago`, `estado_pago`, `estado_envio`, `fecha_creacion`)
7. **`detalle_pedido`**(`PK (id_pedido, id_producto)`, `FK id_pedido -> pedido`, `FK id_producto -> producto`, `cantidad`, `precio_unitario_pactado`, `subtotal_linea`, `especificacion_linea`)
8. **`cotizacion`**(`PK id_cotizacion`, `FK id_usuario -> usuario NULL`, `codigo_cotizacion`, `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `subtotal`, `iva`, `total`, `observaciones`, `vigencia_dias`, `fecha_creacion`)
9. **`detalle_cotizacion`**(`PK (id_cotizacion, id_producto)`, `FK id_cotizacion -> cotizacion`, `FK id_producto -> producto`, `cantidad`, `precio_unitario_cotizado`, `subtotal_linea`, `especificacion_linea`)
10. **`solicitud_servicio`**(`PK id_solicitud`, `FK id_usuario -> usuario NULL`, `codigo_seguimiento`, `nombre_solicitante`, `telefono_contacto`, `modelo_equipo`, `tipo_servicio`, `fecha_deseada`, `franja_horaria`, `descripcion_problema`, `estado_atencion`, `notas_admin`, `fecha_creacion`)
11. **`reporte_contador`**(`PK id_reporte`, `FK id_usuario -> usuario`, `modelo_equipo`, `contador_bn`, `contador_color`, `mes_reportado`, `observaciones`, `fecha_creacion`)
12. **`mensaje_contacto`**(`PK id_mensaje`, `nombre`, `correo`, `telefono`, `asunto`, `mensaje`, `leido`, `fecha_creacion`)

---

## 2. Applied Transformation Rules Summary (`B1 → B2`)

| # | Applied rule | Source in `B1` (Conceptual) | Result in `B2` (Logical) | Declared referential action |
| :- | :--- | :--- | :--- | :--- |
| **1** | **Strong entity → table with simple PK** | `USUARIO`, `CATEGORIA`, `PRODUCTO`, `PEDIDO`, `COTIZACION`, `SOLICITUD_SERVICIO`, `REPORTE_CONTADOR`, `MENSAJE_CONTACTO` | `8` homonymous singular `snake_case` tables with surrogate key `id_*` | — |
| **2** | **Mandatory `1:N` → `NOT NULL` FK** | `CATEGORIA ── PRODUCTO` & `USUARIO ── REPORTE_CONTADOR` | `producto.id_categoria` and `reporte_contador.id_usuario` (`NOT NULL`) | `ON DELETE RESTRICT ON UPDATE CASCADE` |
| **3** | **Optional `0..1:N` → Nullable FK (`NULL`)** | `USUARIO ── PEDIDO`, `USUARIO ── COTIZACION`, `USUARIO ── SOLICITUD_SERVICIO` | `id_usuario` allows `NULL` for guest orders, quotes, and service appointments | `ON DELETE SET NULL ON UPDATE CASCADE` |
| **4** | **`N:M` with attributes → bridge table with composite PK** | `PEDIDO ↔ PRODUCTO` (`DETALLE_PEDIDO`) & `COTIZACION ↔ PRODUCTO` (`DETALLE_COTIZACION`) | `detalle_pedido` (`PK (id_pedido, id_producto)`) and `detalle_cotizacion` (`PK (id_cotizacion, id_producto)`) | `CASCADE` from header; `RESTRICT` from `producto` |
| **5** | **Recursive `N:M` → self-referencing bridge table** | `PRODUCTO ↔ PRODUCTO` (`compatibilidad`) | **`compatibilidad_producto(id_equipo, id_insumo, nota_tecnica)`** with `CHECK (id_equipo <> id_insumo)` | `ON DELETE CASCADE ON UPDATE CASCADE` |
| **6** | **Weak entity → composite PK with identifying FK** | `NOTIFICACION` dependent on `USUARIO` | `notificacion` with **`PK (id_usuario, id_notificacion)`** | `ON DELETE CASCADE ON UPDATE CASCADE` |
| **7** | **Frozen historical attributes documented** | `subtotal_linea` and `precio_unitario_*` in detail tables | Preserved in `detalle_pedido` and `detalle_cotizacion` to keep historical agreed price intact | Documented in [03-normalization.md](03-normalization.md) |

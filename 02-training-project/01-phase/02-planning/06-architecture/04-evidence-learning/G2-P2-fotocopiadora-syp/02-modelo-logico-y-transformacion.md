# B2 · Modelo Lógico Relacional y Reglas de Transformación (`12` Tablas)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Diagrama lógico:** [02-modelo-logico.svg](02-modelo-logico.svg) · **Fuente editable:** [02-modelo-logico.drawio](02-modelo-logico.drawio)

---

## 1. Esquema Lógico Relacional (`12` Tablas en 3FN)

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

## 2. Cuadro de Reglas de Transformación Aplicadas (`B1 → B2`)

| # | Regla aplicada | Elemento en `B1` (Conceptual) | Resultado en `B2` (Lógico) | Acción referencial declarada |
| :- | :--- | :--- | :--- | :--- |
| **1** | **Entidad fuerte → tabla con PK simple** | `USUARIO`, `CATEGORIA`, `PRODUCTO`, `PEDIDO`, `COTIZACION`, `SOLICITUD_SERVICIO`, `REPORTE_CONTADOR`, `MENSAJE_CONTACTO` | `8` tablas homónimas en `snake_case` singular con clave sustituta `id_*` | — |
| **2** | **Relación `1:N` obligatoria → FK `NOT NULL`** | `CATEGORIA ── PRODUCTO` y `USUARIO ── REPORTE_CONTADOR` | `producto.id_categoria` y `reporte_contador.id_usuario` (`NOT NULL`) | `ON DELETE RESTRICT ON UPDATE CASCADE` |
| **3** | **Relación `0..1:N` opcional → FK anulable (`NULL`)** | `USUARIO ── PEDIDO`, `USUARIO ── COTIZACION`, `USUARIO ── SOLICITUD_SERVICIO` | `id_usuario` permite `NULL` para pedidos/cotizaciones/citas de visitantes sin registro | `ON DELETE SET NULL ON UPDATE CASCADE` |
| **4** | **Relación `N:M` con atributos → tabla intermedia con PK compuesta** | `PEDIDO ↔ PRODUCTO` (`DETALLE_PEDIDO`) y `COTIZACION ↔ PRODUCTO` (`DETALLE_COTIZACION`) | Tablas `detalle_pedido` (`PK (id_pedido, id_producto)`) y `detalle_cotizacion` (`PK (id_cotizacion, id_producto)`) | `CASCADE` desde cabecera; `RESTRICT` desde `producto` |
| **5** | **Relación recursiva `N:M` → tabla puente sobre la misma tabla** | `PRODUCTO ↔ PRODUCTO` (`compatibilidad`) | **`compatibilidad_producto(id_equipo, id_insumo, nota_tecnica)`** con `CHECK (id_equipo <> id_insumo)` | `ON DELETE CASCADE ON UPDATE CASCADE` |
| **6** | **Entidad débil → PK compuesta con FK identificadora** | `NOTIFICACION` dependiente de `USUARIO` | `notificacion` con **`PK (id_usuario, id_notificacion)`** | `ON DELETE CASCADE ON UPDATE CASCADE` |
| **7** | **Atributos derivados/congelados documentados** | `subtotal_linea` y `precio_unitario_*` en detalles | Conservados en `detalle_pedido` y `detalle_cotizacion` para preservar precio histórico pactado | Documentado en `03-normalizacion.md` |

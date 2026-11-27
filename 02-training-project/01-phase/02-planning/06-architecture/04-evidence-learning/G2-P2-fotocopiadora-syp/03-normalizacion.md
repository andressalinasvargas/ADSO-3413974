# B3 · Evidencia de Normalización Paso a Paso (`0FN → 1FN → 2FN → 3FN`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`

Se normalizan paso a paso **2 tablas propias** del dominio de `Fotocopiadora SyP`: una con **llave primaria compuesta** (`planilla_cotizacion_bruta`) para demostrar eliminación de dependencias parciales (`2FN`), y otra con **dependencias transitivas** (`registro_servicio_tecnico_bruto`) para demostrar `3FN`.

---

## Caso 1 · Normalización con Llave Compuesta (`planilla_cotizacion_bruta`)

### Estado Inicial (`0FN`)
Planilla comercial bruta utilizada al consolidar ítems cotizados antes de normalizar:

> `planilla_cotizacion_bruta(`**`id_cotizacion`**, **`id_producto`**, `codigo_cotizacion, fecha_creacion, nombre_cliente, correo_cliente, observaciones, codigo_sku, nombre_producto, marca_producto, compatibilidades_texto, precio_lista_cop, cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea)`
>
> - **Llave primaria compuesta:** `(id_cotizacion, id_producto)`.
> - **Grupo no atómico / repetitivo:** `compatibilidades_texto` agrupa múltiples códigos de tóners/repuestos compatibles en una sola celda separados por comas (`"SKU-T01, SKU-T02"`).

### Paso `0FN → 1FN` (Eliminar grupos repetitivos y lograr atomicidad)
- **Violación detectada:** `compatibilidades_texto` contiene valores multivaluados no atómicos.
- **Solución:** se extrae la relación equipo–insumo a **`compatibilidad_producto(id_equipo, id_insumo, nota_tecnica)`** referenciando `producto`.
- **Resultado en 1FN:** cada celda contiene un único valor atómico.

### Paso `1FN → 2FN` (Eliminar dependencias funcionales parciales sobre llave compuesta)
- **Dependencias funcionales (`DF`) sobre `(id_cotizacion, id_producto)`:**
  - **`DF1` (parcial de `id_cotizacion`):** `id_cotizacion → codigo_cotizacion, fecha_creacion, nombre_cliente, correo_cliente, observaciones, id_usuario`
  - **`DF2` (parcial de `id_producto`):** `id_producto → codigo_sku, nombre_producto, marca_producto, precio_lista_cop, id_categoria`
  - **`DF3` (completa de `(id_cotizacion, id_producto)`):** `(id_cotizacion, id_producto) → cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea`
- **Violación detectada:** Los datos de la cabecera (`DF1`) y del catálogo (`DF2`) dependen solo de la mitad de la llave compuesta, provocando redundancia masiva en cada ítem cotizado.
- **Solución (descomposición por DF):**
  - `cotizacion(`**`id_cotizacion`**`, id_usuario, codigo_cotizacion, nombre_cliente, correo_cliente, telefono_cliente, subtotal, iva, total, observaciones, vigencia_dias, fecha_creacion)`
  - `producto(`**`id_producto`**`, id_categoria, codigo_sku, nombre, marca, precio_cop, especificacion, estado_stock, activo, velocidad_ppm, rendimiento_toner)`
  - `detalle_cotizacion(`**`id_cotizacion, id_producto`**`, cantidad, precio_unitario_cotizado, subtotal_linea, especificacion_linea)`

### Paso `2FN → 3FN` (Eliminar dependencias transitivas)
- **Dependencia transitiva detectada:** dentro de `producto` existía anteriormente el nombre y slug de categoría: `id_producto → id_categoria → slug_unico, nombre_categoria, orden_visual`.
- **Solución:** extraer `categoria(`**`id_categoria`**`, slug_unico, nombre, orden_visual)` dejando únicamente `id_categoria` como FK en `producto`.
- **Estado final en 3FN:** toda columna no clave depende de la clave, de toda la clave y nada más que de la clave.

---

## Caso 2 · Normalización con Dependencia Transitiva (`registro_servicio_tecnico_bruto`)

### Estado Inicial (`0FN`)
Registro plano de recepción de solicitudes técnicas en taller:

> `registro_servicio_tecnico_bruto(`**`id_solicitud`**`, codigo_seguimiento, id_usuario, correo_cliente, nombre_cliente, telefono_cliente, rol_usuario, ultimos_avisos_texto, modelo_equipo, tipo_servicio, fecha_deseada, franja_horaria, descripcion_problema, estado_atencion, notas_admin)`
>
> - **Llave primaria simple:** `id_solicitud`.
> - **Grupo repetitivo:** `ultimos_avisos_texto` concatena múltiples notificaciones enviadas al cliente dentro de la misma fila.

### Paso `0FN → 1FN` (Atomicidad)
- **Violación:** `ultimos_avisos_texto` almacena múltiples avisos no atómicos en un solo campo.
- **Solución:** extraer `notificacion(`**`id_usuario, id_notificacion`**`, titulo, mensaje, tipo, enlace_destino, leida, fecha_creacion)` como entidad débil ligada a `usuario`.

### Paso `1FN → 2FN` (Llave simple)
- Como `id_solicitud` es un atributo simple no compuesto, no hay dependencias parciales en la tabla resultante: cumple **2FN**.

### Paso `2FN → 3FN` (Eliminar dependencias transitivas)
- **Dependencia transitiva escrita:**
  - **`id_solicitud → id_usuario → correo_cliente, rol_usuario, clave_hash, activo`**
  - Si un usuario registrado cambiaba su correo o estado en su cuenta, habría que actualizar manualmente todas sus solicitudes técnicas pasadas.
- **Solución:** mantener `usuario(`**`id_usuario`**`, correo_unico, clave_hash, nombre_completo, telefono, rol, activo, fecha_creacion, ultimo_acceso)` y dejar en `solicitud_servicio` únicamente la clave foránea anulable `id_usuario` junto con los datos de contacto específicos del solicitante en campo (necesarios para solicitudes sin registro previo `id_usuario IS NULL`).

---

## Nota Justificada de Integridad Histórica (`precio_unitario_pactado` / `subtotal_linea`)

En `detalle_pedido` y `detalle_cotizacion` se almacenan **`precio_unitario_pactado` / `precio_unitario_cotizado`** y **`subtotal_linea`** aun cuando el precio vigente del producto reside en `producto.precio_cop`. **Justificación:** si el catálogo actualiza precios por inflación o cambio de TRM semanas después, una orden ya pagada (`RF-05`) o una cotización emitida dentro de su vigencia (`RF-06`) **jamás puede alterar retroactivamente sus importes históricos**.

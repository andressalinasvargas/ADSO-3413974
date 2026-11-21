# Análisis Técnico y Respuestas a Hallazgos (`Preguntas.MD`)

**Fecha de sesión:** 17-10-2026  
**Semana:** Week 25  
**Aprendiz:** Andrés Fernando Salinas Vargas — ADSO 3413974  

Este documento complementa los 5 hallazgos críticos registrados en [`Preguntas.MD`](./Preguntas.MD), detallando para cada punto el problema detectado, su impacto en el sistema, el análisis técnico y la solución recomendada.

---

## 1. El descuento por Familia cambia según cómo se bautice el código alfabético del SKU

- **Pregunta / Hallazgo original:** *El descuento por Familia cambia según cómo se bautice el código alfabético del SKU.*
- **Problema:** La regla de negocio de descuentos está acoplada a una convención textual o prefijo del código SKU (por ejemplo, inferir la familia del producto leyendo los primeros caracteres del SKU) en lugar de usar un atributo o clave foránea explícita (`family_id` / `familia_id`).
- **Impacto / Riesgo:**
  - Si un usuario o una importación cambia el formato alfabético del SKU o renombra un prefijo, el cálculo del descuento cambia silenciosamente o deja de aplicarse.
  - Se rompe la separación entre identificador de inventario (SKU) y clasificación comercial (Familia).
- **Análisis técnico:** Un SKU debe actuar únicamente como código único de referencia del ítem (*Stock Keeping Unit*), opaco frente a reglas de precios. Evaluar reglas comerciales mediante `LIKE` o `substring(sku, ...)` vuelve frágiles tanto el cálculo en caja como los reportes históricos.
- **Solución recomendada:**
  1. Modelar explícitamente una entidad `product_family` (`id`, `code`, `name`, `discount_rule`) y referenciarla desde `product.family_id`.
  2. Tratar el `sku` exclusivamente como identificador único inmutable (índice único) sin lógica de negocio embebida.
  3. Validar mediante pruebas unitarias que modificar el texto del SKU nunca altere el descuento calculado.

---

## 2. ¿Qué pasa con los pedidos que caen en estado `DEAD` en el Outbox cuando el ERP se cae más de 30 minutos?

- **Pregunta / Hallazgo original:** *¿Qué pasa con los pedidos que caen en estado DEAD en el Outbox cuando el ERP se cae más de 30 minutos?*
- **Problema:** El publicador del patrón *Transactional Outbox* posee una ventana máxima de reintentos (aprox. 30 minutos) tras la cual marca el evento como `DEAD` (o lo mueve a una *Dead Letter Queue*) y deja de reintentarlo automáticamente.
- **Impacto / Riesgo:**
  - El pedido queda confirmado en la aplicación web, pero **nunca llega al ERP** (inconsistencia de inventario, facturación y despacho).
  - Si no existe alerta ni mecanismo de reencolado manual/automático, los pedidos `DEAD` quedan "perdidos" silenciosamente en la tabla `outbox`.
- **Análisis técnico:** Una caída del ERP superior a 30 minutos es una falla transitoria prolongada, no un error permanente de formato. Si la política de reintentos consume todos los intentos en pocos minutos con backoff corto, una caída normal de mantenimiento agota los reintentos y marca pedidos válidos como `DEAD`.
- **Solución recomendada:**
  1. **Diferenciar errores transitorios vs. permanentes:** ante errores `5xx`, *timeouts* o fallo de conexión del ERP, aplicar *backoff exponencial con jitter* y un **Circuit Breaker** (pausar el consumo de la cola mientras el ERP esté caído, sin quemar el contador de intentos).
  2. **Monitoreo y alertas:** disparar alerta crítica cuando existan registros en `DEAD` o cuando el *Circuit Breaker* permanezca abierto.
  3. **Mecanismo de recuperación (Replay):** implementar un endpoint/script idempotente (`requeue DEAD -> PENDING`) para reprocesar los eventos una vez el ERP se recupere, garantizando idempotencia en el ERP mediante `idempotency_key` (`order_id`).

---

## 3. El cupo de crédito se gasta y NUNCA se puede volver a recargar

- **Pregunta / Hallazgo original:** *El cupo de crédito se gasta y NUNCA se puede volver a recargar.*
- **Problema:** Al registrar ventas a crédito o fiados, el sistema descuenta el monto del saldo/cupo disponible del cliente, pero no existe una operación transaccional (abono, pago o ajuste autorizado) que libere o restaure el cupo cuando el cliente paga su deuda.
- **Impacto / Riesgo:**
  - Todo cliente con línea de crédito queda bloqueado de forma permanente una vez alcanza su tope inicial, aun estando al día en sus pagos.
  - Obliga a crear clientes duplicados o editar manualmente la base de datos para seguir operando.
- **Análisis técnico:** El cupo disponible debe derivarse de un **límite asignado** menos la **cartera pendiente** (`available_credit = credit_limit - current_debt`), o bien mantenerse mediante un libro mayor de movimientos (*ledger*) con asientos positivos (pagos/abonos, aumento de límite) y negativos (cargos/ventas a crédito).
- **Solución recomendada:**
  1. Implementar el flujo de **registro de abonos/pagos** vinculados a las cuentas por cobrar del cliente, ejecutado dentro de una transacción ACID con bloqueo optimista/pesimista sobre el saldo.
  2. Separar claramente `credit_limit` (tope autorizado por administrador) de `credit_used` / `available_credit`.
  3. Registrar auditoría de cada movimiento (venta, abono, anulación o ajuste de cupo) con usuario, fecha y motivo.

---

## 4. Si aplicas a dos Combos distintos, no te da el más barato sino el más viejo

- **Pregunta / Hallazgo original:** *Si aplicas a dos Combos distintos, no te da el más barato sino el más viejo.*
- **Problema:** Cuando un carrito califica simultáneamente para más de una promoción o combo, el motor de precios selecciona la primera coincidencia según orden de creación (`ORDER BY created_at ASC` o `id ASC`) en lugar de evaluar todas las combinaciones aplicables y elegir la más favorable.
- **Impacto / Riesgo:**
  - Cobros inconsistentes o superiores a lo que el cliente espera recibir según promociones vigentes.
  - Si un combo antiguo quedó activo con menor beneficio, bloquea promociones más nuevas o más económicas.
- **Análisis técnico:** El selector de promociones aplica una estrategia *first-match* dependiente del orden de inserción en base de datos, lo cual produce comportamiento no determinista desde la perspectiva comercial.
- **Solución recomendada:**
  1. Definir explícitamente la **política de resolución de conflictos entre promociones** en el dominio (por ejemplo: *"mejor precio para el cliente"*, prioridad explícita configurable `priority` y si son acumulables o excluyentes).
  2. Evaluar todos los combos candidatos vigentes para el carrito, calcular el descuento/precio final de cada alternativa válida y seleccionar la de menor total a pagar (usando prioridad/antigüedad solo como criterio de desempate determinista).
  3. Guardar en la línea del pedido/factura el `combo_id` aplicado y el descuento otorgado para trazabilidad.

---

## 5. Se contradicen sobre si el nombre del producto cambia en facturas viejas

- **Pregunta / Hallazgo original:** *Se contradicen sobre si el nombre del producto cambia en facturas viejas.*
- **Problema:** Existe ambigüedad entre los documentos/actores sobre si editar el nombre (o precio) de un producto en el catálogo debe actualizar retroactivamente las facturas emitidas anteriormente o si las facturas deben conservar exactamente los datos del momento de la venta.
- **Impacto / Riesgo:**
  - Si una factura antigua hace `JOIN` en vivo con `products.name` o `products.price` sin *snapshot*, al renombrar o descontinuar un producto se altera un documento legal/contable histórico.
  - Genera discrepancias en auditorías tributarias, devoluciones, garantías y reportes históricos.
- **Análisis técnico:** Una factura emitida es un **registro contable inmutable** (*historical snapshot*). Cambiar posteriormente la descripción o precio mostrado en una factura ya emitida viola principios básicos de trazabilidad comercial y normativa contable/fiscal.
- **Solución recomendada:**
  1. **Snapshot obligatorio en líneas de factura (`invoice_items`):** al emitir la factura, copiar y persistir `product_id`, `sku_snapshot`, `product_name_snapshot`, `unit_price_snapshot` y `tax_rate_snapshot`.
  2. Permitir que el catálogo (`products`) evolucione libremente (correcciones de nombre, cambio de precios) sin afectar nunca las facturas ya emitidas.
  3. Documentar esta regla como un requisito no negociable de integridad contable y alinear tanto el PRD/SRS como los casos de prueba E2E.

# Plantillas Extendidas de Casos de Uso · Fotocopiadora SyP

Diagramas de actividades vinculados: [01-actividad-cu03-confirmar-pedido.svg](01-actividad-cu03-confirmar-pedido.svg) · [02-actividad-cu09-servicio-tecnico.svg](02-actividad-cu09-servicio-tecnico.svg)

Todas las plantillas se redactan desde la **intención del actor y la respuesta del sistema**, manteniendo estrictamente fuera cualquier detalle de implementación tecnológica.

---

## Plantilla 1 · `CU-03` · Confirmar pedido de compra

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-03` · Confirmar pedido de compra |
| **Requisitos que atiende** | `RF-05` |
| **Actor primario / secundarios** | Primario: `Visitante` *(o `Cliente Registrado`)* / Secundarios: `Pasarela de Pagos`, `Servicio de Mensajería` |
| **Objetivo del actor** | Formalizar la compra de los productos reunidos en el carrito de compras, registrar datos de entrega y obtener su comprobante único de pedido. |
| **Precondiciones** | El usuario cuenta con al menos un producto previamente agregado en su carrito de compras y se encuentra dentro de la tienda virtual. |
| **Disparador** | El actor selecciona la opción para iniciar la confirmación de compra desde el resumen de su carrito. |
| **Flujo principal** | 1. El sistema presenta el resumen del carrito con cantidades, precios unitarios, impuestos, valor de envío aplicable y total general.<br>2. El actor confirma los artículos seleccionados e ingresa sus datos de entrega y facturación (nombre o razón social, identificación tributaria, correo, teléfono y dirección en Neiva o cobertura regional).<br>3. El sistema verifica que todos los productos existan en el catálogo vigente, tengan disponibilidad positiva y recalcula el valor total autorizado.<br>4. El actor selecciona el medio de pago deseado (pago digital en línea o coordinación comercial directa) y confirma el envío del pedido bloqueando reenvíos duplicados.<br>5. Si eligió pago digital en línea, el sistema solicita autorización a la `Pasarela de Pagos` por el monto recalculado.<br>6. La `Pasarela de Pagos` confirma la aprobación de la transacción.<br>7. El sistema registra el pedido con un código comercial único, genera en paralelo el comprobante consultable (*incluye `CU-05`*) y emite el aviso de nuevo pedido para el cliente y el administrador.<br>8. El sistema limpia el carrito de compras y presenta al actor la confirmación con acceso directo al comprobante. |
| **Flujos alternos** | **4a.** Si el actor selecciona pago por coordinación comercial o transferencia directa, el sistema omite la validación automática con la `Pasarela de Pagos`, registra el pedido con estado pendiente de verificación comercial y ofrece continuar el seguimiento mediante `Servicio de Mensajería` (retoma en el paso 7).<br>**4b.** Si el actor modifica las cantidades antes de enviar el pedido, el sistema actualiza los subtotales y recalcula el costo de envío aplicable antes de continuar con el paso 3. |
| **Excepciones** | **1b.** Si el carrito se encuentra vacío al intentar iniciar la confirmación, el sistema impide avanzar, informa que debe añadir al menos un artículo del catálogo y mantiene el acceso a la tienda.<br>**3b.** Si algún artículo cambió a estado agotado o dejó de estar activo en el catálogo, el sistema rechaza la confirmación, señala el producto sin disponibilidad y solicita retirarlo del carrito.<br>**6b.** Si la `Pasarela de Pagos` rechaza o expira la autorización de pago, el sistema cancela el cierre del pedido, informa al actor el motivo y habilita el reintento o cambio de medio de pago sin duplicar órdenes. |
| **Postcondiciones** | El pedido queda registrado con identificador único, cálculo comercial validado, estado de pago asignado y comprobante disponible en `CU-05`, dejando vacío el carrito de compras. |
| **Reglas de negocio** | `RN-01`: Los precios y subtotales se calculan exclusivamente en pesos colombianos (COP) según catálogo vigente.<br>`RN-02`: Todo pedido en proceso bloquea acciones repetidas hasta recibir confirmación o rechazo.<br>`RN-03`: La compra con pago digital exitoso genera simultáneamente comprobante y notificación operativa. |
| **Pantalla del prototipo** | [pantalla-02-cu03-confirmar-pedido.png](06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |

---

## Plantilla 2 · `CU-09` · Solicitar servicio técnico y diagnóstico

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-09` · Solicitar servicio técnico y diagnóstico |
| **Requisitos que atiende** | `RF-09` |
| **Actor primario / secundarios** | Primario: `Visitante` *(o `Cliente Registrado`)* / Secundario: `Servicio de Mensajería` |
| **Objetivo del actor** | Diagnosticar de manera preliminar fallas de impresión o plan de renting y agendar una solicitud de visita o mantenimiento técnico para un equipo. |
| **Precondiciones** | El actor ha accedido al módulo de servicio técnico de la plataforma. |
| **Disparador** | El actor inicia una consulta en las herramientas técnicas o diligencia la solicitud de visita de mantenimiento. |
| **Flujo principal** | 1. El sistema presenta las herramientas de orientación técnica (buscador de códigos de falla, guía de atascos, verificador de cobertura, simulador de renting) y el formulario de solicitud de servicio.<br>2. El actor opta por agendar atención técnica e ingresa datos de contacto, modelo de equipo, tipo de mantenimiento, fecha y franja horaria deseada y descripción de la falla.<br>3. El sistema verifica que los datos obligatorios estén completos y que la ubicación solicitada se encuentre dentro de la zona de atención ordinaria.<br>4. El actor confirma el registro de la solicitud.<br>5. El sistema asigna un código de seguimiento único y establece el estado inicial como `Pendiente`.<br>6. En paralelo, el sistema registra el aviso para gestión del taller y muestra el comprobante de solicitud al actor.<br>7. El actor visualiza su cita registrada y puede iniciar seguimiento directo por `Servicio de Mensajería` si requiere urgencia en sitio. |
| **Flujos alternos** | **2a.** Si el actor utiliza primero el buscador de códigos de falla, guía de atascos o simulador de renting, el sistema presenta el procedimiento sugerido o la proyección estimada mensual de copias y le ofrece trasladar automáticamente los datos del equipo al formulario del paso 2.<br>**3a.** Si el equipo se ubica en un municipio fuera del perímetro urbano habitual de cobertura directa, el sistema advierte que aplican condiciones de desplazamiento y permite canalizar la coordinación previa a través de `Servicio de Mensajería` o registrar la solicitud con nota de cobertura especial. |
| **Excepciones** | **3b.** Si falta algún dato obligatorio (contacto, equipo, fecha u horario) o el formato de correo es inválido, el sistema detiene el envío, señala los campos requeridos y conserva la información ya escrita.<br>**4b.** Si ocurre una indisponibilidad temporal del canal central de recepción de citas, el sistema conserva el borrador ingresado y ofrece enlace prellenado hacia `Servicio de Mensajería` para no perder la atención. |
| **Postcondiciones** | La solicitud técnica queda registrada con código de seguimiento, fecha deseada, descripción de falla y estado `Pendiente` visible para programación del taller. |
| **Reglas de negocio** | `RN-04`: La orientación preventiva con herramientas de códigos y atascos no sustituye la garantía presencial cuando existe código de falla crítica.<br>`RN-05`: Toda solicitud debe quedar trazable para actualización de estado posterior. |
| **Pantalla del prototipo** | [pantalla-03-cu09-solicitar-servicio-tecnico.png](06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |

---

## Plantilla 3 · `CU-11` · Administrar catálogo y operaciones comerciales

| Campo | Contenido |
|---|---|
| **Identificador y nombre** | `CU-11` · Administrar catálogo y operaciones comerciales |
| **Requisitos que atiende** | `RF-11` |
| **Actor primario / secundarios** | Primario: `Administrador` / Secundario: ninguno obligatorio |
| **Objetivo del actor** | Supervisar indicadores comerciales, mantener actualizado el catálogo de productos y gestionar los estados de solicitudes técnicas, pedidos, cotizaciones y reportes de renting. |
| **Precondiciones** | El actor posee rol `Administrador` activo y ha iniciado sesión validada previamente en la plataforma (`CU-06`). |
| **Disparador** | El administrador ingresa al panel de gestión administrativa. |
| **Flujo principal** | 1. El sistema verifica la vigencia del rol administrativo y oculta la pantalla de acceso denegado.<br>2. El sistema presenta las secciones de trabajo: solicitudes técnicas, pedidos, cotizaciones, contadores de renting, mensajes de contacto, catálogo e indicadores analíticos.<br>3. El administrador selecciona una orden comercial o una solicitud técnica pendiente y actualiza su estado operativo junto con notas de seguimiento.<br>4. El sistema valida la transición de estado y guarda la actualización en el historial operativo.<br>5. Si el registro actualizado pertenece a un cliente con cuenta asociada, se habilita la emisión de aviso de estado hacia `CU-12` (*punto de extensión `actualización de estado`*).<br>6. El administrador actualiza los indicadores y consulta el balance comercial consolidado en el tablero analítico.<br>7. El sistema recalcula las métricas en tiempo real y confirma el guardado visualmente mediante aviso accesible. |
| **Flujos alternos** | **3a.** Si el administrador crea o edita un producto del catálogo (nombre, categoría, precio, disponibilidad y modelos compatibles), el sistema valida los valores positivos y refleja el cambio en el catálogo público.<br>**6a.** Si el administrador solicita descargar un listado comercial (pedidos, solicitudes, cotizaciones o contadores), el sistema sanitiza posibles fórmulas peligrosas en los campos de texto y entrega el archivo tabular listo para hoja de cálculo. |
| **Excepciones** | **1b.** Si quien intenta ingresar no posee sesión válida ni perfil `Administrador`, el sistema bloquea el acceso a operaciones, muestra la vista de acceso denegado y ofrece redirección al inicio de sesión.<br>**3b.** Si se ingresa un precio inválido o faltan atributos obligatorios al editar un producto, el sistema rechaza el guardado y destaca los campos que deben corregirse.<br>**6b.** Si no existen registros en la categoría seleccionada al solicitar una exportación tabular, el sistema notifica que el listado está vacío sin generar archivo defectuoso. |
| **Postcondiciones** | Las modificaciones de catálogo o estados operativos quedan persistidas con historial y métricas actualizadas, y los clientes correspondientes quedan notificados cuando aplica. |
| **Reglas de negocio** | `RN-06`: Ninguna acción administrativa puede ejecutarse sin validación previa de rol `Administrador`.<br>`RN-07`: Todo documento exportado debe neutralizar caracteres que inicien fórmulas maliciosas en hojas de cálculo.<br>`RN-08`: Los productos desactivados permanecen ocultos al público general pero conservan trazabilidad en pedidos históricos. |
| **Pantalla del prototipo** | [pantalla-04-cu11-panel-administrativo.png](06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |

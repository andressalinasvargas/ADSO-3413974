# Justificación del Diagrama de Casos de Uso UML · Fotocopiadora SyP

Diagrama visual: [03-diagrama-casos-uso.svg](03-diagrama-casos-uso.svg) · [03-diagrama-casos-uso.png](03-diagrama-casos-uso.png) · Fuente editable: [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio)

---

## 1. Frontera del Sistema y Actores

- **Frontera del sistema**: `Plataforma Web y Gestión Comercial Fotocopiadora SyP`. Todos los casos de uso (`CU-01` a `CU-12`) permanecen dentro del rectángulo de frontera y todos los actores fuera de ella.
- **Actores primarios (iniciadores)**:
  1. `Visitante`: consulta catálogo, gestiona carrito, confirma pedidos como invitado, solicita cotizaciones, envía mensajes de contacto y solicita servicio técnico o diagnóstico.
  2. `Cliente Registrado`: especialización de `Visitante` mediante **generalización** (`Cliente Registrado --|> Visitante`); hereda todas las interacciones comerciales del visitante y añade consulta de historial, reporte mensual de contadores de renting y gestión de notificaciones propias.
  3. `Administrador`: administra productos, categorías, pedidos, cotizaciones, solicitudes técnicas, contadores, analíticas y exportación de listados.
- **Actores secundarios (receptores / apoyo externo)**:
  1. `Pasarela de Pagos`: valida y autoriza pagos electrónicos en línea cuando el cliente confirma un pedido con método digital (`CU-03`).
  2. `Servicio de Mensajería`: canal externo para envío o continuación de solicitudes comerciales, consultas de contacto y avisos de soporte (`CU-03`, `CU-08`, `CU-09`).

---

## 2. Catálogo de Casos de Uso (`CU-01` a `CU-12`)

Todos los casos representan metas de negocio en formato **verbo + objeto**, evitando fragmentar operaciones CRUD triviales:

| ID | Caso de uso (Verbo + Objeto) | Actor(es) asociado(s) | Objetivo de negocio |
|---|---|---|---|
| `CU-01` | Consultar inicio y catálogo de productos | `Visitante` | Navegar portada, filtrar por categoría/búsqueda paginada, revisar ficha técnica, compatibilidades y comparar equipos. |
| `CU-02` | Gestionar carrito de compras | `Visitante` | Agregar productos disponibles, ajustar cantidades, eliminar ítems y revisar totales estimados. |
| `CU-03` | Confirmar pedido de compra | `Visitante`, `Pasarela de Pagos`, `Servicio de Mensajería` | Registrar datos de entrega/facturación, elegir medio de pago, validar orden y emitir pedido único. |
| `CU-04` | Generar cotización formal | `Visitante` | Emitir propuesta comercial formal numerada a partir de productos cotizados. |
| `CU-05` | Consultar documento comercial | *Incluido por `CU-03` y `CU-04`* | Visualizar e imprimir el detalle del pedido o cotización respetando privacidad de datos para no titulares. |
| `CU-06` | Autenticar cuenta de usuario | `Visitante` | Registrar cuenta nueva, validar credenciales seguras al iniciar sesión o cerrar sesión activa. |
| `CU-07` | Gestionar perfil e historial comercial | `Cliente Registrado` | Consultar pedidos, cotizaciones y solicitudes técnicas históricas asociadas a la cuenta del cliente. |
| `CU-08` | Enviar consulta de contacto | `Visitante`, `Servicio de Mensajería` | Consultar ubicación/canales de atención y registrar mensajes de contacto para seguimiento comercial. |
| `CU-09` | Solicitar servicio técnico y diagnóstico | `Visitante`, `Servicio de Mensajería` | Consultar códigos de falla, guía de atascos o calculadora de renting y agendar cita de soporte técnico. |
| `CU-10` | Reportar contadores de renting | `Cliente Registrado` | Registrar mensualmente lecturas de impresiones B/N y color por equipo contratado. |
| `CU-11` | Administrar catálogo y operaciones comerciales | `Administrador` | Ejecutar altas/cambios de productos, cambiar estados de pedidos/solicitudes, revisar analíticas y exportar reportes. |
| `CU-12` | Gestionar notificaciones de estado | `Cliente Registrado`, `Administrador` | Consultar avisos de actividad comercial o técnica y marcar notificaciones como leídas. |

---

## 3. Justificación de Relaciones (`«include»`, `«extend»` y Generalización)

Siguiendo la sección 7.2 de `Rubricas_G1.md`:
- En **`«include»`**, la flecha apunta del **caso base hacia el caso incluido** porque siempre se ejecuta como parte obligatoria del flujo.
- En **`«extend»`**, la flecha apunta del **caso que extiende hacia el caso base** porque solo ocurre de forma opcional o condicional en un punto de extensión definido.

| Tipo | Origen → Destino | Punto de extensión | Justificación (1 línea) |
|---|---|---|---|
| `«include»` | `CU-03 Confirmar pedido de compra` → `CU-05 Consultar documento comercial` | — | Todo pedido confirmado genera y abre obligatoriamente su comprobante comercial consultable al finalizar la compra. |
| `«include»` | `CU-04 Generar cotización formal` → `CU-05 Consultar documento comercial` | — | Toda cotización formal emitida produce siempre un documento formal numerado e imprimible para consulta del solicitante. |
| `«include»` | `CU-10 Reportar contadores de renting` → `CU-06 Autenticar cuenta de usuario` | — | El reporte mensual de contadores requiere validar previamente la identidad del cliente propietario del contrato. |
| `«extend»` | `CU-04 Generar cotización formal` → `CU-02 Gestionar carrito de compras` | `selección de cotización` | Desde el carrito armado, el usuario puede optar condicionalmente por solicitar una cotización formal en lugar de comprar de inmediato. |
| `«extend»` | `CU-12 Gestionar notificaciones de estado` → `CU-11 Administrar catálogo y operaciones comerciales` | `actualización de estado` | De manera condicional, al cambiar el estado de un pedido o cita técnica en el panel administrativo, se dispara una notificación al titular. |
| `Generalización` | `Cliente Registrado` ─▷ `Visitante` | — | El cliente autenticado hereda todos los casos de exploración, carrito, compra y contacto del visitante, ampliando su alcance a historial, renting y notificaciones. |

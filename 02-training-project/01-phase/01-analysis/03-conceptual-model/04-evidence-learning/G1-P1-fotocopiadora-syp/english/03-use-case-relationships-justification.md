> **Spanish version (official rubric root):** [../03-justificacion-relaciones-cu.md](../03-justificacion-relaciones-cu.md)

# UML Use Case Diagram Justification · Fotocopiadora SyP

Visual diagram: [../03-diagrama-casos-uso.svg](../03-diagrama-casos-uso.svg) · [../03-diagrama-casos-uso.png](../03-diagrama-casos-uso.png) · Editable source: [../03-diagrama-casos-uso.drawio](../03-diagrama-casos-uso.drawio)

---

## 1. System Boundary and Actors

- **System boundary**: `Plataforma Web y Gestión Comercial Fotocopiadora SyP`. All use cases (`CU-01` to `CU-12`) stay inside the boundary rectangle, and all actors remain outside it.
- **Primary actors (initiators)**:
  1. `Visitante` *(Visitor)*: browses catalog, manages cart, confirms guest orders, requests quotes, sends contact inquiries, and requests technical service or diagnostics.
  2. `Cliente Registrado` *(Registered Customer)*: specialization of `Visitante` via **generalization** (`Cliente Registrado --|> Visitante`); inherits all visitor commercial interactions and adds history lookup, monthly renting counter reporting, and management of own notifications.
  3. `Administrador` *(Administrator)*: manages products, categories, orders, quotes, technical requests, counters, analytics, and report exports.
- **Secondary actors (receivers / external support)**:
  1. `Pasarela de Pagos` *(Payment Gateway)*: validates and authorizes online payments when the customer confirms an order via digital payment (`CU-03`).
  2. `Servicio de Mensajería` *(Messaging Service)*: external channel for sending or continuing commercial inquiries, contact messages, and support alerts (`CU-03`, `CU-08`, `CU-09`).

---

## 2. Use Case Catalog (`CU-01` to `CU-12`)

All use cases express business goals in **verb + object** form, avoiding fragmented trivial CRUD operations:

| ID | Use case (Verb + Object — original label) | Associated actor(s) | Business goal |
|---|---|---|---|
| `CU-01` | Consult home and product catalog (`Consultar inicio y catálogo de productos`) | `Visitante` | Browse home page, filter by category/paginated search, review technical sheet, compatibilities, and compare equipment. |
| `CU-02` | Manage shopping cart (`Gestionar carrito de compras`) | `Visitante` | Add available products, adjust quantities, remove items, and inspect estimated totals. |
| `CU-03` | Confirm purchase order (`Confirmar pedido de compra`) | `Visitante`, `Pasarela de Pagos`, `Servicio de Mensajería` | Record delivery/billing details, select payment method, validate order, and issue unique order code. |
| `CU-04` | Generate formal quote (`Generar cotización formal`) | `Visitante` | Issue numbered formal commercial proposal from quoted products. |
| `CU-05` | View commercial document (`Consultar documento comercial`) | *Included by `CU-03` and `CU-04`* | View and print order or quote details while enforcing personal-data masking for non-owners. |
| `CU-06` | Authenticate user account (`Autenticar cuenta de usuario`) | `Visitante` | Register new account, validate secure credentials at sign-in, or sign out of active session. |
| `CU-07` | Manage profile and commercial history (`Gestionar perfil e historial comercial`) | `Cliente Registrado` | Consult historical orders, quotes, and technical service requests linked to the customer account. |
| `CU-08` | Send contact inquiry (`Enviar consulta de contacto`) | `Visitante`, `Servicio de Mensajería` | View location/service channels and submit contact messages for commercial follow-up. |
| `CU-09` | Request technical service and diagnosis (`Solicitar servicio técnico y diagnóstico`) | `Visitante`, `Servicio de Mensajería` | Look up fault codes, jam guide, or renting calculator and schedule a technical support visit. |
| `CU-10` | Report renting counters (`Reportar contadores de renting`) | `Cliente Registrado` | Record monthly B/W and color print readings per contracted machine. |
| `CU-11` | Administer catalog and commercial operations (`Administrar catálogo y operaciones comerciales`) | `Administrador` | Create/update products, transition order/request statuses, review analytics, and export reports. |
| `CU-12` | Manage status notifications (`Gestionar notificaciones de estado`) | `Cliente Registrado`, `Administrador` | Check commercial or technical activity alerts and mark notifications as read. |

---

## 3. Relationship Justifications (`«include»`, `«extend»`, and Generalization)

Following `Rubricas_G1.md` §7.2:
- In **`«include»`**, the arrow points from the **base use case to the included use case** because it is always executed as a mandatory part of the flow.
- In **`«extend»`**, the arrow points from the **extending use case to the base use case** because it only triggers optionally or conditionally at a defined extension point.

| Type | Source → Target | Extension point | 1-line justification |
|---|---|---|---|
| `«include»` | `CU-03 Confirmar pedido de compra` → `CU-05 Consultar documento comercial` | — | Every confirmed order mandatorily generates and opens its viewable commercial receipt upon checkout completion. |
| `«include»` | `CU-04 Generar cotización formal` → `CU-05 Consultar documento comercial` | — | Every issued formal quote always produces a numbered, printable formal document for requester inspection. |
| `«include»` | `CU-10 Reportar contadores de renting` → `CU-06 Autenticar cuenta de usuario` | — | Monthly counter reporting requires prior identity validation of the contract-holding customer. |
| `«extend»` | `CU-04 Generar cotización formal` → `CU-02 Gestionar carrito de compras` | `selección de cotización` | From the assembled cart, the user may conditionally opt to request a formal quote instead of buying immediately. |
| `«extend»` | `CU-12 Gestionar notificaciones de estado` → `CU-11 Administrar catálogo y operaciones comerciales` | `actualización de estado` | Conditionally, when updating an order or service request status in the admin panel, a notification is triggered for the owner. |
| `Generalization` | `Cliente Registrado` ─▷ `Visitante` | — | The authenticated customer inherits all browsing, cart, checkout, and contact use cases from the visitor, extending scope to history, renting, and notifications. |

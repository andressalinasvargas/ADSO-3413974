> **Spanish version (official rubric root):** [../03-plantillas-casos-uso.md](../03-plantillas-casos-uso.md)

# Extended Use Case Templates · Fotocopiadora SyP

Linked activity diagrams: [../01-actividad-cu03-confirmar-pedido.svg](../01-actividad-cu03-confirmar-pedido.svg) · [../02-actividad-cu09-servicio-tecnico.svg](../02-actividad-cu09-servicio-tecnico.svg)

All templates are written strictly from the **actor's intent and system response**, keeping all technological implementation details out.

---

## Template 1 · `CU-03` · Confirm Purchase Order

| Field | Content |
|---|---|
| **Identifier and name** | `CU-03` · Confirm purchase order (`Confirmar pedido de compra`) |
| **Requirements covered** | `RF-05` |
| **Primary / secondary actors** | Primary: `Visitante` *(or `Cliente Registrado`)* / Secondary: `Pasarela de Pagos`, `Servicio de Mensajería` |
| **Actor goal** | Formalize the purchase of the products gathered in the shopping cart, record delivery details, and obtain a unique order receipt. |
| **Preconditions** | The user already has at least one product added to their shopping cart and is inside the virtual store. |
| **Trigger** | The actor selects the option to start checkout confirmation from the shopping cart summary. |
| **Main flow** | 1. The system presents the cart summary with quantities, unit prices, taxes, applicable shipping cost, and grand total.<br>2. The actor confirms selected items and enters delivery and billing details (name or business name, tax ID, email, phone, and address in Neiva or regional coverage).<br>3. The system verifies that all products exist in the active catalog, have positive availability, and recalculates the authorized total amount.<br>4. The actor chooses the desired payment method (online digital payment or direct commercial coordination) and confirms order submission while blocking duplicate sends.<br>5. If online digital payment was chosen, the system requests authorization from `Pasarela de Pagos` for the recalculated amount.<br>6. `Pasarela de Pagos` confirms transaction approval.<br>7. The system records the order with a unique commercial code, generates the viewable receipt in parallel (*includes `CU-05`*), and emits the new-order alert for customer and administrator.<br>8. The system clears the shopping cart and displays confirmation with direct access to the receipt. |
| **Alternative flows** | **4a.** If the actor chooses direct commercial coordination or bank transfer, the system skips automatic `Pasarela de Pagos` validation, records the order with pending commercial verification status, and offers follow-up via `Servicio de Mensajería` (resumes at step 7).<br>**4b.** If the actor edits item quantities before submitting the order, the system updates subtotals and recalculates shipping before continuing to step 3. |
| **Exceptions** | **1b.** If the cart is empty when starting confirmation, the system prevents advancing, informs that at least one catalog item is required, and keeps access to the store.<br>**3b.** If any item became out of stock or inactive in the catalog, the system rejects confirmation, highlights the unavailable product, and asks to remove it from the cart.<br>**6b.** If `Pasarela de Pagos` declines or times out, the system cancels order closing, notifies the reason, and enables retry or switching payment method without duplicating orders. |
| **Postconditions** | The order is recorded with a unique identifier, validated commercial calculation, assigned payment status, and receipt available in `CU-05`, leaving the shopping cart empty. |
| **Business rules** | `RN-01`: Prices and subtotals are calculated exclusively in Colombian pesos (COP) per current catalog.<br>`RN-02`: Every in-flight order submission blocks repeated actions until confirmation or rejection is received.<br>`RN-03`: Successful digital checkout simultaneously generates the receipt and operational notification. |
| **Prototype screen** | [../06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png](../06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |

---

## Template 2 · `CU-09` · Request Technical Service and Diagnosis

| Field | Content |
|---|---|
| **Identifier and name** | `CU-09` · Request technical service and diagnosis (`Solicitar servicio técnico y diagnóstico`) |
| **Requirements covered** | `RF-09` |
| **Primary / secondary actors** | Primary: `Visitante` *(or `Cliente Registrado`)* / Secondary: `Servicio de Mensajería` |
| **Actor goal** | Preliminarily diagnose printing faults or renting plans and schedule a maintenance or technical support visit for equipment. |
| **Preconditions** | The actor has accessed the technical service module of the platform. |
| **Trigger** | The actor starts a query in the technical tools or fills out the maintenance visit request. |
| **Main flow** | 1. The system presents technical guidance tools (fault code lookup, jam guide, coverage verifier, renting simulator) and the service request form.<br>2. The actor chooses to schedule technical care and enters contact details, equipment model, maintenance type, desired date and time slot, and fault description.<br>3. The system verifies that required fields are complete and that the requested location falls within ordinary service coverage.<br>4. The actor confirms registration of the request.<br>5. The system assigns a unique tracking code and sets initial status to `Pendiente`.<br>6. In parallel, the system records the workshop notification and displays the request receipt to the actor.<br>7. The actor views the registered appointment and can initiate direct follow-up via `Servicio de Mensajería` for urgent on-site cases. |
| **Alternative flows** | **2a.** If the actor first uses the fault code lookup, jam guide, or renting simulator, the system shows the suggested procedure or estimated monthly copy projection and offers carrying the equipment model over to the step 2 form.<br>**3a.** If the equipment is located in a municipality outside direct urban coverage, the system warns that travel terms apply and enables pre-coordination via `Servicio de Mensajería` or recording the request with a special coverage note. |
| **Exceptions** | **3b.** If a mandatory field (contact, equipment, date, or time slot) is missing or the email format is invalid, the system halts submission, highlights required fields, and preserves entered data.<br>**4b.** If central appointment intake suffers temporary unavailability, the system keeps the entered draft and offers a pre-filled link toward `Servicio de Mensajería`. |
| **Postconditions** | The technical request is stored with a tracking code, desired date, fault description, and `Pendiente` status visible for workshop scheduling. |
| **Business rules** | `RN-04`: Preventive guidance from fault-code and jam tools does not replace on-site warranty when a critical fault code exists.<br>`RN-05`: Every request must remain traceable for subsequent status updates. |
| **Prototype screen** | [../06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png](../06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |

---

## Template 3 · `CU-11` · Administer Catalog and Commercial Operations

| Field | Content |
|---|---|
| **Identifier and name** | `CU-11` · Administer catalog and commercial operations (`Administrar catálogo y operaciones comerciales`) |
| **Requirements covered** | `RF-11` |
| **Primary / secondary actors** | Primary: `Administrador` / Secondary: none mandatory |
| **Actor goal** | Supervise commercial KPIs, keep the product catalog updated, and manage statuses of technical requests, orders, quotes, and renting counter reports. |
| **Preconditions** | The actor holds an active `Administrador` role and has completed validated session sign-in (`CU-06`). |
| **Trigger** | The administrator enters the administrative management panel. |
| **Main flow** | 1. The system verifies administrative role validity and hides the access-denied screen.<br>2. The system displays the working sections: technical requests, orders, quotes, renting counters, contact messages, catalog, and analytical KPIs.<br>3. The administrator selects a pending commercial order or technical request and updates its operational status along with follow-up notes.<br>4. The system validates the status transition and saves the update into operational history.<br>5. If the updated record belongs to a registered customer account, status notification emission toward `CU-12` is triggered (*extension point `actualización de estado`*).<br>6. The administrator refreshes indicators and reviews consolidated commercial balance on the analytics board.<br>7. The system recalculates metrics in real time and confirms saving visually via accessible alert. |
| **Alternative flows** | **3a.** If the administrator creates or edits a catalog product (name, category, price, availability, and compatible models), the system validates positive values and reflects the update in the public catalog.<br>**6a.** If the administrator requests downloading a commercial listing (orders, requests, quotes, or counters), the system sanitizes potential dangerous spreadsheet formulas in text fields and delivers a spreadsheet-ready tabular file. |
| **Exceptions** | **1b.** If the requester lacks a valid session or `Administrador` profile, the system blocks operations access, shows an access-denied notice, and offers sign-in redirection.<br>**3b.** If an invalid price is entered or required attributes are missing when editing a product, the system rejects saving and highlights fields to fix.<br>**6b.** If zero records exist in the chosen category upon tabular export request, the system notifies that the listing is empty without generating a broken file. |
| **Postconditions** | Catalog updates or operational status transitions are persisted with updated history and metrics, and corresponding customers are notified when applicable. |
| **Business rules** | `RN-06`: No administrative action may execute without prior `Administrador` role verification.<br>`RN-07`: Every exported tabular document must neutralize characters that start malicious spreadsheet formulas.<br>`RN-08`: Deactivated products remain hidden from public catalog while preserving traceability in historical orders. |
| **Prototype screen** | [../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png](../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |

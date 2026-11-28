> **Spanish version (official rubric root):** [../00-insumo-srs-base.md](../00-insumo-srs-base.md)

# Consolidated SRS Input · Fotocopiadora SyP

## 1. Purpose and Case Context

**Fotocopiadora SyP** is an e-commerce and technical service management platform focused on the commercialization of multifunctional photocopiers, printers, printing supplies (toners, inks), spare parts, preventive/corrective maintenance services, and rental (renting) plans in Neiva, Huila.

This input consolidates the needs identified in the team's requirements specification (**Equipo Fotocopiadora SyP**, consolidated version v2.0), accurately separating **functional requirements (`FR` / `RF`)** from **non-functional requirements (`NFR` / `RNF`)** and eliminating duplicates or technological implementation details prior to conceptual modeling.

---

## 2. Consolidated Functional Requirements (`RF-01` to `RF-12`)

| ID | Short name | Verifiable functional description |
|---|---|---|
| `RF-01` | Display home and value proposition | The system must show a home page with an informational carousel, category shortcuts, a technical service/renting summary, and a quick search bar to the catalog. |
| `RF-02` | Browse, filter, and compare catalog | The system must list active products with 12-item pagination, allow category filtering, live keyword search, and side-by-side specification comparison. |
| `RF-03` | View product sheet and compatibilities | The system must show the detailed view of each product with price in COP, availability status, key specifications, and a list of compatible supplies or equipment. |
| `RF-04` | Manage persistent shopping cart | The system must allow adding available products, modifying quantities (>= 1), removing items, preserving the cart across visits, and recalculating subtotal, VAT, and total in real time. |
| `RF-05` | Confirm purchase order | The system must capture delivery and billing data, offer payment methods (online or commercial coordination), prevent duplicate submissions, validate prices/stock, and issue a unique receipt. |
| `RF-06` | Generate and view formal quote | The system must allow generating a formal quote with a unique code from selected items, display a printable format, and mask sensitive personal data from visitors who are neither owners nor administrators. |
| `RF-07` | Manage user account and history | The system must allow registration of new customers with a secure password, sign-in/sign-out, and consultation of their own history of orders, quotes, and service requests. |
| `RF-08` | Send inquiry via contact channel | The system must provide service details, geographic location on a map, direct access to instant messaging, and a contact form with submission confirmation. |
| `RF-09` | Request technical service and diagnosis | The system must allow registering preventive or corrective maintenance requests and provide error-code lookup tools, jam diagnosis, coverage check, and a renting simulator. |
| `RF-10` | Report renting counters | The system must allow authenticated customers to monthly report black-and-white and color page counters per assigned equipment. |
| `RF-11` | Administer catalog and operations | The system must restrict to the administrator a management panel to inspect analytics, manage products, update order/request statuses, review contacts/counters, and export safe listings. |
| `RF-12` | Manage status notifications | The system must notify the customer and the administrator about new orders, technical appointments, or status changes, allowing them to check their inbox and mark alerts as read. |

---

## 3. Consolidated Non-Functional Requirements (`RNF-01` to `RNF-08`)

Non-functional requirements define quality attributes and cross-cutting constraints of the system. **They are not modeled as use cases** because they do not represent independent actor interaction goals, but properties that all functions must satisfy:

| ID | Category | Non-functional requirement |
|---|---|---|
| `RNF-01` | Usability | Intuitive navigation allowing any category or product to be reached in at most 3 interactions from home, with clear heading hierarchy. |
| `RNF-02` | Responsiveness | Fluid adaptation without horizontal overflow from 320 px (mobile) to desktop, with minimum touch controls of 24 to 44 px. |
| `RNF-03` | Accessibility | Compliance with minimum 4.5:1 contrast in light and dark modes, visible keyboard focus, focus traps in modals, `Escape` shortcut, and image alt texts. |
| `RNF-04` | Performance | Fast-loading optimized images with lazy loading in the catalog, smart offline caching, and compressed payload responses. |
| `RNF-05` | Security and privacy | Protected credential storage, role-based access control, authentication attempt throttling, protection against automated abuse, and personal data masking against third parties. |
| `RNF-06` | Availability and contingency | Continuous operation with static catalog backup and an alternative service channel when commercial backend connectivity is unavailable. |
| `RNF-07` | Localization and formats | Spanish interface (`es-CO`), prices expressed in Colombian pesos (COP), and Colombian date formats. |
| `RNF-08` | Maintainability and verification | Modular structure accompanied by end-to-end automated tests and critical regression checks prior to each delivery. |

---

## 4. Actors Identified for Analysis

| Actor | Type | Main responsibility |
|---|---|---|
| `Visitante` *(Visitor)* | Primary | Browses catalog, compares equipment, builds cart, sends contact inquiries, requests technical service, generates quotes, or places guest orders. |
| `Cliente Registrado` *(Registered Customer)* | Primary (specialization of `Visitante`) | Inherits all visitor actions and also checks commercial history, reports monthly renting counters, and manages own notifications. |
| `Administrador` *(Administrator)* | Primary | Manages catalog, inventory, orders, quotes, technical requests, counters, commercial analytics, and report exports. |
| `Pasarela de Pagos` *(Payment Gateway)* | Secondary | Processes online payment authorization during order confirmation. |
| `Servicio de Mensajería` *(Messaging Service)* | Secondary | External channel through which commercial notices or direct confirmations with the business are routed. |

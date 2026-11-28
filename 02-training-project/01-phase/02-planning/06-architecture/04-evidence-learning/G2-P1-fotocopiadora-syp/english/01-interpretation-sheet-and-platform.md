> **Spanish version (official rubric root):** [../01-ficha-interpretacion-y-plataforma.md](../01-ficha-interpretacion-y-plataforma.md)

# A1 · Analysis Interpretation Sheet & Technology Platform (`Fotocopiadora SyP`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP** — Cohort `3413974`  
**Product:** G2-P1 · Design artifacts (`RAP 593103`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Source input:** [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) and [10-analysis-report.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/10-analysis-report.md)

---

## 1. Selected Requirements from SRS (`12 FR` and `8 NFR`)

100 % of the functional requirements (`RF-01`–`RF-12`) and non-functional requirements (`RNF-01`–`RNF-08`) consolidated in Guide 1 are included:

### Functional Requirements (`12`)
- **`RF-01` Display home and value proposition:** Home showcase, informational carousel, category shortcuts, technical/renting summary, and quick catalog search.
- **`RF-02` Browse, filter, and compare catalog:** Paginated listing (`12` items), category filters, live keyword search, and side-by-side technical comparator.
- **`RF-03` View product sheet and compatibilities:** Product detail in COP, stock status, and compatible machines/supplies.
- **`RF-04` Manage persistent shopping cart:** Add/remove/quantity (`>= 1`), persistence, and live recalculation of subtotal, VAT (`19 %`), and total.
- **`RF-05` Confirm purchase order:** Delivery/billing info, payment methods, anti-double-submission lock, stock verification, and unique receipt code.
- **`RF-06` Generate and view formal quote:** Numbered printable quote with sensitive data hidden from unauthorized non-owners.
- **`RF-07` Manage user account and history:** Secure registration, authentication, and personal order/quote/service history.
- **`RF-08` Send inquiry via contact channel:** Location map, official WhatsApp channel, and validated contact form.
- **`RF-09` Request technical service and diagnosis:** Preventive/corrective maintenance scheduling, fault code lookup, jam guide, and renting simulator.
- **`RF-10` Report renting counters:** Monthly B/W and color page meter reporting by authenticated customers.
- **`RF-11` Administer catalog and operations:** Restricted panel with KPIs, catalog/order/request/counter management, and safe CSV export.
- **`RF-12` Manage status notifications:** Order/appointment status alerts and mark-as-read actions.

### Non-Functional Requirements (`8`)
- **`RNF-01` Usability:** Reach any category or product in `<= 3` clicks with clear semantic headings.
- **`RNF-02` Responsiveness:** Zero horizontal overflow from `320 px` up and `24–44 px` touch targets.
- **`RNF-03` Accessibility:** `>= 4.5:1` contrast (light/dark), visible keyboard focus, modal focus traps, and alt texts.
- **`RNF-04` Performance:** Lazy-loaded WebP images, offline caching (`sw.js`), and compressed responses.
- **`RNF-05` Security and privacy:** Salted hash passwords, RBAC, rate limiting, abuse throttling, and `is_owner` PII masking.
- **`RNF-06` Availability and contingency:** Static catalog fallback (`localStorage`/JSON) and WhatsApp channel when backend is unavailable.
- **`RNF-07` Localization:** `es-CO` interface, `COP` currency, and Colombian date formatting.
- **`RNF-08` Maintainability and verification:** Decoupled modules and automated E2E + regression suite (`19` tests).

### Actors and Key Constraints
- **Actors (`5`):** `Visitante`, `Cliente Registrado` (visitor specialization), `Administrador`, `Pasarela de Pagos` (secondary), `Servicio de Mensajería` (secondary).
- **Constraints:** Guest browsing, quoting, and purchasing without prior sign-in (`RNF-06`); strict PII masking on public lookups; formula-injection neutralization on CSV exports (`RF-11`); zero real secrets or real personal data in public repo.

---

## 2. Technology Platform Selection and Justification

| Layer / Dimension | Chosen technology | Justification with `4` concrete conditions of `Fotocopiadora SyP` |
|---|---|---|
| **OO Language & Backend API** | **Python `3.12` + FastAPI (OOP + Pydantic v2)** | **1.** Enables explicit OO entities, ports/interfaces (`ABC`/`Protocol`), and GoF patterns (**Command** and **Abstract Factory**) with strict typing.<br>**2.** Pydantic schema validation protects `RF-05` (`cantidad >= 1`, catalog existence) and `RF-10` before hitting the DB.<br>**3.** Emits verifiable OpenAPI contracts for automated testing (`pytest` + `Playwright`, `RNF-08`).<br>**4.** Mature libraries (`bcrypt`, `pyjwt`) solve `RNF-05` cleanly without heavy runtimes. |
| **Database** | **Relational Database (`PostgreSQL 16` in prod / `SQLite 3` in dev & QA)** | **1.** `RF-03` (recursive equipment–supply compatibility) and `RF-05`/`RF-06` (header + `detalle_pedido`/`detalle_cotizacion`) require **strict referential integrity** and composite PK/`UNIQUE` keys.<br>**2.** Server-side recalculation and frozen agreed prices demand ACID transactions.<br>**3.** Weak entity `notificacion` and ownership queries (`id_usuario`) execute cleanly via indexed SQL joins and `ON DELETE CASCADE`/`RESTRICT`.<br>**4.** Admin reporting (`RF-11`) relies on accurate aggregate queries without duplication. |
| **Web Frontend / Fallback** | **HTML5 / CSS3 / Modular JS (PWA `sw.js`)** | Directly satisfies `RNF-02` (`>= 320 px`), `RNF-03` (`4.5:1`), `RNF-04` (`WebP` + `lazy`), and `RNF-06` (`dist/` static mode + `localStorage` fallback). |

---

## 3. List of Design Deliverables (`G2-P1`)

- `A1` Interpretation sheet & platform ([01-interpretation-sheet-and-platform.md](01-interpretation-sheet-and-platform.md))
- `A2` + `A3` OO class diagram (`24` elements) & `2` GoF patterns ([02-class-diagram-and-patterns.md](02-class-diagram-and-patterns.md) · [`.drawio`](../02-diagrama-clases.drawio) · [`.svg`](../02-diagrama-clases.svg))
- `A4` Hexagonal architecture & `8`-NFR table ([03-software-architecture.md](03-software-architecture.md) · [`.drawio`](../03-arquitectura-software.drawio) · [`.svg`](../03-arquitectura-software.svg))
- `A5` Component view with `7` components ([04-component-view.md](04-component-view.md) · [`.drawio`](../04-vista-componentes.drawio) · [`.svg`](../04-vista-componentes.svg))
- `A6` Deployment view with `5` nodes ([05-deployment-view.md](05-deployment-view.md) · [`.drawio`](../05-vista-despliegue.drawio) · [`.svg`](../05-vista-despliegue.svg))
- `A7` Analysis → design traceability matrix ([06-design-traceability-matrix.md](06-design-traceability-matrix.md))

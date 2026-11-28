> **Spanish version (official rubric root):** [../04-matriz-rf-casos-uso.md](../04-matriz-rf-casos-uso.md)

# Functional Requirement → Use Case Matrix · Fotocopiadora SyP

This matrix verifies full coverage between the functional requirements consolidated in [00-base-srs-input.md](00-base-srs-input.md) and the use cases modeled in [../03-diagrama-casos-uso.svg](../03-diagrama-casos-uso.svg), explicitly keeping non-functional requirements separate (`C3` of `Rubricas_G1.md`).

---

## 1. Direct Coverage `FR → Use Case` (`12 / 12 = 100 %`)

| ID FR | Functional requirement | Covering use case(s) | Status | Justification / Note |
|---|---|---|---|---|
| `RF-01` | Display home and value proposition | `CU-01` Consultar inicio y catálogo de productos | Covered | Presents home page, featured categories, services, and instant catalog access. |
| `RF-02` | Browse, filter, and compare catalog | `CU-01` Consultar inicio y catálogo de productos | Covered | Integrates category filters, live search, 12-item pagination, and equipment comparator. |
| `RF-03` | View product sheet and compatibilities | `CU-01` Consultar inicio y catálogo de productos | Covered | Quick view displays technical sheet, stock, and compatible products. |
| `RF-04` | Manage persistent shopping cart | `CU-02` Gestionar carrito de compras | Covered | Handles item additions, quantity updates, removals, and persistent total calculation. |
| `RF-05` | Confirm purchase order | `CU-03` Confirmar pedido de compra, `CU-05` Consultar documento comercial | Covered | Captures shipping/payment, prevents double submission, and issues viewable receipt. |
| `RF-06` | Generate and view formal quote | `CU-04` Generar cotización formal, `CU-05` Consultar documento comercial | Covered | Issues unique code from cart/quoter and opens printable viewer with privacy control. |
| `RF-07` | Manage user account and history | `CU-06` Autenticar cuenta de usuario, `CU-07` Gestionar perfil e historial comercial | Covered | Separates sign-in/registration (`CU-06`) from personal history lookup (`CU-07`). |
| `RF-08` | Send inquiry via contact channel | `CU-08` Enviar consulta de contacto | Covered | Covers location map, direct channels, and contact form with confirmation. |
| `RF-09` | Request technical service and diagnosis | `CU-09` Solicitar servicio técnico y diagnóstico | Covered | Groups fault-code/jam diagnosis, renting calculator, coverage, and technical scheduling. |
| `RF-10` | Report renting counters | `CU-10` Reportar contadores de renting *(includes `CU-06`)* | Covered | Records periodic B/W and color readings after owner authentication. |
| `RF-11` | Administer catalog and operations | `CU-11` Administrar catálogo y operaciones comerciales | Covered | Centralizes catalog, operational statuses, analytics, and safe report exports. |
| `RF-12` | Manage status notifications | `CU-12` Gestionar notificaciones de estado | Covered | Allows listing order/appointment alerts and marking them read for customer and admin. |

- **Total functional requirements in SRS:** `12`
- **Requirements covered by at least one use case:** `12` (`100 %`, exceeds the `90 %` minimum).
- **Uncovered functional requirements:** `0`.

---

## 2. Reverse Audit `Use Case → FR` (`12 / 12 = 100 %`)

| Use case | Functional requirements addressed | Orphan use case? |
|---|---|---|
| `CU-01` Consult home and product catalog | `RF-01`, `RF-02`, `RF-03` | No |
| `CU-02` Manage shopping cart | `RF-04` | No |
| `CU-03` Confirm purchase order | `RF-05` | No |
| `CU-04` Generate formal quote | `RF-06` | No |
| `CU-05` View commercial document | `RF-05`, `RF-06` | No |
| `CU-06` Authenticate user account | `RF-07`, `RF-10` *(via `«include»`)* | No |
| `CU-07` Manage profile and commercial history | `RF-07` | No |
| `CU-08` Send contact inquiry | `RF-08` | No |
| `CU-09` Request technical service and diagnosis | `RF-09` | No |
| `CU-10` Report renting counters | `RF-10` | No |
| `CU-11` Administer catalog and commercial operations | `RF-11` | No |
| `CU-12` Manage status notifications | `RF-12` | No |

---

## 3. Explicit Distinction of Non-Functional Requirements (`NFR`)

Requirements `RNF-01` to `RNF-08` (usability, >= 320 px responsiveness, WCAG 2.2 AA accessibility, WebP/cache performance, data security/privacy, offline fallback availability, COP localization, and automated verifiability) **do not appear as use case ovals**, as they cross-cuttingly constrain how `CU-01` to `CU-12` must operate and are documented in business rules, design criteria, and validation checklists inside [G1-P2 English](../../G1-P2-fotocopiadora-syp/english/README.md).

---

## 4. Verification Closure (Day 2 · `2026-11-26`)

- **`FR → UC` coverage verified on second pass:** `12 / 12` (`100 %`), with zero orphan use cases in reverse audit (`12 / 12`).
- **Cross-traceability to Product 2:** all `12 RF` link to [09-traceability-matrix.md](../../G1-P2-fotocopiadora-syp/english/09-traceability-matrix.md).

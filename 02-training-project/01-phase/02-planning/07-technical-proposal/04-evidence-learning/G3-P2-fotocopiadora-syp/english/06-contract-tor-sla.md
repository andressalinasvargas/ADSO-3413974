> **Spanish version (official rubric root):** [../06-contrato-tdr-ans.md](../06-contrato-tdr-ans.md)

# B6 · Contractual Framework, Terms of Reference (ToR), and Service Level Agreements (SLA) — Fotocopiadora SyP

> **Purpose:** Define the complete contract structure (`14` essential elements), specific technical Terms of Reference (`TdR-01`–`TdR-08`), and measurable Service Level Agreements (`ANS-01`–`ANS-04`) for deploying and operating **Fotocopiadora SyP** under **Provisional Scenario B**, traced 1:1 to the `7` nodes in [`../03-diagrama-arquitectura-despliegue-g3.svg`](../03-diagrama-arquitectura-despliegue-g3.svg).

---

## 1. Essential Elements of the Implementation Contract (`14` Components)

| # | Contract element | Mandatory minimum scope for Fotocopiadora SyP | Linked document / evidence |
|---:|---|---|---|
| **1** | **Contracting parties & object** | Identifies **Fotocopiadora SyP** (Client) and Contractor; object covers design, build, deployment, and rollout of the e-commerce portal and technical service system with monthly counter reporting. | `G3-P2` Technical & economic proposal |
| **2** | **Functional scope & explicit exclusions** | Covers all `12 RF` (`RF-01`–`RF-12`), `8 RNF` (`RNF-01`–`RNF-08`), `12` PostgreSQL 16 tables, and configurable payment gateway; excludes unspecified accounting ERP integrations or client hardware (`[N1]` and `[N2]`). | [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) |
| **3** | **Intellectual property & licensing** | Written cession of economic rights over source code, DDL scripts, views, diagrams, and manuals to Client (`Law 23/1982`, `Andean Decision 351/1993`); permissive third-party notice compliance (`MIT`/`BSD`/`Apache-2.0`). | [04-license-sizing.md](../../G3-P1-fotocopiadora-syp/english/04-license-sizing.md) |
| **4** | **Schedule & verifiable milestones** | Analysis/design, backend/DB, frontend/quoter, integration tests (`pytest` + `Playwright` + `node --check`), production deployment, and documentation handover tied to sign-off minutes. | Implementation milestone plan |
| **5** | **Contract price, taxes & payment terms** | CAPEX/OPEX and labor breakdown within reference ceiling (**`$70,000,000 COP`** in Provisional Scenario B), milestone-based payments upon validation. | Budget & vendor quotes (`B1`–`B4`, Day 2) |
| **6** | **Service Level Agreements (SLA / ANS)** | Quantitative targets for availability (`ANS-01`), latency (`ANS-02`), backup (`ANS-03`), and incident response (`ANS-04`), with scheduled maintenance windows. | Section 3 below |
| **7** | **Data protection & confidentiality (`Law 1581/2012`)** | Non-disclosure clause, explicit designation of cloud/messaging vendor as **data processor** (**transmission** agreement under `Decree 1074/2015`), prohibition on secondary commercial use. | [03-technical-regulatory-reference.md](../../G3-P1-fotocopiadora-syp/english/03-technical-regulatory-reference.md) |
| **8** | **Information security & auditability** | Enforcement of `TLS 1.3` at `[N3]`, `BCrypt` & `PyJWT` in `HttpOnly` cookie `syp_session` at `[N4]`, private `TCP 5432` at `[N5]`, `AES-256` backups at `[N6]`, and technical audit rights (`POL-INT/CON/DIS`). | [06-data-security-policies.md](../../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/english/06-data-security-policies.md) |
| **9** | **Warranty & post-deployment support** | Corrective warranty window covering code defects plus optional evolutionary maintenance retainer. | SLA severity & response table |
| **10** | **Training & knowledge transfer** | Hands-on training sessions on catalog, quotes, service tickets, and counter reports for staff across `2` branches + user/operations manuals. | Handover guides |
| **11** | **Change control governance** | Formal change-request workflow requiring written impact evaluation (technical, cost, schedule) and prior written approval for out-of-scope features. | Change request template |
| **12** | **Client & Contractor obligations** | SyP provides initial real catalog & domain credentials on schedule; Contractor delivers tested, clean, documented software. | Verification checklist `B5` |
| **13** | **Penalties, service credits & force majeure** | Proportional service-credit/remediation schedule for repeated `ANS-01`..`ANS-04` breaches, excluding force majeure or third-party outages beyond reasonable control. | SLA credit table |
| **14** | **Termination, exit portability & dispute resolution** | Direct settlement mechanism plus guaranteed handover of source code, standard SQL/CSV database dumps, and digital assets at contract end without lock-in. | Exit & portability clause |

---

## 2. Specific Technical Terms of Reference (`TdR-01` – `TdR-08`)

| ToR Code | Requirement title | Mandatory technical specification for Fotocopiadora SyP | G1 / G2 / G3 Traceability |
|---|---|---|---|
| **`TdR-01`** | **Commercial catalog, supply compatibility & cart** | Paginated publishing (`12` items) of categories/products, M:N device–supply compatibility (`compatibilidad_producto` with `ck_comp_distintos`), side-by-side comparison, and persistent cart (`precio_cop >= 0`, `estado_stock`, `localStorage` contingency). | `RF-01`–`RF-04`, `RNF-01`, `RNF-04`, `RNF-06` \| `[N1]`, `[N3]`, `[N4]` |
| **`TdR-02`** | **Transactional order & payment management** | Atomic persistence of `pedido` & `detalle_pedido` with frozen `precio_unitario_pactado`, exclusive server-side recalculation (`subtotal`, `iva`, `total >= subtotal` with `CHECK ck_ped_tot`), payment/shipping states, and double-submit prevention. | `RF-05`, `POL-INT-03`, `Law 1480/2011` \| `[N4]`, `[N5]` |
| **`TdR-03`** | **Formal printable quotation engine** | Generation and lookup of quotes with unique code (`codigo_cotizacion`), configurable validity (`vigencia_dias` `1..90`), `is_owner` PII masking for non-owners, and dispatch via **Abstract Factory** (`IFabricaEntregaComercial`). | `RF-06`, `POL-CON-03`, `Law 527/1999` \| `[N4]`, `[N5]` |
| **`TdR-04`** | **Technical service desk & monthly counter reporting** | Maintenance/diagnostic appointment intake (`solicitud_servicio` with `codigo_seguimiento`) and unique monthly B/W & color meter reporting by authenticated customer (`reporte_contador`, `uk_rep_usuario_eq_mes`, `contador >= 0`). | `RF-09`, `RF-10`, `G2-P2` \| `[N1]`, `[N4]`, `[N5]` |
| **`TdR-05`** | **Public contact, notifications & admin operations** | Public inquiry inbox (`mensaje_contacto`) + WhatsApp channel, weak entity `notificacion`, admin panel on `[N2]`, and sanitized CSV export (`ExportadorCsvSeguro`) neutralizing formulas (`=,+,-,@`). | `RF-07`, `RF-08`, `RF-11`, `RF-12` \| `[N2]`, `[N4]`, `[N5]` |
| **`TdR-06`** | **Hexagonal Architecture & `7`-node deployment topology** | `24`-element OO core (**Command** + **Abstract Factory**, `7` components), `PostgreSQL 16` DB (`12` 3FN tables), and deployment across `[N1]`–`[N7]` free of portability lock-in. | `G2-P1` Hexagonal \| `[N1]`–`[N7]` |
| **`TdR-07`** | **Security, privacy & accessibility controls** | `HTTPS 443 TLS 1.3` on `[N3]`, `BCrypt` & `HttpOnly` cookie `syp_session` on `[N4]`, private `TCP 5432` DB on `[N5]`, `AES-256` backups on `[N6]`, `Law 1581/2012` and `WCAG 2.2 AA` compliance. | `RNF-02`, `RNF-03`, `RNF-05`, `POL-CON-01..03` \| `[N3]`–`[N6]` |
| **`TdR-08`** | **Quality, test automation & `es-CO` localization** | Automated test coverage via `pytest` + `httpx`, `Playwright` E2E, `node --check` syntax verification, `es-CO` / `COP` formatting, and technical/user manuals. | `RNF-07`, `RNF-08`, `A4` |

---

## 3. Measurable Service Level Agreements (`ANS-01` – `ANS-04`)

| SLA Code | Key indicator (KPI) | Scenario A (Base) | **Scenario B (Provisional)** | Scenario D (Enterprise) | Involved nodes & measurement (`[N1]`–`[N7]`) |
|---|---|---:|---:|---:|---|
| **`ANS-01`** | **Monthly operational availability** | `99.0 %` (<= `7.3 h` downtime/mo) | **`99.5 %`** (<= `3.6 h` downtime/mo) | `99.9 %` (<= `43 min` downtime/mo) | Continuous `60 s` `HTTPS` probes from **`[N7]`** over **`[N3]`**, **`[N4]`**, and **`[N5]`**. |
| **`ANS-02`** | **API response latency (`p95`)** | `<= 2.0 s` | **`<= 1.5 s`** | `<= 800 ms` | `95th` percentile on catalog, order, and quote endpoints measured across **`[N3]` → `[N4]`** by **`[N7]`**. |
| **`ANS-03`** | **Recovery Point Objective (`RPO`)** | `<= 24 h` | **`<= 24 h`** (daily `02:00 COT` backup) | `<= 15 min` | Automated verification of daily **`[N5]`** dumps encrypted `AES-256` in **`[N6]`** (`30`-day retention). |
| **`ANS-04`** | **Incident response & Recovery Time (`RTO`)** | 1st response `<= 1 h`; `RTO <= 8 h` | **`P1 <= 30 min`; `RTO <= 2 h`** | `P1 <= 15 min`; `RTO <= 30 min` | Early alerts from **`[N7]`** + monthly restore drill from **`[N6]`** to **`[N5]`** & **`[N4]`**. |

### Incident Severity Levels (`ANS-04`)

| Severity | Operational definition in Fotocopiadora SyP | Max 1st response (Scenario B) | Target mitigation / restore |
|---|---|---:|---:|
| **`P1` — Critical** | Total outage of `[N3]` / `[N4]`, `PostgreSQL [N5]` unavailability, or security incident risking data exposure. | **`<= 30 min`** | **`<= 2 h` (`RTO`)** |
| **`P2` — High** | Critical module fault in `[N4]` (orders, quotes, or counters) while rest of portal stays online. | `<= 2 h` | `<= 6 h` |
| **`P3` — Medium** | Non-blocking partial degradation, responsive CSS defect, or minor PWA issue. | `<= 8 business h` | Next scheduled maintenance (`<= 48 h`) |

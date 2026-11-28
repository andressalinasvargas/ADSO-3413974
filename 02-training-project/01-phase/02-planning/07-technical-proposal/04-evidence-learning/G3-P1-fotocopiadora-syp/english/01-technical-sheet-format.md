> **Spanish version (official rubric root):** [../01-formato-ficha-tecnica.md](../01-formato-ficha-tecnica.md)

# A1 · Standardized Software Technical Sheet Format — Fotocopiadora SyP

> **Purpose:** Establish a vendor-neutral, standardized template to technically specify modules, artifacts, and infrastructure for **Fotocopiadora SyP** (multifunction equipment/supply e-commerce and technical service management with monthly counter reporting), aligned with **ISO/IEC/IEEE 29148:2018** and **ISO/IEC 25010:2023**.

---

## 1. Methodological Framework and Technology Neutrality

- **Requirements engineering standard:** `ISO/IEC/IEEE 29148:2018` (completeness, consistency, verifiability, and bidirectional traceability).
- **Software quality standard:** `ISO/IEC 25010:2023` (functional suitability, performance efficiency, compatibility, interaction capability, reliability, security, maintainability, and flexibility).
- **Neutrality principle:** Fields describe technical capabilities, open standards (`HTTPS TLS 1.3`, `REST/JSON`, `Standard SQL`, `HTML5/CSS3/ES`, `UTF-8`), and objective metrics without locking into a single cloud vendor or hardware brand.
- **Project traceability:**
  - Functional & non-functional source (`G1-P1`): [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) (`12 RF` `RF-01`–`RF-12`, `8 RNF` `RNF-01`–`RNF-08`, `5` actors).
  - Architectural source (`G2-P1`): [Hexagonal Architecture & Views](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/english/03-software-architecture.md) (`24` OO elements, **Command** and **Abstract Factory** patterns, `7` components, and `5` nodes).
  - Persistence & governance source (`G2-P2`): [Logical Model & Verified DDL](../../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/english/02-logical-model-and-transformation.md) (`12` 3FN tables) and [06-data-security-policies.md](../../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/english/06-data-security-policies.md) (`9` policies `POL-INT-01..03`, `POL-CON-01..03`, `POL-DIS-01..03`).

---

## 2. Standardized Technical Sheet Format (`15` Mandatory Fields)

| # | Standard field | Description & completion rules | Validation rule / evidence |
|---:|---|---|---|
| **1** | **Module code & name** | Unique identifier (`FT-SYP-XXX`) and functional name of component or artifact. | Naming consistent with `G2-P1` and `G3`. |
| **2** | **Version, date & status** | Semantic version (`vX.Y`), ISO date (`YYYY-MM-DD`), and status (`Draft`, `Validating`, `Approved`). | Change log recorded in field 15. |
| **3** | **Technical owner / role** | Role responsible for design, maintenance, and verification (zero PII). | Traceable to ADSO project roles. |
| **4** | **Purpose & functional scope** | Operational objective inside Fotocopiadora SyP and responsibility boundaries. | Must map to a component/port defined in `G2-P1`. |
| **5** | **Requirements traceability (FR / NFR)** | Explicit list of `RF-01`..`RF-12` and `RNF-01`..`RNF-08` codes served by the module. | Verifiable coverage against SRS input. |
| **6** | **Actors & access permissions** | Authorized actors (`Visitante`, `Cliente Registrado`, `Administrador`, `Pasarela de Pagos`, `Servicio de Mensajería`) & CRUD/RBAC scope. | Aligned with `POL-INT-01..03`, `POL-CON-01..03`, `POL-DIS-01..03`. |
| **7** | **Input & output interfaces (API / UI)** | Input/output contracts, HTTP codes (`200`, `201`, `400`, `401`, `403`, `404`, `422`), JSON payloads, and doc formats (`Printable PDF`, `CSV`). | Free of proprietary single-client lock-in. |
| **8** | **Data model & persistence** | Tables involved from the `12`-table schema (`G2-P2`), PK/FKs, and integrity rules. | Verifiable via DDL and SQL negative tests. |
| **9** | **Design pattern & architectural style** | Placement inside Hexagonal Architecture (domain core, inbound/outbound port, or adapter) and GoF pattern (**Command** / **Abstract Factory**). | Exact match with `02-diagrama-clases.svg` and `03-arquitectura-software.svg`. |
| **10** | **Sizing & capacity (Provisional Scenario B)** | Expected concurrency (`30` concurrent users / `120` monthly active users / `2` sites), data volume, and latency bounds. | Parameterized for `A4` and `G3-P2`. |
| **11** | **Quality attributes (ISO/IEC 25010:2023)** | Performance target (`p95 <= 1.5 s`), availability (`99.5 %` Scenario B), accessibility (`WCAG 2.2 AA` / `RNF-03`), and maintainability. | Measurable via automated tests and monitoring. |
| **12** | **Security & privacy controls** | Transit encryption (`TLS 1.3`), salted hash (`BCrypt`), auth (`PyJWT` in `HttpOnly` cookie `syp_session`), `is_owner` masking, `POL-CON-01..03`, and `Law 1581/2012`. | Mapped to OWASP ASVS & `06-data-security-policies.md`. |
| **13** | **Technical dependencies & licensing** | Required libraries under permissive open-source licenses (`MIT`, `BSD-3-Clause`, `Apache-2.0`, `Unlicense`) or open protocols, zero lock-in. | Zero copyleft licenses restricting patrimonial cession. |
| **14** | **Acceptance criteria & test suite** | Unit, integration, or SQL checks (`pytest`, `Playwright`, `node --check`, SQLite/PostgreSQL) with pass threshold. | Reproducible evidence prior to production. |
| **15** | **Revision history & validity** | Chronological log (`Version`, `Date`, `Change reason`, `Applied verification`). | Required prior to phase closure or contract signing. |

---

## 3. Mapping of Template to Fotocopiadora SyP Modules

Reference for full operational sheets (scheduled for **Day 2**), aligning the four functional blocks 1:1 with the `7` components, `24` OO elements, and `12` tables from `G2`:

| Sheet code | System module | Traced requirements (`G1-P1`) | Main tables (`G2-P2`) | Components, interfaces & patterns (`G2-P1`) |
|---|---|---|---|---|
| `FT-SYP-001` | **Catalog, Compatibility & Cart** | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RNF-01`, `RNF-04`, `RNF-06` | `categoria`, `producto`, `compatibilidad_producto` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` (`IRepositorioComercial`) |
| `FT-SYP-002` | **Orders, Payments & Quotes** | `RF-05`, `RF-06`, `RNF-05`, `RNF-06`, `RNF-07` | `pedido`, `detalle_pedido`, `cotizacion`, `detalle_cotizacion` | `NucleoPedidosCotizaciones`: **Command** (`IComandoOperacion`, `ComandoConfirmarPedido`, `ComandoEmitirCotizacion`) + **Abstract Factory** (`IFabricaEntregaComercial`, `FabricaEntregaPedido`, `FabricaEntregaCotizacion`) |
| `FT-SYP-003` | **Technical Service, Counters & Contact** | `RF-08`, `RF-09`, `RF-10`, `RNF-02`, `RNF-03`, `RNF-06` | `solicitud_servicio`, `reporte_contador`, `mensaje_contacto` | `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` + **Command** (`ComandoRadicarSolicitud`) |
| `FT-SYP-004` | **Identity, Admin, Notifications & Export** | `RF-07`, `RF-11`, `RF-12`, `RNF-05`, `RNF-08` | `usuario`, `notificacion` | `NucleoIdentidadAcceso`, `PanelAdminWeb`, `NucleoNotificacionesExport` (`ExportadorCsvSeguro`) |

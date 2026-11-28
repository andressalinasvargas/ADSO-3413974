> **Spanish version (official rubric root):** [../03-referente-tecnico-normativo.md](../03-referente-tecnico-normativo.md)

# A3 · Technical Reference and Regulatory Framework — Fotocopiadora SyP

> **Verification date:** `2026-11-27`  
> **Scope:** Consolidation of the applicable external legal and technical regulatory framework for **Fotocopiadora SyP**, strictly separated from the `9` internal data-security policies (`POL-INT-01..03`, `POL-CON-01..03`, `POL-DIS-01..03`) defined in [06-data-security-policies.md](../../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/english/06-data-security-policies.md).

---

## 1. Applicable External Regulatory Framework (`6` Verified References)

| # | Legal / Technical reference | Scope | Key provision applicable to Fotocopiadora SyP | Direct impact on design & contract |
|---:|---|---|---|---|
| **1** | **Law 1581 of 2012 & Decree 1074 of 2015** (Colombia Data Protection & Regulatory Title V) | Legal — Colombia (Habeas Data) | Governs processing of personal data (`usuario`, `solicitud_servicio`, `mensaje_contacto`, `pedido`, `cotizacion`) under purpose, prior/explicit/informed authorization, security, and retention principles. **Mandatory distinction between transmission and transfer:** when a cloud/backup/messaging vendor processes data on behalf of Fotocopiadora SyP (*processor / encargado*), it constitutes a **transmission** governed by a processing agreement; handing data to an autonomous *controller* is a **transfer** requiring specific consent or adequate-level country status. | Visible privacy notice on signup/contact, processor transmission clause in ToR (`B6`), `is_owner` masking, PII minimization, and deletion/logical deactivation upon data-subject request. |
| **2** | **Law 23 of 1982** (Colombian Copyright Law) | Legal — Colombia | Protects original software engineering works, diagrams, source code, and manuals, granting moral rights (inalienable) and economic rights (transferable via written assignment). | Requires explicit written assignment/licensing clause for source code, DDL scripts, views, diagrams, and manuals delivered to Fotocopiadora SyP. |
| **3** | **Andean Decision 351 of 1993** (Common Regime on Copyright & Neighboring Rights) | Legal — Andean Community | Expressly equates computer programs (source & object code) and technical documentation to protected literary works, requiring written transfer for economic-rights exploitation. | Supports proprietary custom software licensing and forces clean permissive third-party inventory without copyleft contamination (`A4`). |
| **4** | **WCAG 2.2 Level AA & ISO/IEC 25010:2023** | International Technical Standards | `WCAG 2.2 AA` sets verifiable accessibility criteria (`>= 4.5:1` contrast, full keyboard navigation, visible focus, accessible labels on service/quote forms). `ISO/IEC 25010:2023` standardizes software product quality attributes (functional suitability, performance efficiency, compatibility, interaction, reliability, security, maintainability, flexibility). | Guides responsive web UI audit (`RNF-02`, `RNF-03`) and sets measurable targets (`p95 <= 1.5 s`, `99.5 %` availability in Scenario B, automated test coverage). |
| **5** | **Law 527 of 1999** (E-Commerce, Data Messages & Digital Signatures) | Legal — Colombia | Grants functional equivalence, legal validity, and evidentiary weight to electronic data messages when kept accessible and intact for later inspection. | Backs validity of electronic quotes (`cotizacion`), purchase orders (`pedido`), status notifications (`notificacion`), and historical frozen-price traceability. |
| **6** | **Law 1480 of 2011** (Colombian Consumer Statute) | Legal — Colombia | Mandates clear, truthful, and sufficient disclosure of total prices including taxes (`COP`), technical specs, supply compatibilities, warranties, shipping terms, and right of withdrawal in e-commerce. | Justifies explicit breakdown of `subtotal`, `iva` (`19 %`), `total`, `vigencia_dias` (`CHECK ck_cot_vig`), and `precio_unitario_pactado` / `precio_unitario_cotizado` (`05-script-creacion.sql`) plus `compatibilidad_producto`. |

---

## 2. Strict Separation from Internal Data Security Policies (`G2-P2`)

| Internal policies (`G2-P2`) | Principle / Nature | Link to external regulatory framework |
|---|---|---|
| **`POL-INT-01`, `POL-INT-02`, `POL-INT-03`** *(Engine integrity, logical deactivation & server-side recalculation)* | Internal data integrity controls (`12` FKs, `33` `CHECK`, `uk_rep_usuario_eq_mes`) | Support practical compliance with `Law 1480/2011` (accurate pricing) & `Law 527/1999`. |
| **`POL-CON-01`, `POL-CON-02`, `POL-CON-03`** *(Salted `BCrypt`, `TLS 1.3`, `HttpOnly` cookie `syp_session`, `is_owner`, safe CSV)* | Internal confidentiality & RBAC controls | Implement security, consent, and PII reservation mandated by `Law 1581/2012`, `Decree 1074/2015` & `ISO/IEC 25010:2023`. |
| **`POL-DIS-01`, `POL-DIS-02`, `POL-DIS-03`** *(`02:00 COT` `AES-256` backup, monthly restore drill, static contingency `RNF-06`)* | Internal availability & continuity controls | Guarantee intact future retrieval (`Law 527/1999`) & resilience (`ISO/IEC 25010:2023`). |

---

## 3. Compliance Verification Matrix on Fotocopiadora SyP Components

| System component (`G2-P1`) | Binding regulation | Concrete compliance mechanism |
|---|---|---|
| **`WebCatalogoPWA` & `PanelAdminWeb`** | `WCAG 2.2 AA`, `Law 1480/2011`, `RNF-02`, `RNF-03` | Semantic HTML5 tags, `>= 4.5:1` contrast, keyboard support, `es-CO`/`COP` formatting, full `subtotal`/`iva`/`total` breakdown before confirmation. |
| **`NucleoIdentidadAcceso` (`FastAPI`)** | `Law 1581/2012`, `ISO/IEC 25010:2023`, `POL-CON-01..03` | Strict Pydantic validation, salted `BCrypt`, `HttpOnly` cookie `syp_session` over `TLS 1.3`, and `is_owner` PII masking. |
| **`AdaptadorPersistenciaSQL` (`PostgreSQL 16`)** | `Law 1581/2012`, `Decree 1074/2015`, `POL-INT-01..02` | Encryption at rest, FKs with `ON DELETE RESTRICT/CASCADE/SET NULL`, `uk_rep_usuario_eq_mes` uniqueness, private `TCP 5432`. |
| **`NucleoPedidosCotizaciones` (`Pedido` / `Cotizacion`)** | `Law 527/1999`, `Law 1480/2011`, `POL-INT-03` | Immutable unique codes (`codigo_pedido`, `codigo_cotizacion`), `vigencia_dias` (`1..90`), and frozen `precio_unitario_pactado` / `precio_unitario_cotizado`. |
| **Source code & engineering artifacts** | `Law 23/1982`, `Andean Decision 351/1993` | Moral authorship declaration, written cession of economic rights, and strictly permissive dependencies (`MIT`/`BSD`/`Apache-2.0`). |

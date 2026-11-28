> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery · Guide 1 · Conceptual Model (Product 2 — English Version)

Delivery path in fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/`

Guide deadline: **Saturday, November 28, 2026 at 6:00 a.m.**

---

## 1. Delivery Details

- **Product:** P2 analysis model and verification
- **Author's GitHub handle:** `@andressalinasvargas`
- **Case study:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**
- **Year-long team work:** Yes — collaborative year project built with **Equipo Fotocopiadora SyP** (behavioral models, domain, ERD, verification, and adjustments in Product 2 are individual work by `@andressalinasvargas`).

## 2. What I Reused

| Artifact | Origin path or reference (prior year work) | Solo or team? |
|---|---|---|
| Functional baseline and initial entities | Conceptual architecture, product catalog, order/quote flow, and business rules built during the year project (**Equipo Fotocopiadora SyP**) | Team (**Equipo Fotocopiadora SyP**) |
| Updated checkout, technical diagnosis, and admin flows | Consolidated functional specs and screens of **Fotocopiadora SyP** (including pagination, AA contrast, anti-double-submit, and safe export) | Team (**Equipo Fotocopiadora SyP**) |
| Verification and traceability methodology | Prior individual analysis work in `03-execute/` and consolidated requirements in [G1-P1 English](../../G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) | Solo (`@andressalinasvargas`) |

## 3. What I Adjusted

| # | Artifact | What I changed and why | Commit link |
|---|---|---|---|
| 1 | [../01-actividad-cu03-confirmar-pedido.drawio](../01-actividad-cu03-confirmar-pedido.drawio), [../02-actividad-cu09-servicio-tecnico.drawio](../02-actividad-cu09-servicio-tecnico.drawio) and [03-extended-use-case-templates.md](03-extended-use-case-templates.md) | Aligned every `[...]` bracket guard in activity diagrams with alternative/exception flows of the 3 extended templates, removing stock checks from preconditions and removing technical terms (`H-03`, `H-04`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 2 | [04-domain-model-description.md](04-domain-model-description.md) and [../04-modelo-dominio.drawio](../04-modelo-dominio.drawio) | Abstracted `12` pure conceptual classes with zero methods or foreign keys, adding `ReporteContador`, `Persona` generalization, and `DetallePedido` association class (`H-02`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 3 | [05-erd-description.md](05-erd-description.md) and [../05-modelo-entidad-relacion.drawio](../05-modelo-entidad-relacion.drawio) | Formalized declared **Crow's Foot** notation with total/partial participation, `N:M` resolution in `DETALLE_PEDIDO`/`DETALLE_COTIZACION`, weak entity `NOTIFICACION`, and recursive relationship on `PRODUCTO` (`H-05`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 4 | [07-validation-checklist.md](07-validation-checklist.md), [08-adjustment-log.md](08-adjustment-log.md), [09-traceability-matrix.md](09-traceability-matrix.md) and [10-analysis-report.md](10-analysis-report.md) | Executed `18`-criterion checklist (`5` coverage criteria), documented `6` resolved findings (`H-01`–`H-06`) including synthetic PII cleanup, and achieved `12/12 RF` traceability (`100 %`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |

## 4. What I Built New

- **2 UML activity diagrams** with swimlanes, complete guards, and `fork`/`join` bars for `CU-03` and `CU-09`.
- **3 extended use case templates** (`CU-03`, `CU-09`, `CU-11`) in [03-extended-use-case-templates.md](03-extended-use-case-templates.md).
- **12-class domain model** and **11-entity Crow's Foot ERD** with descriptions and `.drawio` editable sources.
- **4 labeled initial wireframes** in [06-initial-prototype.md](06-initial-prototype.md).
- **Validation checklist (`18` criteria), `6`-finding adjustment log, Annex C matrix, and analysis report** in [10-analysis-report.md](10-analysis-report.md).

## 5. Delivered Artifacts

**Product 2**

- [x] Activity diagrams (2): [CU-03 Confirm order](../01-actividad-cu03-confirmar-pedido.svg) ([`.drawio`](../01-actividad-cu03-confirmar-pedido.drawio) · [`.png`](../01-actividad-cu03-confirmar-pedido.png)) and [CU-09 Technical service](../02-actividad-cu09-servicio-tecnico.svg) ([`.drawio`](../02-actividad-cu09-servicio-tecnico.drawio) · [`.png`](../02-actividad-cu09-servicio-tecnico.png))
- [x] Extended use case templates (3): [03-extended-use-case-templates.md](03-extended-use-case-templates.md)
- [x] Domain model: [04-domain-model-description.md](04-domain-model-description.md) · [../04-modelo-dominio.drawio](../04-modelo-dominio.drawio) · [`.svg`](../04-modelo-dominio.svg) · [`.png`](../04-modelo-dominio.png)
- [x] Entity-Relationship Model: [05-erd-description.md](05-erd-description.md) · [../05-modelo-entidad-relacion.drawio](../05-modelo-entidad-relacion.drawio) · [`.svg`](../05-modelo-entidad-relacion.svg) · [`.png`](../05-modelo-entidad-relacion.png)
- [x] Initial prototype (4 labeled screens): [06-initial-prototype.md](06-initial-prototype.md)
- [x] Filled validation checklist (18 criteria, 5 coverage): [07-validation-checklist.md](07-validation-checklist.md)
- [x] Adjustment log & second verification: [08-adjustment-log.md](08-adjustment-log.md)
- [x] Analysis report (Annex E): [10-analysis-report.md](10-analysis-report.md)
- [x] Traceability matrix (Annex C): [09-traceability-matrix.md](09-traceability-matrix.md)

## 6. Authorship Declaration

- [x] I declare that adjustments and new work in this folder are **my individual work**.
- [x] I declare that reused material from team/prior sources is identified in Section 2.
- [x] I understand the oral verification rules for Saturday, November 28, 2026.

Signature (GitHub handle and date): `@andressalinasvargas` · `2026-11-26`

## 7. Use of Artificial Intelligence

| Tool | What I used it for | What I verified or corrected myself |
|---|---|---|
| Antigravity (AI assistant) | Support in writing technology-free `CU-03`/`CU-09`/`CU-11` templates, generating `.drawio`/`.svg`/`.png` diagrams and wireframes, cross-checking Annex C, and translating documentation to English. | Manually verified 1:1 guard alignment between activity diagrams and templates, absence of methods/FKs in the domain model, Crow's Foot cardinalities in ERD, visual inspection of screens, and zero real PII. |

## 8. Pre-Push Self-Check

- [x] Committed across at least 2 distinct days (`2026-11-25` and `2026-11-26` for the Spanish rubric root).
- [x] Excluded instructor templates and personal data.
- [x] Verified GitHub publication.

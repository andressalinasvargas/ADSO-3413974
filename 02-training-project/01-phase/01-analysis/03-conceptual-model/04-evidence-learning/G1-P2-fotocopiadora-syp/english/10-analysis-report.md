> **Spanish version (official rubric root):** [../10-informe-analisis.md](../10-informe-analisis.md)

# Analysis Report · Fotocopiadora SyP

**Guide 1 · Conceptual Model (Product 2)** · Author: `@andressalinasvargas` · Last verification (Day 2): `2026-11-26`

---

## 1. Case Requirements Interpretation

Building upon prior year work developed with **Equipo Fotocopiadora SyP** and its latest functional consolidation, system requirements were interpreted and organized into two clearly separated sets in [00-base-srs-input.md](../../G1-P1-fotocopiadora-syp/english/00-base-srs-input.md):

1. **12 Functional Requirements (`RF-01` to `RF-12`)**: span the complete consultative sales and technical service lifecycle — home showcase and 12-item paginated catalog with comparator and compatibilities (`RF-01`–`RF-03`), persistent shopping cart (`RF-04`), multi-method checkout with duplicate-submission prevention (`RF-05`), printable formal quotes with privacy masking (`RF-06`), account and history management (`RF-07`), contact channel (`RF-08`), technical self-diagnosis and maintenance scheduling (`RF-09`), monthly renting counter reporting (`RF-10`), restricted administration with analytics and safe exports (`RF-11`), and status notifications (`RF-12`).
2. **8 Non-Functional Requirements (`RNF-01` to `RNF-08`)**: constrain usability (<= 3 interactions), zero horizontal overflow from 320 px, WCAG 2.2 AA accessibility (>= 4.5:1 contrast and keyboard navigation), WebP/offline cache performance, security/privacy, static fallback availability, Colombian peso (`es-CO`/`COP`) localization, and automated verifiability.

The 4-aspect characterization in [01-characterization-and-methodologies.md](../../G1-P1-fotocopiadora-syp/english/01-characterization-and-methodologies.md) justified **Scrum** as the ideal methodology for a small team with evolving requirements and high business availability, executed via an `8`-activity plan in [02-analysis-activity-plan.md](../../G1-P1-fotocopiadora-syp/english/02-analysis-activity-plan.md).

---

## 2. Interconnected Analysis Models

- **Functional model (UML Use Cases)**: [../03-diagrama-casos-uso.svg](../../G1-P1-fotocopiadora-syp/03-diagrama-casos-uso.svg) ([`.drawio`](../../G1-P1-fotocopiadora-syp/03-diagrama-casos-uso.drawio)) and [03-use-case-relationships-justification.md](../../G1-P1-fotocopiadora-syp/english/03-use-case-relationships-justification.md), featuring system boundary, `12` verb + object use cases, `3` primary actors (`Cliente Registrado --|> Visitante`, `Administrador`), `2` secondary actors (`Pasarela de Pagos`, `Servicio de Mensajería`), `3 «include»`, and `2 «extend»`, verified at `100 %` in [04-fr-use-case-matrix.md](../../G1-P1-fotocopiadora-syp/english/04-fr-use-case-matrix.md).
- **Detailed behavior (Activity Diagrams & Templates)**:
  - Activity diagrams with actor swimlanes, full `[...]` guards, and parallel `fork`/`join` bars: [CU-03 Confirm purchase order](../01-actividad-cu03-confirmar-pedido.svg) ([`.drawio`](../01-actividad-cu03-confirmar-pedido.drawio)) and [CU-09 Request technical service](../02-actividad-cu09-servicio-tecnico.svg) ([`.drawio`](../02-actividad-cu09-servicio-tecnico.drawio)).
  - Three extended templates strictly free of technical implementation details in [03-extended-use-case-templates.md](03-extended-use-case-templates.md) (`CU-03`, `CU-09`, `CU-11`).
- **Conceptual business model (Domain)**: `12` abstract classes without methods or foreign keys, including `Persona` generalization and `DetallePedido` association class, in [04-domain-model-description.md](04-domain-model-description.md) and [../04-modelo-dominio.svg](../04-modelo-dominio.svg) ([`.drawio`](../04-modelo-dominio.drawio)).
- **Conceptual/logical data model (Crow's Foot ERD)**: `11` entities with identifiers, cardinality, and total/partial participation, `2` resolved `N:M` relationships (`DETALLE_PEDIDO`, `DETALLE_COTIZACION`), weak entity `NOTIFICACION`, and recursive compatibility on `PRODUCTO`, in [05-erd-description.md](05-erd-description.md) and [../05-modelo-entidad-relacion.svg](../05-modelo-entidad-relacion.svg) ([`.drawio`](../05-modelo-entidad-relacion.drawio)).
- **Initial UI prototype**: `4` labeled wireframe screens per use case in [06-initial-prototype.md](06-initial-prototype.md).

---

## 3. Verification Results and Applied Adjustments

The `18`-criterion validation checklist (`5` coverage/traceability criteria) was applied in [07-validation-checklist.md](07-validation-checklist.md):

- **First pass (`2026-11-25`)**: `12 / 18` criteria passed and `6` findings (`H-01` to `H-06`) were logged: missing `RF-06`/`RF-12` screen/flow links in Annex C, adding `ReporteContador` explicitly to the domain diagram, synchronizing all alt/exception branches between activities and templates, removing validation from `CU-03` preconditions and technical terms from `CU-11`, adding the recursive `PRODUCTO` relationship to the ERD, and sanitizing all mockups/docs to eliminate real PII.
- **Second pass (Day 2 · `2026-11-26`)**: after fixing and documenting all findings in [08-adjustment-log.md](08-adjustment-log.md), the full package was re-verified with **`18 / 18` criteria passed (`100 %`)**, `12 / 12` FR traced in [09-traceability-matrix.md](09-traceability-matrix.md), and `0` PII or implementation-detail leaks.

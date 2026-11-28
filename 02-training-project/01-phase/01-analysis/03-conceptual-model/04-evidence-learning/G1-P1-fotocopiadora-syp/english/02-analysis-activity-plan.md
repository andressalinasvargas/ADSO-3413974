> **Spanish version (official rubric root):** [../02-plan-actividades-analisis.md](../02-plan-actividades-analisis.md)

# Analysis Activity Plan · Fotocopiadora SyP

Under the selected methodology (**Scrum** in [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md)), the analysis phase runs in **two short increments** (Window from **November 21 to 28, 2026**), prioritizing commercial/technical domain understanding first, then functional modeling, and finally end-to-end verification before delivery closure.

---

## Schedule and Prioritized Activity Plan

| ID | Priority (Scrum) | Analysis activity | Owner | Due date | Verifiable deliverable |
|---|---|---|---|---|---|
| `ACT-01` | High (Sprint 1) | Consolidate base SRS input separating `12` functional requirements and `8` non-functional requirements free of technical details. | `@andressalinasvargas` | `2026-11-25` | [00-base-srs-input.md](00-base-srs-input.md) |
| `ACT-02` | High (Sprint 1) | Characterize the solution across the 4 mandatory aspects, compare 4 methodologies, and justify selecting Scrum. | `@andressalinasvargas` | `2026-11-25` | [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md) |
| `ACT-03` | High (Sprint 1) | Model the UML use case diagram (system boundary, primary/secondary actors, `«include»`, `«extend»`, and generalization) and document justifications. | `@andressalinasvargas` | `2026-11-25` | [../03-diagrama-casos-uso.drawio](../03-diagrama-casos-uso.drawio), [`.png`](../03-diagrama-casos-uso.png), [03-use-case-relationships-justification.md](03-use-case-relationships-justification.md) |
| `ACT-04` | High (Sprint 1) | Build the bidirectional `FR → Use Case` matrix verifying coverage >= 90 % and reverse audit `UC → FR`. | `@andressalinasvargas` | `2026-11-25` | [04-fr-use-case-matrix.md](04-fr-use-case-matrix.md) |
| `ACT-05` | High (Sprint 2) | Produce `2` activity diagrams for critical use cases (`CU-03` and `CU-09`) and `3` mutually consistent extended templates. | `@andressalinasvargas` | `2026-11-25` | Activity diagrams and [03-extended-use-case-templates.md](../../G1-P2-fotocopiadora-syp/english/03-extended-use-case-templates.md) |
| `ACT-06` | Medium-High (Sprint 2) | Abstract the domain model (conceptual classes without methods or foreign keys) and design the Crow's Foot ERD with weak entity and resolved N:M relationships. | `@andressalinasvargas` | `2026-11-25` | [04-domain-model-description.md](../../G1-P2-fotocopiadora-syp/english/04-domain-model-description.md) and [05-erd-description.md](../../G1-P2-fotocopiadora-syp/english/05-erd-description.md) |
| `ACT-07` | Medium (Sprint 2) | Build initial prototype (4 screens labeled by UC) and run checklist verification (>= 15 criteria). | `@andressalinasvargas` | `2026-11-26` | [06-initial-prototype.md](../../G1-P2-fotocopiadora-syp/english/06-initial-prototype.md) and [07-validation-checklist.md](../../G1-P2-fotocopiadora-syp/english/07-validation-checklist.md) |
| `ACT-08` | High (Sprint 2 Closure) | Apply fixes for detected findings, perform second verification (Day 2), issue analysis report, and close traceability matrix. | `@andressalinasvargas` | `2026-11-27` | [08-adjustment-log.md](../../G1-P2-fotocopiadora-syp/english/08-adjustment-log.md), [09-traceability-matrix.md](../../G1-P2-fotocopiadora-syp/english/09-traceability-matrix.md) and [10-analysis-report.md](../../G1-P2-fotocopiadora-syp/english/10-analysis-report.md) |

---

## Definition of Done

1. Every activity produces a versioned artifact with valid relative links and zero real personal data.
2. Changes from Increment 1 and Increment 2 are recorded across **at least 2 distinct calendar days** before **Saturday, November 28, 2026 at 6:00 a.m.**.
3. No use case, template, or domain model mixes implementation technologies, database table names, or technical protocols.

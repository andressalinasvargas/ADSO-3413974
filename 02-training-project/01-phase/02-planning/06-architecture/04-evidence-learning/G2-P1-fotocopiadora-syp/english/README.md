> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery README · Guide 2: Solution Design (English Version)

## 1. Delivery Details

| Field | Value |
| :--- | :--- |
| Product | P1 (design artifacts) |
| Author's GitHub handle | `@andressalinasvargas` |
| Cohort | `3413974` |
| Chosen case (project name) | Web E-Commerce & Technical Service Platform **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Link to case analysis report / SRS (in fork) | [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) · [10-analysis-report.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/10-analysis-report.md) |
| GitHub account used for commits | `@andressalinasvargas` |

---

## 2. Input Origin and Team Work

| Question | Answer |
| :--- | :--- |
| Was the SRS / analysis report written by a team? How many people? | Yes, the year project (**Fotocopiadora SyP**) involved a team of `2` members (`@andressalinasvargas` and `@Kevin81A`), while the consolidated analysis in `G1-P1`/`G1-P2` and this entire design are individual work. |
| What part of the SRS is yours? | 100 % of the `12 RF` (`RF-01`–`RF-12`) and `8 RNF` (`RNF-01`–`RNF-08`) structured and verified in `G1-P1-fotocopiadora-syp` and `G1-P2-fotocopiadora-syp`. |
| Did you build the artifacts of this delivery on your own? | Yes, individual and differentiated design decisions (**Command** and **Abstract Factory** GoF patterns, **Hexagonal** architecture, `7` components, and `24` classes/interfaces). |
| Did another trainee share or use files from this delivery? | No. Zero design files of `G2-P1` were copied from `@Kevin81A` or any other trainee. |

---

## 3. What I Reused, Adjusted, and Built New

| Artifact | File in this folder | Origin (fork path or "new") | What I adjusted or added |
| :--- | :--- | :--- | :--- |
| **A1.** Interpretation sheet & platform | [01-interpretation-sheet-and-platform.md](01-interpretation-sheet-and-platform.md) | [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) | Included `12 RF`, `8 RNF`, `5` actors, and justified **Python 3.12 + FastAPI** and a **Relational DB** with `4` concrete business conditions. |
| **A2.** Class diagram | [02-class-diagram-and-patterns.md](02-class-diagram-and-patterns.md) · [`.drawio`](../02-diagrama-clases.drawio) · [`.svg`](../02-diagrama-clases.svg) | [G1-P2 domain drawio](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/04-modelo-dominio.drawio) | Evolved `12` conceptual classes into **`24` OO elements (`21` classes + `3` interfaces)** with visibility, types, parameters, inheritance, aggregations, compositions, and zero mixed layers. |
| **A3.** GoF design patterns | [02-class-diagram-and-patterns.md §3](02-class-diagram-and-patterns.md#3-applied-own-gof-design-patterns-a3--neither-is-singleton) | New | Applied **Command** (`IComandoOperacion`, `DespachadorComandos`, `3` commands) and **Abstract Factory** (`IFabricaEntregaComercial`, `2` factories), neither Singleton. |
| **A4.** Software architecture | [03-software-architecture.md](03-software-architecture.md) · [`.drawio`](../03-arquitectura-software.drawio) · [`.svg`](../03-arquitectura-software.svg) | New | Defined **Hexagonal Architecture (Ports & Adapters)** with strict non-skipping flow, decision table across all `8` NFRs, and `2` discarded alternatives. |
| **A5.** Component view | [04-component-view.md](04-component-view.md) · [`.drawio`](../04-vista-componentes.drawio) · [`.svg`](../04-vista-componentes.svg) | New | Designed **`7` components** with named provided/required interfaces, valid dependency directions, and class/requirement mapping. |
| **A6.** Deployment view | [05-deployment-view.md](05-deployment-view.md) · [`.drawio`](../05-vista-despliegue.drawio) · [`.svg`](../05-vista-despliegue.svg) | New | Modeled **`5` nodes** (`NavegadorClientePWA`, `EstacionAdministrador`, `BordeEstaticoRenderCDN`, `ServidorAPIFastAPIDocker`, `MotorRelacionalPostgreSQL`) over `HTTPS 443 TLS 1.3` and private `TCP 5432`. |
| **A7.** Analysis → design traceability matrix | [06-design-traceability-matrix.md](06-design-traceability-matrix.md) | [G1-P2 traceability](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/09-traceability-matrix.md) | Mapped `12/12 RF` (`100 %`) and `8/8 RNF` to classes, components, and tables, with reverse check `24/24` zero orphans. |

---

## 4. Minimum Requirements Self-Check

- [x] **A1** Interpretation sheet: `12` FR & `8` NFR with ID; **Python 3.12 + FastAPI / PostgreSQL-SQLite** justified with `4` concrete conditions.
- [x] **A2** Class diagram: `24` elements (`>= 8`), types, methods, multiplicities, compositions/aggregations, inheritance + `3` interfaces with polymorphic implementations.
- [x] **A3** `2` distinct GoF patterns in diagram (**Command** & **Abstract Factory**, neither Singleton).
- [x] **A4** **Hexagonal** architecture with diagram, `8` NFR → decision table, and `2` discarded alternatives.
- [x] **A5** Component view: `7` components (`>= 5`) with named provided and required interfaces.
- [x] **A6** Deployment view: `5` nodes (`>= 3`) with artifacts, `HTTPS 443`, and private `TCP 5432`.
- [x] **A7** `100 %` analysis → design traceability (`12/12` FR & `24/24` classes).
- [x] Editable source (`.drawio`) and exported image (`.svg`) for every diagram (`02`–`05`).

---

## 5. Commit History

| Day | Progress (commit message) |
| :--- | :--- |
| `2026-11-27` (Day 1) | `feat(g2-p1): agregar diseno OO con Comando y Fabrica Abstracta, arquitectura hexagonal, vistas y trazabilidad de fotocopiadora-syp` — Built `A1`–`A7` and `.drawio`/`.svg` diagrams. |
| `2026-11-27` (Day 1 · EN) | `docs(g2): agregar paquete completo de documentacion en ingles para G2-P1 y G2-P2` — English mirror of `G2-P1` and `G2-P2`. |
| `2026-11-28` (Day 2 · Closure) | `feat(g2-p1): refinar diagrama OO con multiplicidades completas, cerrar trazabilidad P1-P2 H-04 y actualizar cierre Dia 2` — Added typed params, end-to-end multiplicities, dashed realizations in `02-diagrama-clases.svg`, and closed `H-04` (`P1 ↔ P2` cross-audit). |

---

## 6. Use of Artificial Intelligence (Mandatory Declaration)

| Tool | What I used it for | What I verified or changed afterward |
| :--- | :--- | :--- |
| Antigravity (AI assistant) | Drafting Hexagonal architecture tables, `A7` matrix, `.drawio`/`.svg` XML generation, and English translation. | Manually verified coherence with my `12 RF`/`8 RNF` in `G1-P1`, confirmed own independent GoF patterns (**Command** + **Abstract Factory**) and zero mixed layers or PII. |

---

## 7. Links

- Case analysis report / SRS: [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) · [10-analysis-report.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/10-analysis-report.md)
- Product 1 Spanish root: [../README.md](../README.md)
- Product 2 sibling folder (English): [G2-P2 English](../../G2-P2-fotocopiadora-syp/english/README.md)

---

## 8. Authorship Declaration

I declare that the artifacts in this folder are of my own authorship, reused year-long/prior sources are declared in Section 3, no instructor templates or other trainees' work were claimed as my own, and I can explain every artifact during oral verification.

GitHub handle: `@andressalinasvargas` · Date: `2026-11-28`

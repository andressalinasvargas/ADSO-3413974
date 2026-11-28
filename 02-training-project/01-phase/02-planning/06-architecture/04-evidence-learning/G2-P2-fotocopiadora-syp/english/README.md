> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery README · Guide 2: Solution Design (Product 2 — English Version)

## 1. Delivery Details

| Field | Value |
| :--- | :--- |
| Product | P2 (data model and verification) |
| Author's GitHub handle | `@andressalinasvargas` |
| Cohort | `3413974` |
| Chosen case (project name) | Web E-Commerce & Technical Service Platform **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Link to case analysis report / SRS (in fork) | [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) · [10-analysis-report.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/10-analysis-report.md) |
| GitHub account used for commits | `@andressalinasvargas` |

---

## 2. Input Origin and Team Work

| Question | Answer |
| :--- | :--- |
| Was the SRS / analysis report written by a team? How many people? | Yes, the year project (**Fotocopiadora SyP**) involved `2` team members (`@andressalinasvargas` and `@Kevin81A`), while the consolidated analysis in `G1` and this entire data design are individual work. |
| What part of the SRS is yours? | 100 % of the `12 RF`, `8 RNF`, and `11`-entity base ERD documented in `G1-P2-fotocopiadora-syp`. |
| Did you build the artifacts of this delivery on your own? | Yes, individual and differentiated work (`12` own tables, normalization of `planilla_cotizacion_bruta` & `registro_servicio_tecnico_bruto`, SQL verified on SQLite 3). |
| Did another trainee share or use files from this delivery? | No. Zero data or SQL files were copied from the other team member. |

---

## 3. What I Reused, Adjusted, and Built New

| Artifact | File in this folder | Origin (fork path or "new") | What I adjusted or added |
| :--- | :--- | :--- | :--- |
| **B1.** Adjusted conceptual model | [01-conceptual-model.md](01-conceptual-model.md) · [`.drawio`](../01-modelo-conceptual.drawio) · [`.svg`](../01-modelo-conceptual.svg) | [G1-P2 ERD drawio](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/05-modelo-entidad-relacion.drawio) | Formalized `11` Crow's Foot entities with `4` relational DB justifications, `2` resolved `N:M`, recursive `PRODUCTO`, and weak entity `NOTIFICACION`. |
| **B2.** Relational logical model | [02-logical-model-and-transformation.md](02-logical-model-and-transformation.md) · [`.drawio`](../02-modelo-logico.drawio) · [`.svg`](../02-modelo-logico.svg) | New (transformed from `B1`) | Transformed into **`12` tables** with PK, FK, recursive bridge `compatibilidad_producto`, and `7`-rule summary. |
| **B3.** Normalization evidence `0NF → 3NF` | [03-normalization.md](03-normalization.md) | New | Normalized step by step `planilla_cotizacion_bruta` (composite key) and `registro_servicio_tecnico_bruto` (transitive) with written FDs and frozen-price rationale. |
| **B4.** Data dictionary | [04-data-dictionary.md](04-data-dictionary.md) | New | Documented singular `snake_case` naming standard and `100 %` of columns across all `12` tables with types, sizes, constraints, and domains. |
| **B5.** SQL script & execution evidence | [../05-script-creacion.sql](../05-script-creacion.sql) · [05-sql-execution-evidence.md](05-sql-execution-evidence.md) · [../05-log-ejecucion-sqlite.txt](../05-log-ejecucion-sqlite.txt) | New | Authored DDL (`12` tables, `12` PK, `12` FK with `ON DELETE`, `33` `CHECK`, zero-PII synthetic rows) and ran it on **SQLite 3** (`4/4` negative tests rejected with `IntegrityError`). |
| **B6.** Security policies & roles | [06-data-security-policies.md](06-data-security-policies.md) | New | Defined `9` policies (salted `BCrypt`, `TLS 1.3`, Law 1581 `is_owner`, safe CSV, daily encrypted backup & monthly drill) and `4` roles × `12` tables matrix. |
| **B7.** Checklist & findings | [07-verification-checklist.md](07-verification-checklist.md) | New | Evaluated `24` measurable criteria across `G2-P1` and `G2-P2` with `4` findings (`H-01`–`H-03` closed today; `H-04` scheduled for Day 2). |

---

## 4. Minimum Requirements Self-Check

- [x] **B1** Conceptual model: `11` entities (`>= 6`), min/max cardinalities, `2` N:M, recursive & `1:N`, relational DB justification.
- [x] **B2** Logical model: `12` tables (`>= 8`) with PK/FK and `7`-rule transformation table.
- [x] **B3** Normalization: `2` own tables `0NF → 3NF` with written FDs (one composite key + one transitive dependency).
- [x] **B4** Complete data dictionary (`12/12` tables matching SQL 1:1).
- [x] **B5** SQL script executed cleanly ([../05-log-ejecucion-sqlite.txt](../05-log-ejecucion-sqlite.txt)), `ON DELETE` on all `12` FKs & `33` `CHECK`s.
- [x] **B6** `9` security policies (salted `BCrypt`, `TLS 1.3`, Law 1581, backup/restore) and `4` roles × `12` tables matrix.
- [x] **B7** `24`-criterion checklist (`>= 20`) filled across `G2-P1` & `G2-P2`, `4` findings (`3` closed, `H-04` scheduled for Day 2).

---

## 5. Commit History

| Day | Progress (commit message) |
| :--- | :--- |
| `2026-11-27` (Day 1) | `feat(g2-p2): agregar modelo conceptual, logico 12 tablas, normalizacion 3FN, DDL verificado en SQLite y seguridad de fotocopiadora-syp` — Built `B1`–`B7` and real SQLite 3 verification (`ExitCode = 0`). |
| `2026-11-27` (Day 1 · EN) | `docs(g2): agregar paquete completo de documentacion en ingles para G2-P1 y G2-P2` — English mirror of `G2-P1` and `G2-P2`. |
| *`2026-11-28` (Day 2 scheduled before `06:00 a.m.`)* | Closure of `H-04` cross-audit (`P1 ↔ P2` vs `POL-*`), reaching `24/24` criteria and completing `2` distinct push calendar days. |

---

## 6. Use of Artificial Intelligence (Mandatory Declaration)

| Tool | What I used it for | What I verified or changed afterward |
| :--- | :--- | :--- |
| Antigravity (AI assistant) | Drafting 3NF normalization tables, data dictionary, ANSI/SQLite DDL syntax, `.drawio`/`.svg` XML diagrams, and English translation. | Personally ran `05-script-creacion.sql` on SQLite 3 with `PRAGMA foreign_keys = ON` (`4/4` `IntegrityError` negative checks), verified 1:1 column parity across `B2`/`B4`/`B5`, and confirmed zero real PII. |

---

## 7. Links

- Case analysis report / SRS: [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) · [10-analysis-report.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/10-analysis-report.md)
- Product 2 Spanish root: [../README.md](../README.md)
- Product 1 sibling folder (English): [G2-P1 English](../../G2-P1-fotocopiadora-syp/english/README.md)

---

## 8. Authorship Declaration

I declare that the artifacts in this folder are of my own authorship, reused sources are declared in Section 3, no instructor material or other trainees' work was claimed as my own, and I can explain every artifact during oral verification.

GitHub handle: `@andressalinasvargas` · Date: `2026-11-27`

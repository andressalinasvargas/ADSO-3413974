> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery README · Guide 3: Technical Proposal (Product 1 — English Version)

## 1. Delivery Details

| Field | Value |
| :--- | :--- |
| Product | P1 (Standardized technical sheet, regulatory reference, and license sizing) |
| Author's GitHub handle | `@andressalinasvargas` |
| Cohort | `3413974` |
| Chosen case (project name) | Web E-Commerce & Technical Service Platform **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Link to analysis / architecture report (in fork) | [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md) · [03-software-architecture.md](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/english/03-software-architecture.md) |
| GitHub account used for commits | `@andressalinasvargas` |

---

## 2. Input Origin and Team Work

| Question | Answer |
| :--- | :--- |
| Was the SRS / analysis report written by a team? How many people? | Yes, **Fotocopiadora SyP** was a `2`-person project (`@andressalinasvargas` and `@Kevin81A`), while all technical & proposal artifacts in `ADSO-3413974` (`G2` and `G3`) are independently authored. |
| What part of the SRS is yours? | The `12 RF`, `8 RNF`, Hexagonal OO design (**Command** + **Abstract Factory**), and `12`-table SQL schema documented in `G1-*-fotocopiadora-syp` and `G2-*-fotocopiadora-syp`. |
| Did you build the artifacts of this delivery on your own? | Yes. Sheet template (`A1`), Colombian regulatory framework (`A3`), and real dependency inventory (`A4`) under **Provisional Scenario B** were built independently. |
| Did another trainee share or use files from this delivery? | No. Full architectural and budgetary differentiation is preserved (Hexagonal architecture, `12` tables, Scenario B `120` users / `2` sites). |

---

## 3. What I Reused, Adjusted, and Built New (Day 1 — In Progress Toward Day 2)

| Artifact | File in this folder | Origin (fork path or "new") | Progress / current status |
| :--- | :--- | :--- | :--- |
| **A1.** Standardized technical sheet format | [01-technical-sheet-format.md](01-technical-sheet-format.md) | New (traced to `G1-P1`, `G2-P1`, `G2-P2`) | `15`-field vendor-neutral template aligned to `ISO/IEC/IEEE 29148:2018` & `ISO/IEC 25010:2023`, mapped to `FT-SYP-001`–`004`. (**Day 1 Complete**) |
| **A2.** Completed operational technical sheets | *Scheduled Day 2* (`02-fichas-tecnicas-aplicacion.md`) | Pending | Completed `FT-SYP-001`..`004` + infrastructure sheets. (**Pending Day 2**) |
| **A3.** Technical & regulatory framework | [03-technical-regulatory-reference.md](03-technical-regulatory-reference.md) | New | `6` verified external references as of `2026-11-27` (`Law 1581/2012 + Dec. 1074/2015` transmission vs. transfer, `Law 23/1982`, `Decision 351/1993`, `WCAG 2.2 AA / ISO 25010`, `Law 527/1999`, `Law 1480/2011`), separated from `POL-INT/CON/DIS`. (**Day 1 Complete**) |
| **A4.** Parameterized sizing & real license inventory | [04-license-sizing.md](04-license-sizing.md) | New + `Fotocopiadora-SyP-main` real manifests | `A`–`D` scenario matrix (**Provisional Scenario B**), `8` components mapped 1:1 to `[N1]`–`[N7]`, and verified `8` prod + `3` QA Python deps + `package.json` without copyleft. (**Day 1 Complete**) |
| **A5.** Comparative tech evaluation | *Scheduled Day 2* | Pending | Multi-criteria provider/runtime matrix and justified selection. (**Pending Day 2**) |
| **A6.** Licensing & infra cost consolidation | *Scheduled Day 2* | Pending | Unit costs & formulas feeding `G3-P2` budget. (**Pending Day 2**) |

---

## 4. Minimum Requirements Self-Check (Day 1 Progress)

- [x] **A1** Standardized technical sheet format (`15` fields, `ISO/IEC/IEEE 29148:2018` / `ISO/IEC 25010:2023`, brand-neutral).
- [ ] **A2** Completed module & infrastructure technical sheets *(scheduled Day 2 commit before `2026-12-05`)*.
- [x] **A3** Current technical & legal reference (`6` verified refs `2026-11-27`, separated from `POL-INT/CON/DIS`).
- [x] **A4** Parameterized sizing (`A`–`D`, **Provisional Scenario B**) + real dependency inventory & zero-copyleft IP strategy.
- [ ] **A5** Multi-criteria technology comparison *(scheduled Day 2)*.
- [ ] **A6** Preliminary licensing/infrastructure cost sheet *(scheduled Day 2)*.

---

## 5. Commit History

| Day | Progress (commit message) |
| :--- | :--- |
| `2026-11-27` (Day 1) | `feat(g3-p1): crear formato A1, referente normativo A3 y README inicial de fotocopiadora-syp` — Initial `A1`, `A3`, and `README.md`. |
| `2026-11-27` (Day 1) | `feat(g3-p1): agregar dimensionamiento de licencias e inventario real FastAPI A4 de fotocopiadora-syp` — `A`–`D` sizing & real manifest inventory. |
| `2026-11-27` (Day 1) | `fix(g3): alinear nomenclatura de nodos N1-N7, politicas POL y trazabilidad RF/RNF con G2 y diagramas SVG` — Aligned `POL-*`, `[N1]`–`[N7]`, and `RF`/`RNF`. |
| `2026-11-27` (Day 1 · EN) | `docs(g3): agregar documentacion en ingles Dia 1 para G3-P1 y G3-P2` — Day-1 English documentation mirror. |
| *Day 2 (scheduled before `2026-12-05 06:00 a.m.`)* | Addition of `A2`, `A5`, and `A6` with final multi-criteria comparisons and spreadsheet formulas. |

---

## 6. Use of Artificial Intelligence (Mandatory Declaration)

| Tool | What I used it for | What I verified or changed afterward |
| :--- | :--- | :--- |
| Antigravity (AI assistant) | Structuring `A1`, summarizing Colombian regulatory statutes in `A3`, tabulating scenarios `A`–`D` in `A4`, and English translation. | Personally checked every pinned package version inside `fastapi_backend/requirements.txt`, `requirements-dev.txt`, and `package.json`, verifying OSI licenses and 1:1 alignment with `G2-P1`/`G2-P2`. |

---

## 7. Links

- SRS input (`G1-P1`): [00-base-srs-input.md](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/00-base-srs-input.md)
- Design & DB (`G2-P1` / `G2-P2`): [G2-P1 English](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/english/README.md) · [G2-P2 English](../../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/english/README.md)
- Product 2 sibling folder (English): [G3-P2 English](../../G3-P2-fotocopiadora-syp/english/README.md)
- Product 1 Spanish root: [../README.md](../README.md)

---

## 8. Authorship Declaration

I declare that the artifacts in this folder are of my own authorship, reused prior work on **Fotocopiadora SyP** is declared in Sections 2–3, no other trainees' proposals were copied, and I can defend every technical decision orally.

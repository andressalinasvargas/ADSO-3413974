> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery README · Guide 3: Technical & Economic Proposal (Product 2 — English Version)

## 1. Delivery Details

| Field | Value |
| :--- | :--- |
| Product | P2 (Technical proposal, deployment architecture, budget & contractual framework) |
| Author's GitHub handle | `@andressalinasvargas` |
| Cohort | `3413974` |
| Chosen case (project name) | Web E-Commerce & Technical Service Platform **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Link to proposal / base architecture (in fork) | [05-deployment-view.md](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/english/05-deployment-view.md) · [G3-P1 English](../../G3-P1-fotocopiadora-syp/english/README.md) |
| GitHub account used for commits | `@andressalinasvargas` |

---

## 2. Input Origin and Team Work

| Question | Answer |
| :--- | :--- |
| Was the SRS / analysis report written by a team? How many people? | Yes, **Fotocopiadora SyP** was a `2`-person project (`@andressalinasvargas` and `@Kevin81A`), maintaining completely independent `G2` and `G3` deliverables in architecture, data model, budget, and ToR. |
| What part of the SRS is yours? | Consolidated `G1-P1`/`G1-P2`, Hexagonal OO design `G2-P1`, `12` SQL-verified tables in `G2-P2`, and this `G3` structure. |
| Did you build the artifacts of this delivery on your own? | Yes. The `7`-node deployment diagram (`B3`) and contract/ToR/SLA framework (`B6`) under **Provisional Scenario B** were built individually. |
| Did another trainee share or use files from this delivery? | No. Zero files, figures, or diagrams were taken from another trainee. |

---

## 3. What I Reused, Adjusted, and Built New (Day 1 — In Progress Toward Days 2 & 3)

| Artifact | File in this folder | Origin (fork path or "new") | Progress / current status |
| :--- | :--- | :--- | :--- |
| **B1.** Requirements analysis & economic scope | *Scheduled Day 2* | Pending | CAPEX/OPEX scope consolidation under Scenario B. (**Pending Day 2**) |
| **B2.** Vendor quotes & pricing sources | *Scheduled Day 2* | Pending | Comparative quotes for cloud, domain, monitoring, and dev labor. (**Pending Day 2**) |
| **B3.** Deployment architecture diagram (`7` nodes `[N1]`–`[N7]`) | [../03-diagrama-arquitectura-despliegue-g3.drawio](../03-diagrama-arquitectura-despliegue-g3.drawio) · [`.svg`](../03-diagrama-arquitectura-despliegue-g3.svg) | Evolved from [G2-P1 deployment SVG](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/05-vista-despliegue.svg) | Expanded from `5` to **`7` nodes** (`[N1]` Client Browser PWA excluded, `[N2]` Admin Workstation excluded, `[N3]` Edge DNS + Proxy TLS 1.3, `[N4]` Docker API Server, `[N5]` Private Database Server PostgreSQL 16, `[N6]` Encrypted External S3 Backups `AES-256`, `[N7]` External Monitoring & SLA Alerts every `60 s`) traced to budget & SLAs. (**Diagram complete Day 1**; cost table Day 2) |
| **B4.** Consolidated budget (cap `$70,000,000 COP`) | *Scheduled Day 2* | Pending | Detailed budget under **Provisional Scenario B**. (**Pending Day 2**) |
| **B5.** Technical & economic validation minutes | *Scheduled Day 3* | Pending | Final cross-validation between `G3-P1` and `G3-P2`. (**Pending Day 3**) |
| **B6.** Contractual framework, ToR & SLA | [06-contract-tor-sla.md](06-contract-tor-sla.md) | New | **`14`** essential contract elements, **`8`** specific ToRs (`TdR-01`–`TdR-08`), and **`4`** measurable SLAs (`ANS-01` `99.5 %`, `ANS-02` `p95 <= 1.5 s`, `ANS-03` `RPO <= 24 h`, `ANS-04` `P1 <= 30 min` / `RTO <= 2 h`). (**Day 1 Complete**) |
| **B7.** Master technical & economic proposal doc | *Scheduled Day 3* | Pending | Final consolidated proposal `v1.0` after `B5` validation. (**Pending Day 3**) |

---

## 4. Minimum Requirements Self-Check (Day 1 Progress)

- [ ] **B1** Economic scope & financial assumptions *(scheduled Day 2)*.
- [ ] **B2** Real vendor quotes & comparison table *(scheduled Day 2)*.
- [x] **B3** Deployment diagram (`7` nodes `[N1]`–`[N7]` in valid `.drawio` and `.svg`) traced to licenses (`A4`) and SLAs (`B6`). *(Cost mapping table added Day 2).*
- [ ] **B4** Consolidated budget within `$70,000,000 COP` cap *(scheduled Day 2)*.
- [ ] **B5** Integral validation minutes *(scheduled Day 3)*.
- [x] **B6** Contract (`14` elements), Terms of Reference (`TdR-01`–`TdR-08`), and measurable `ANS-01`–`ANS-04` with `P1`–`P3` severity table.
- [ ] **B7** Consolidated technical-economic proposal *(scheduled Day 3 before `2026-12-05`)*.

---

## 5. Commit History

| Day | Progress (commit message) |
| :--- | :--- |
| `2026-11-27` (Day 1) | `feat(g3-p2): crear diagrama de despliegue 7 nodos B3, marco contrato-TdR-ANS B6 y README inicial de fotocopiadora-syp` — Built `B3` diagram (`[N1]`–`[N7]`) and `B6`. |
| `2026-11-27` (Day 1) | `fix(g3): alinear nomenclatura de nodos N1-N7, politicas POL y trazabilidad RF/RNF con G2 y diagramas SVG` — Aligned `[N1]`–`[N7]`, `TdR-01`–`TdR-08`, and `POL-*`. |
| `2026-11-27` (Day 1 · EN) | `docs(g3): agregar documentacion en ingles Dia 1 para G3-P1 y G3-P2` — Day-1 English mirror. |
| *Day 2 (scheduled)* | Add `B1`, `B2`, detailed `B3` doc, and `B4` budget under Scenario B. |
| *Day 3 (scheduled before `2026-12-05 06:00 a.m.`)* | Closure with `B5` validation minutes and `B7` consolidated proposal across multiple calendar days. |

---

## 6. Use of Artificial Intelligence (Mandatory Declaration)

| Tool | What I used it for | What I verified or changed afterward |
| :--- | :--- | :--- |
| Antigravity (AI assistant) | Generating `.drawio`/`.svg` XML of the `7`-node `[N1]`–`[N7]` diagram, structuring contractual/ToR/SLA tables, and English translation. | Validated well-formed `.drawio`/`.svg` XML, confirmed 1:1 correspondence between the `7` nodes and `A4` components, and ensured every SLA metric has measurable thresholds and owner nodes. |

---

## 7. Links

- Technical sheet, rules & licenses (`G3-P1`): [G3-P1 English](../../G3-P1-fotocopiadora-syp/english/README.md)
- Prior deployment view (`G2-P1`): [05-deployment-view.md](../../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/english/05-deployment-view.md)
- G3 Deployment diagram (`B3`): [../03-diagrama-arquitectura-despliegue-g3.svg](../03-diagrama-arquitectura-despliegue-g3.svg)
- Product 2 Spanish root: [../README.md](../README.md)

---

## 8. Authorship Declaration

I declare that the artifacts in this folder are of my own authorship, traceability with `G1` and `G2` of **Fotocopiadora SyP** is declared in Sections 2–3, no third-party proposals were copied, and I can substantiate every technical decision and SLA orally.

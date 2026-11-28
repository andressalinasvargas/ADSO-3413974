> **Spanish version (official rubric root):** [../README.md](../README.md)

# Delivery · Guide 1 · Conceptual Model (Product 1 — English Version)

Delivery path in fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/english/`

Guide deadline: **Saturday, November 28, 2026 at 6:00 a.m.**

---

## 1. Delivery Details

- **Product:** P1 analysis plan and use cases
- **Author's GitHub handle:** `@andressalinasvargas`
- **Case study:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**
- **Year-long team work:** Yes — collaborative year project built with **Equipo Fotocopiadora SyP** (requirements consolidation, methodological refinement, and analysis modeling in this submission are individual work by `@andressalinasvargas`).

## 2. What I Reused

| Artifact | Origin path or reference (prior year work) | Solo or team? |
|---|---|---|
| Initial requirements specification (`RF`/`RNF`) | Consolidated SRS v2.0 of the year project (**Equipo Fotocopiadora SyP**, collaborative repository `Fotocopiadora-SyP`, base requirements doc) | Team (**Equipo Fotocopiadora SyP**) |
| Functional scope of catalog, cart, checkout, technical service, renting, and admin panel | Functional modules implemented during the year on the **Fotocopiadora SyP** web platform (updated with pagination, accessibility, offline cache, and document privacy) | Team (**Equipo Fotocopiadora SyP**) |
| Methodological reference and fork use-case structure | Prior individual analysis exercises recorded under `03-execute/` (weeks 16–19 of this fork) applied now to **Fotocopiadora SyP** | Solo (`@andressalinasvargas`) |

## 3. What I Adjusted

| # | Artifact | What I changed and why | Commit link |
|---|---|---|---|
| 1 | [00-base-srs-input.md](00-base-srs-input.md) and [04-fr-use-case-matrix.md](04-fr-use-case-matrix.md) | Incorporated updated project requirements (12-item pagination, comparator, double-submit guard, quote/order privacy, safe export, and notifications) and explicitly separated `12 RF` from `8 RNF`, explaining why NFRs are not use cases (`C3` of `Rubricas_G1.md`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 2 | [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md) and [02-analysis-activity-plan.md](02-analysis-activity-plan.md) | Built from the reality of a small (`2`-member) team the 4-aspect characterization, 4-methodology matrix with 5 derived criteria, and an 8-activity prioritized Scrum plan with owner, date, and deliverable (`C1` and `C2` of `Rubricas_G1.md`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 3 | [../03-diagrama-casos-uso.drawio](../03-diagrama-casos-uso.drawio) and [03-use-case-relationships-justification.md](03-use-case-relationships-justification.md) | Organized goals into `12` verb + object use cases grouping trivial CRUD in `CU-11`, drew system boundary with 3 primary actors (`Cliente Registrado --|> Visitante`) and 2 external secondary actors, and corrected direction/justification of 3 `«include»` and 2 `«extend»` arrows with extension points (`C4`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 4 | [04-fr-use-case-matrix.md](04-fr-use-case-matrix.md) | Added reverse audit `Use Case → FR` (`12/12`, 0 orphan cases) to ensure clean traceability to design (`C3`) and Day 2 cross-verification closure (`2026-11-26`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |

## 4. What I Built New

- **Formal 4-aspect characterization and 4-methodology comparison matrix** (Scrum, RUP, XP, RAD) with 5 criteria in [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md).
- **Analysis activity plan across 2 Scrum sprints** with 8 traceable deliverables in [02-analysis-activity-plan.md](02-analysis-activity-plan.md).
- **Unified UML use case diagram with 12 cases** (`.drawio`, `.svg`, `.png`) and explicit justification in [03-use-case-relationships-justification.md](03-use-case-relationships-justification.md).
- **100 % bidirectional `FR ↔ Use Case` matrix** in [04-fr-use-case-matrix.md](04-fr-use-case-matrix.md).

## 5. Delivered Artifacts

**Product 1**

- [x] Consolidated SRS input (`12 RF` and `8 RNF`): [00-base-srs-input.md](00-base-srs-input.md)
- [x] Solution characterization: [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md#1-solution-characterization-4-mandatory-aspects)
- [x] Methodology comparison and justified selection: [01-characterization-and-methodologies.md](01-characterization-and-methodologies.md#2-comparison-of-development-methodologies)
- [x] Activity plan, schedule, and deliverables: [02-analysis-activity-plan.md](02-analysis-activity-plan.md)
- [x] Use case diagram (editable source): [../03-diagrama-casos-uso.drawio](../03-diagrama-casos-uso.drawio)
- [x] Use case diagram (images and justification): [../03-diagrama-casos-uso.png](../03-diagrama-casos-uso.png) · [../03-diagrama-casos-uso.svg](../03-diagrama-casos-uso.svg) · [03-use-case-relationships-justification.md](03-use-case-relationships-justification.md)
- [x] Requirement → use case matrix: [04-fr-use-case-matrix.md](04-fr-use-case-matrix.md)

## 6. Authorship Declaration

- [x] I declare that the adjustments and new work in this folder are **my individual work**.
- [x] I declare that material reused from my team or prior work is identified in Section 2.
- [x] I understand that on Saturday, November 28, 2026 the instructor will ask me **3 oral questions** about my products and that failing 2 or more caps the affected product at 50.

Signature (GitHub handle and date): `@andressalinasvargas` · `2026-11-26`

## 7. Use of Artificial Intelligence

| Tool | What I used it for | What I verified or corrected myself |
|---|---|---|
| Antigravity (AI assistant) | Support in consolidating `RF`/`RNF` requirements from Fotocopiadora SyP, structuring comparison tables, generating `.drawio`/`.svg`/`.png` sources, and translating documentation to English. | Manually verified that every `FR` reflects real current project behavior, removed personal data and implementation details from analysis, and checked `«include»`/`«extend»` arrow directions against `Rubricas_G1.md` §7. |

## 8. Pre-Push Self-Check

- [x] Committed my own changes across at least 2 distinct days (`2026-11-25` and `2026-11-26` for the Spanish rubric root).
- [x] Excluded instructor framework docs, blank templates, and third-party personal data.
- [x] Verified GitHub publication.

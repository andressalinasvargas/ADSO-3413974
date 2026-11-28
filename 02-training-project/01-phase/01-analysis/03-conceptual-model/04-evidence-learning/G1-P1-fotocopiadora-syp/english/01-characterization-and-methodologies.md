> **Spanish version (official rubric root):** [../01-caracterizacion-y-metodologias.md](../01-caracterizacion-y-metodologias.md)

# Solution Characterization and Methodology Selection · Fotocopiadora SyP

## 1. Solution Characterization (4 Mandatory Aspects)

Based on the review of [00-base-srs-input.md](00-base-srs-input.md) and the current structure of the **Fotocopiadora SyP** platform, the four fundamental aspects of the project are characterized:

| Aspect | Value in the project | Implication for analysis and development |
|---|---|---|
| **1. Project type** | Hybrid B2C/B2B e-commerce web platform, printable formal quoting, technical self-diagnosis, and commercial administration panel. | Combines real-time cart/order rules with administrative workflows, document validation, and resilient static fallback. |
| **2. Team size** | Small team (2 base members: Equipo Fotocopiadora SyP), with individual analysis refinement in this submission (`@andressalinasvargas`). | Requires a lightweight methodology with frequent incremental deliveries, minimal documentary bureaucracy, and continuous short-iteration control. |
| **3. Requirements stability** | **Medium-high** stability in the transactional core (catalog, cart, orders) and **evolutionary** across technical tools, accessibility, offline caching, and data visualization. | Benefits from short cycles where UX, security, and accessibility improvements can be validated and integrated without rewriting the entire specification. |
| **4. Client availability** | High availability through a direct channel with the business owner/management and continuous validation of interface, catalog, and service workflows. | Enables early prototype demonstrations, direct catalog/quote reviews, and rapid feedback between iterations. |

---

## 2. Comparison of Development Methodologies

To objectively compare four recognized methodologies (**Scrum**, **RUP**, **XP**, and **RAD**), **5 criteria** derived directly from the four previous characteristics are used:

| Criterion (derived from characterization) | Scrum | RUP | XP (Extreme Programming) | RAD |
|---|---|---|---|---|
| **1. Fit for small team (2 people)** | **High**: lightweight roles and weekly cycles without bureaucratic overhead. | **Low**: demands excessive formal artifacts and roles for 2 people. | **Medium-High**: tailored to small teams, though requiring strict on-site pair programming. | **Medium**: focuses on rapid prototyping, less structured backlog management. |
| **2. Handling evolutionary requirements** | **High**: prioritized Product Backlog absorbing improvements per sprint (e.g., SC diagnosis, renting, accessibility). | **Medium**: supports phase-level changes, but requires replanning heavy artifacts. | **High**: adapts changes inside short iterations via continuous testing. | **Medium-High**: accommodates visual prototype tweaks, though it may overlook business rules. |
| **3. Leveraging high client availability** | **High**: formal sprint review at the end of each sprint with direct validation of functional increments. | **Medium**: concentrates validation into spaced phase milestones. | **High**: proposes permanent on-site customer (hard to sustain 100 % with active commerce). | **High**: involves the user from early interface prototypes. |
| **4. Support for hybrid web delivery (store + workshop + admin)** | **High**: allows splitting into prioritized functional modules (catalog, checkout, support, admin) delivering value from sprint 1. | **High**: strong architectural discipline across layers and formal use cases. | **Medium**: prioritizes code over visual multi-actor process modeling. | **Medium**: strong in fast screens, weak in inventory, pricing, and security consistency. |
| **5. Traceability and verification before closing delivery** | **High**: Definition of Done compatible with validation checklists and E2E testing. | **High**: formal phase reviews with exhaustive matrices. | **Medium-High**: relies on continuous automated tests, less geared toward documentary audits. | **Low-Medium**: often trades documentary verification for prototyping speed. |

---

## 3. Justified Methodology Selection

### Selected methodology: **Scrum** (complemented in analysis by UML traceability modeling)

**Justification aligned with the 4 characterization aspects:**

1. **Coherence with a small team and short delivery window**: Scrum organizes work into short iterations with a prioritized requirements backlog (`RF-01` to `RF-12`), avoiding RUP's ceremonial overhead while preserving discipline compared to RAD's informality.
2. **Direct response to evolutionary improvements**: store, quoting, technical tooling, and security/accessibility features (`RNF-03`, `RNF-05`) evolve in verifiable increments without breaking catalog or checkout stability.
3. **Capitalizing on business availability**: agile communication with Fotocopiadora SyP management enables sprint-end reviews of real critical flows (checkout, formal quote, and technical service history) before moving forward.
4. **Verifiable Definition of Done**: Scrum's Definition of Done naturally links requirements analysis to consistency checklists, regression testing, and cross-verification prior to delivery sign-off.

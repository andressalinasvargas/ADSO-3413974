> **Spanish version (official rubric root):** [../08-registro-ajustes.md](../08-registro-ajustes.md)

# Adjustment Log and Second Verification · Fotocopiadora SyP

Document prepared per **Annex D** of `Plantilla_README_Entrega_G1.md`, recording the **6 findings (`H-01` to `H-06`)** detected during the first review of [07-validation-checklist.md](07-validation-checklist.md), exact corrections made, and second approved verification.

---

## Matrix of Executed Adjustments (`6` Resolved Findings)

| # | Finding (failed criterion) | Artifact | Before | After | Commit link | Re-verified? |
|---|---|---|---|---|---|---|
| `H-01` | Criterion `#3`: `RF-06` and `RF-12` showed partial gaps linking to prototype screens or reference activity flows in Annex C matrix. | [09-traceability-matrix.md](09-traceability-matrix.md) | `RF-06` and `RF-12` lacked explicit reference to associated screen/process flow. | Explicitly traced `RF-06` (reached from `CU-04` via `CU-01/CU-02` and `CU-03` screens) and `RF-12` (alerts integrated in `CU-11` panel), reaching `12/12` (`100 %`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |
| `H-02` | Criterion `#4`: Concept `ReporteContador` cited in `CU-11` administrative operations did not appear explicitly in the domain diagram. | [04-domain-model-description.md](04-domain-model-description.md) and [../04-modelo-dominio.drawio](../04-modelo-dominio.drawio) | `11` conceptual classes without an independent class for monthly renting readings. | Added conceptual class `ReporteContador` with 5 business attributes and `Cliente (1) -- (0..*) ReporteContador` + operational link with `Administrador`. | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |
| `H-03` | Criterion `#5`: Missing exact branch alignment between activity diagrams and templates (`CU-03` gateway rejection; `CU-09` incomplete fields). | [../01-actividad-cu03-confirmar-pedido.drawio](../01-actividad-cu03-confirmar-pedido.drawio), [../02-actividad-cu09-servicio-tecnico.drawio](../02-actividad-cu09-servicio-tecnico.drawio) and [03-extended-use-case-templates.md](03-extended-use-case-templates.md) | Gateway decision lacked `[Pago rechazado / expirado]` exception branch and `CU-09` lacked `[Datos incompletos]` guard. | Added all `[...]` guards on every decision node aligned 1:1 with alt flows `4a/4b`, `2a/3a` and exceptions `1b/3b/6b` and `3b/4b`. | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |
| `H-04` | Criterion `#9`: `CU-03` precondition included stock validation and `CU-11` mentioned a technical export format term. | [03-extended-use-case-templates.md](03-extended-use-case-templates.md) | `CU-03` precondition read `"stock verificado"` and `CU-11` cited a technical file format name. | Moved stock check to step `3` and exception `3b` (§7.3) and rewrote `CU-11` as `"spreadsheet-ready tabular file"` with zero implementation details. | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |
| `H-05` | Criterion `#11`: ERD lacked the recursive compatibility relationship on `PRODUCTO` and did not state total/partial participation symbols per end. | [05-erd-description.md](05-erd-description.md) and [../05-modelo-entidad-relacion.drawio](../05-modelo-entidad-relacion.drawio) | Compatibilities modeled only as free text without recursive ERD relationship. | Added recursive relationship `PRODUCTO (0..*) -- (0..*) PRODUCTO [compatibilidad]` and explicit Crow's Foot symbol legend (`||`, `o|`, `|<`, `o<`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |
| `H-06` | Criterion `#15`: Potential exposure of real contact details or proper names inherited from base drafts in mockups/examples. | [06-initial-prototype.md](06-initial-prototype.md), `pantalla-*.png`, P1 and P2 | Drafts risked showing real company names, phones, or emails on the public fork. | Replaced all examples with 100 % synthetic data (`Empresa Demo S.A.S.`, `cliente.ejemplo@correo.invalid`, `+57 300 000 0000`) and verified 0 PII matches via automated scan. | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) | Yes — Compliant (`2026-11-25`) |

---

## Second Verification Result (Day 2 · `2026-11-26`)

After applying all `6` adjustments above, the second full verification pass was executed on Day 2 (`2026-11-26`) across all artifacts in `G1-P1-fotocopiadora-syp/` and `G1-P2-fotocopiadora-syp/`, confirming **18 / 18 criteria approved (`100 %`)**, `0` broken links, and full traceability consistency.

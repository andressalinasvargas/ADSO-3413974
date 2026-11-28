> **Spanish version (official rubric root):** [../07-lista-chequeo-verificacion.md](../07-lista-chequeo-verificacion.md)

# B7 · Verification Checklist & Findings Log (`G2-P1` + `G2-P2`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593102`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Evaluated scope:** Design artifacts in [G2-P1 English](../../G2-P1-fotocopiadora-syp/english/README.md) (`A1`–`A7`) and data/security artifacts in `G2-P2` (`B1`–`B6`).

---

## 1. Verification Checklist (`24` Measurable Criteria — Day 2 Closure `2026-11-28`: `24 / 24` Passed `100 %`)

| ID | Artifact | Measurable acceptance criterion | Severity | Result | Verifiable evidence in repository |
| :- | :--- | :--- | :---: | :---: | :--- |
| **LC-01** | `A1` Sheet | Lists `>= 8 FR` & `>= 3 NFR` with own SRS IDs, actors, and constraints | Major | **Yes** | `G2-P1/01-...` lists `12 RF`, `8 RNF`, and `5` actors from `G1-P1`. |
| **LC-02** | `A1` Platform | Justifies OO language & DB type with `>= 3` concrete case conditions | Major | **Yes** | `G2-P1/01-...` §2 gives `4` concrete conditions for Python/FastAPI and relational DB. |
| **LC-03** | `A2` Classes | Defines `>= 8` classes with visibility, typed attributes, methods & parameters | Critical | **Yes** | `G2-P1/02-...` and `.svg` model `24` elements (`21` classes + `3` interfaces). |
| **LC-04** | `A2` Relations | Includes multiplicities on 100 % of associations, inheritance, aggregation & composition | Major | **Yes** | Inheritance (`Persona`), `2` aggregations (`Categoria`, `CarritoCompra`), `3` compositions (`Pedido`, `Cotizacion`, `Notificacion`). |
| **LC-05** | `A2` Cohesion | No class mixes UI, business logic, persistence, or CSV export | Critical | **Yes** | `IRepositorioComercial` and `ExportadorCsvSeguro` isolated from domain entities. |
| **LC-06** | `A3` GoF Patterns | Applies `>= 2` distinct GoF patterns shown in diagram (at least 1 != Singleton) | Critical | **Yes** | **Command** (`IComandoOperacion`) & **Abstract Factory** (`IFabricaEntregaComercial`), neither Singleton. |
| **LC-07** | `A4` Architecture | Defined style with diagram, non-skipping layer flow, and discarded alternative | Major | **Yes** | `G2-P1/03-...`: Hexagonal with inbound/outbound ports and `2` discarded alternatives. |
| **LC-08** | `A4` NFR Table | Covers `>= 3` NFRs with concrete architectural decisions | Major | **Yes** | §2 covers all `8` NFRs (`RNF-01`–`RNF-08`). |
| **LC-09** | `A5` Components | Defines `>= 5` components with named provided & required interfaces | Critical | **Yes** | `G2-P1/04-...`: `7` components with named provided/required interfaces. |
| **LC-10** | `A6` Deployment | Models `>= 3` nodes with artifacts, ports/protocols & NFR link | Major | **Yes** | `G2-P1/05-...`: `5` nodes connected via `HTTPS 443 (TLS 1.3)` and private `TCP 5432`. |
| **LC-11** | `A7` Traceability | Covers `100 %` of FRs with zero orphan classes | Major | **Yes** | `G2-P1/06-...`: `12/12 RF` and `24/24` classes mapped (`0` orphans). |
| **LC-12** | `P1` Editables | Every diagram in `G2-P1` has editable `.drawio` and `.svg` | Major | **Yes** | Files `02` to `05` in `.drawio` + `.svg`. |
| **LC-13** | `B1` Conceptual | Models `>= 6` entities with ID, verbs, min/max cardinality, `N:M` & `1:N` | Critical | **Yes** | `G2-P2/01-...`: `11` Crow's Foot entities, `2` `N:M`, recursive & weak entity. |
| **LC-14** | `B2` Logical | Contains `>= 8` tables with PK/FK, `N:M` bridge tables & rules matrix | Critical | **Yes** | `G2-P2/02-...`: `12` tables & `7` transformation rules. |
| **LC-15** | `B3` Normalization | Takes `>= 2` own tables `0NF → 3NF` with written FDs (1 composite key + 1 transitive) | Critical | **Yes** | `G2-P2/03-...`: `planilla_cotizacion_bruta` (composite) & `registro_servicio_tecnico_bruto` (transitive). |
| **LC-16** | `B4` Dictionary | Documents `100 %` of tables/columns with standard, type, size, domain & constraints | Major | **Yes** | `G2-P2/04-...`: all `12` tables match DDL 1:1. |
| **LC-17** | `B5` DDL & FKs | SQL script creates `100 %` of tables with PK, FK (`ON DELETE` on `>= 3` FKs), `UNIQUE` & `>= 3 CHECK` | Critical | **Yes** | `05-script-creacion.sql`: `12` tables, `12` PK, `12` FK with `ON DELETE`, `7` `UNIQUE`, `33` `CHECK`. |
| **LC-18** | `B5` SQL Exec | Real error-free execution evidence and negative tests on SQL engine | Critical | **Yes** | `05-sql-execution-evidence.md` + `../05-log-ejecucion-sqlite.txt` (`ExitCode = 0`, `12/12` tables, `4/4` `IntegrityError`). |
| **LC-19** | `B6` Security | Defines `>= 6` policies (`>= 2` per principle) with salted `BCrypt`, `TLS`, Law 1581 & backup | Critical | **Yes** | `06-data-security-policies.md` §1: `9` concrete policies (`3` per principle). |
| **LC-20** | `B6` Roles | Permission matrix of `>= 3` roles across all tables | Major | **Yes** | `06-data-security-policies.md` §2: `4` roles × `12` tables. |
| **LC-21** | `P1`–`P2` Privacy | Public repo free of real third-party personal data or real secrets | Critical | **Yes** | Automated scan across `G1`–`G2` (`0` real PII; `.invalid` examples only). |
| **LC-22** | `P1`–`P2` Authorship | Differentiated artifacts traced to own analysis without copying other forks | Critical | **Yes** | Own GoF (`Command` + `Abstract Factory`), Hexagonal style & `12` own tables. |
| **LC-23** | `P2` Consistency | Exact column/table name match across `B2`, `B4`, and `B5` | Major | **Yes** | Cross-checked all `12` tables and columns across logical model, dictionary, and SQL. |
| **LC-24** | `P1 ↔ P2` Trace | Explicit `P1 ↔ P2` cross-audit (components/classes vs. tables and `POL-*` policies) | Minor | **Yes** | **Finding `H-04` closed (`2026-11-28`):** cross-table linking `7` components against `12/12` tables & `9/9` `POL-*` policies verified in [`06-design-traceability-matrix.md §3`](../../G2-P1-fotocopiadora-syp/english/06-design-traceability-matrix.md#3-day-2-cross-audit-2026-11-28-components-g2-p1--tables--pol--policies-g2-p2). |

---

## 2. Findings & Remediation Log (`5` Findings — `5 / 5` Closed)

| ID | Artifact | Detected finding | Severity | Fix applied / Status |
| :- | :--- | :--- | :---: | :--- |
| **`H-01`** | `G2-P1/02-diagrama-clases` | Needed to isolate CSV formula-sanitizing exporter from `Pedido` and `Cotizacion` entities. | Major | **Closed (`2026-11-27`):** isolated `ExportadorCsvSeguro` inside `NucleoNotificacionesExport`. |
| **`H-02`** | `G2-P2/05-script-creacion.sql` | Guest orders/quotes without an account (`id_usuario IS NULL`) needed nullable FK support. | Critical | **Closed (`2026-11-27`):** set `pedido.id_usuario`, `cotizacion.id_usuario`, and `solicitud_servicio.id_usuario` nullable with `ON DELETE SET NULL`. |
| **`H-03`** | `G2-P2/02-modelo-logico` & `B5` | Recursive `PRODUCTO ↔ PRODUCTO` needed to block self-referencing compatibility rows. | Major | **Closed (`2026-11-27`):** created `compatibilidad_producto(id_equipo, id_insumo)` with `CHECK (id_equipo <> id_insumo)`. |
| **`H-04`** | `G2-P1/A7` ↔ `G2-P2/B6` | Add direct cross-verification table linking `7` components in `P1` against `12` tables & `9` `POL-*` policies in `P2`. | Minor | **Closed (`2026-11-28`):** added §3 in [`06-design-traceability-matrix.md`](../../G2-P1-fotocopiadora-syp/english/06-design-traceability-matrix.md) verifying `12/12` tables and `9/9` policies. |
| **`H-05`** | `G2-P1/A2` SVG & `G2-P2/B6` | Refine typed method parameters, source-target multiplicities, and dashed interface realization arrows in `02-diagrama-clases.svg`/`.drawio`; explicitly detail Law 1581 processing purpose and consent mechanism in `B6`. | Major | **Closed (`2026-11-28`):** regenerated [`02-diagrama-clases.svg`](../../G2-P1-fotocopiadora-syp/02-diagrama-clases.svg) with typed params, end-to-end multiplicities, `5` dashed realizations, and connected `MensajeContacto`/`ExportadorCsvSeguro`; added §3 Law 1581 section in [`06-data-security-policies.md`](06-data-security-policies.md). |

---

## 3. Second Integral Verification (Day 2 · `2026-11-28`)

- **Approved criteria:** **`24 / 24` = `Yes` (`100 %`)**, `0` pending or partial criteria.
- **Resolved and re-verified findings:** **`5 / 5` closed (`H-01` to `H-05`)**.
- **Verified consistency:** `.drawio`/`.svg` diagrams, ES/EN relative links, and `12`-table SQL schema executed on `SQLite 3.53.1` (`ExitCode = 0`, `0` errors).

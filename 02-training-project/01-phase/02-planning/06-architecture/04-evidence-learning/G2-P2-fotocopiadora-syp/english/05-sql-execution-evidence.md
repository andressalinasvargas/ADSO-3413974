> **Spanish version (official rubric root):** [../05-evidencia-ejecucion-sql.md](../05-evidencia-ejecucion-sql.md)

# B5 · SQL Execution Evidence on Relational Engine (SQLite 3) — Fotocopiadora SyP

> **Purpose:** Document the reproducible, error-free execution of the DDL script [`../05-script-creacion.sql`](../05-script-creacion.sql) for **Fotocopiadora SyP** on **SQLite 3**, verifying creation of all `12` tables, strict referential integrity (`PRAGMA foreign_keys = ON`), loading of `13` zero-PII synthetic rows, and active rejection of domain, uniqueness, and foreign-key violations.

---

## 1. Execution Environment and Reproduced Procedure

| Parameter | Observed execution value |
|---|---|
| **Execution timestamp** | `2026-11-27 10:45:55` |
| **Relational engine** | `SQLite 3.53.1` (with `PRAGMA foreign_keys = ON`) |
| **Source DDL script** | [`../05-script-creacion.sql`](../05-script-creacion.sql) |
| **Raw output log** | [`../05-log-ejecucion-sqlite.txt`](../05-log-ejecucion-sqlite.txt) |
| **Overall result** | **`12/12` tables \| `12/12` FKs \| `4/4` negative tests rejected \| `ExitCode: 0`** |

---

## 2. Structural Audit of the Source DDL Script (`05-script-creacion.sql`)

| DDL / DML element | Verified count |
|---|---:|
| `CREATE TABLE` statements | `12` |
| `PRIMARY KEY` constraints | `12` |
| `FOREIGN KEY` constraints | `12` |
| `ON DELETE` clauses | `12` |
| `ON UPDATE` clauses | `12` |
| `UNIQUE` constraints | `7` |
| `CHECK` constraints | `33` |
| `INSERT INTO` statements (zero-PII synthetic data) | `13` |

---

## 3. Created Tables, Loaded Rows, and Active Foreign Keys

| # | Created table | Synthetic rows loaded | Active FKs | Status |
|---:|---|---:|---:|---|
| 1 | `categoria` | `1` | `0` | Verified |
| 2 | `compatibilidad_producto` | `1` | `2` | Verified |
| 3 | `cotizacion` | `1` | `1` | Verified |
| 4 | `detalle_cotizacion` | `1` | `2` | Verified |
| 5 | `detalle_pedido` | `1` | `2` | Verified |
| 6 | `mensaje_contacto` | `1` | `0` | Verified |
| 7 | `notificacion` | `1` | `1` | Verified |
| 8 | `pedido` | `1` | `1` | Verified |
| 9 | `producto` | `2` | `1` | Verified |
| 10 | `reporte_contador` | `1` | `1` | Verified |
| 11 | `solicitud_servicio` | `1` | `1` | Verified |
| 12 | `usuario` | `1` | `0` | Verified |
| **Total** | **`12` tables** | **`13` synthetic rows** | **`12` foreign keys** | **OK (`ExitCode = 0`)** |

> **Test-data note:** Table `producto` holds `2` synthetic records (`id_producto = 1` multifunctional copier and `id_producto = 2` compatible toner) to validate the M:N bridge `compatibilidad_producto` (`id_equipo <> id_insumo`). All emails use reserved domain `.invalid` and phones use `300000000x` with zero real PII.

---

## 4. Negative Constraint Rejection Tests (`IntegrityError`)

| Test | Evaluated constraint | Attempted invalid case | Exact engine response | Outcome |
|---|---|---|---|---|
| **Test 1** | `CHECK ck_comp_distintos` | Register self-compatibility (`id_equipo = id_insumo`) | `IntegrityError: CHECK constraint failed: ck_comp_distintos` | **Rejected (`OK`)** |
| **Test 2** | `UNIQUE uk_rep_usuario_eq_mes` | Duplicate monthly counter report for same `id_usuario`, `modelo_equipo`, and `mes_reportado` | `IntegrityError: UNIQUE constraint failed: reporte_contador.id_usuario, reporte_contador.modelo_equipo, reporte_contador.mes_reportado` | **Rejected (`OK`)** |
| **Test 3** | `FK ON DELETE RESTRICT` | Delete a category referenced by active products | `IntegrityError: FOREIGN KEY constraint failed` | **Rejected (`OK`)** |
| **Test 4** | `CHECK ck_ped_tot` | Insert a `pedido` whose `total` is less than `subtotal` | `IntegrityError: CHECK constraint failed: ck_ped_tot` | **Rejected (`OK`)** |

---

## 5. Traceability and Raw Log Link

- **Plain-text raw log:** [`../05-log-ejecucion-sqlite.txt`](../05-log-ejecucion-sqlite.txt)
- **Evaluated DDL script:** [`../05-script-creacion.sql`](../05-script-creacion.sql)
- **Data dictionary:** [`04-data-dictionary.md`](04-data-dictionary.md)
- **Security policies:** [`06-data-security-policies.md`](06-data-security-policies.md)
- **Design origin (`G2-P1` & `G1-P2`):** [G2-P1 Hexagonal Architecture](../../G2-P1-fotocopiadora-syp/english/03-software-architecture.md) and [G1-P2 ERD](../../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/english/05-erd-description.md).

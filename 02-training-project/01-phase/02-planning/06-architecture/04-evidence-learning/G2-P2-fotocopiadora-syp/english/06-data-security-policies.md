> **Spanish version (official rubric root):** [../06-politicas-seguridad-datos.md](../06-politicas-seguridad-datos.md)

# B6 · Data Security Policies & Role Access Matrix (`Fotocopiadora SyP`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593101`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`

---

## 1. Security Policies Applied to the Model (`9` Policies: `3` per Principle)

| Principle | ID | Concrete technical policy and control over `Fotocopiadora SyP` tables | Verification mechanism |
| :--- | :--- | :--- | :--- |
| **Integrity** | **POL-INT-01** | Enforce referential integrity and domain constraints directly in the DB engine via `12` FKs with explicit actions (`RESTRICT` on referenced products/category, `CASCADE` on details & notifications, `SET NULL` on orders/quotes/service when deactivating a user) and `33` named `CHECK`s (`precio_cop >= 0`, `cantidad >= 1`, `total >= subtotal`). | Real execution of `05-script-creacion.sql` (`4/4` `IntegrityError` negative tests). |
| **Integrity** | **POL-INT-02** | Prohibit physical deletion of orders, quotes, and accounts with history via **logical deactivation (`activo = 0`)** in `usuario` and `producto`, and prevent duplicate monthly counter submissions via `UNIQUE uk_rep_usuario_eq_mes(id_usuario, modelo_equipo, mes_reportado)`. | E2E anti-double-submit checks (`orderSubmissionInFlight`) and SQL duplicate rejection. |
| **Integrity** | **POL-INT-03** | Recalculate `pedido.subtotal`, `pedido.iva` (`19 %`), `pedido.total`, and `detalle_pedido.subtotal_linea` **exclusively server-side** using current `producto.precio_cop` (frozen in `precio_unitario_pactado` at checkout) and validate `estado_stock <> 'out'`. | Automated `pytest` suite rejecting tampered prices or inactive SKUs (`HTTP 400`). |
| **Confidentiality** | **POL-CON-01** | **Salted cryptographic password hashes:** `usuario.clave_hash` stores **only a salted one-way cryptographic hash (`BCrypt`)**, never plaintext or reversible encryption; API/admin JSON outputs always omit `clave_hash`. | Output Pydantic schema audit on `usuario`. |
| **Confidentiality** | **POL-CON-02** | **Transit encryption (`TLS 1.3`) & `HttpOnly` session:** all traffic between `N1`/`N2` and `N3`/`N4` travels over **`HTTPS 443`**, JWT session travels exclusively in **`HttpOnly` cookie `syp_session`** (never `localStorage`) signed with `SYP_JWT_SECRET` (`>= 32` chars) plus `CSP`/`HSTS` headers. | Browser cookie and edge TLS header inspection. |
| **Confidentiality** | **POL-CON-03** | **Personal data privacy (Law 1581 of 2012) & `is_owner` masking:** public lookups by `codigo_pedido` or `codigo_cotizacion` mask `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, and `direccion_entrega` unless the requester is the authenticated owner or admin; CSV exports neutralize spreadsheet formulas (`'`). | E2E tests verifying PII masking and CSV formula neutralization (`=,+,-,@`). |
| **Availability** | **POL-DIS-01** | **Automated daily backup:** daily `02:00 a.m.` (`America/Bogota`) logical dump encrypted with `AES-256` replicated to external S3 storage with `30`-day minimum retention. | Daily execution log and SHA-256 dump checksum. |
| **Availability** | **POL-DIS-02** | **Monthly restore drill:** on the first Monday of each month, restore the latest backup into an isolated instance verifying `12/12` tables and referential integrity (`RPO <= 24 h`, `RTO <= 2 h`). | Monthly restoration drill minutes. |
| **Availability** | **POL-DIS-03** | **Static & PWA contingency (`RNF-06`):** when backend `N4` is unreachable (static deployment mode), the browser serves catalog/quotes/reservations via `dist/`, `sw.js`, and `localStorage` fallback routed to official WhatsApp. | Static fallback tests without backend and offline PWA check. |

---

## 2. Permission Matrix Across `4` Roles vs. All `12` Tables

| Table (`B2`/`B5`) | Role 1: **Visitor** *(unauthenticated)* | Role 2: **Registered Customer** | Role 3: **Administrator** | Role 4: **DB Admin / Infra Operator** |
| :--- | :--- | :--- | :--- | :--- |
| **`usuario`** | `INSERT` *(self-registration only with `rol = 'cliente'`)* | `SELECT` *(own row, excluding `clave_hash`)*, `UPDATE` *(own profile/password)* | `SELECT` *(excluding `clave_hash`)*, `UPDATE` *(`activo`)* | `SELECT`, `INSERT`, `UPDATE` *(operations & support)* |
| **`notificacion`** | No access | `SELECT`, `UPDATE` *(`leida = 1` own `id_usuario` only)* | `SELECT`, `INSERT`, `UPDATE` *(operational notices)* | `SELECT`, `DELETE` *(retention cleanup)* |
| **`categoria`** | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE` |
| **`producto`** | `SELECT` *(only `activo = 1`)* | `SELECT` *(only `activo = 1`)* | `SELECT`, `INSERT`, `UPDATE` *(logical disable `activo = 0`)* | `SELECT`, `INSERT`, `UPDATE` |
| **`compatibilidad_producto`** | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `DELETE` | `SELECT`, `INSERT`, `DELETE` |
| **`pedido`** | `INSERT` *(guest checkout)*, `SELECT` *(PII-masked summary by code)* | `INSERT`, `SELECT` *(full detail only if `is_owner`)* | `SELECT`, `UPDATE` *(`estado_pago`, `estado_envio`)* + Export CSV | `SELECT` *(read-only accounting audit)* |
| **`detalle_pedido`** | `INSERT` *(on order submit)* | `SELECT` *(own orders)* | `SELECT` | `SELECT` *(read-only)* |
| **`cotizacion`** | `INSERT`, `SELECT` *(code lookup, PII masked to non-owners)* | `INSERT`, `SELECT` *(full if `is_owner`)* | `SELECT`, `UPDATE` *(observations/validity)* | `SELECT` *(read-only)* |
| **`detalle_cotizacion`** | `INSERT` *(on quote submit)* | `SELECT` *(own quotes)* | `SELECT` | `SELECT` *(read-only)* |
| **`solicitud_servicio`** | `INSERT` *(public technical appointment)* | `INSERT`, `SELECT` *(own requests)* | `SELECT`, `UPDATE` *(`estado_atencion`, `notas_admin`)* | `SELECT` *(read-only)* |
| **`reporte_contador`** | No access | `SELECT`, `INSERT` *(own renting devices only)* | `SELECT` *(renting audit)* + Export CSV | `SELECT` *(read-only)* |
| **`mensaje_contacto`** | `INSERT` *(public contact form)* | `INSERT` | `SELECT`, `UPDATE` *(`leido = 1`)* | `SELECT` |

---

## 3. Personal Data Processing: Purpose, Consent & Data-Subject Rights (Law 1581 of 2012 & Decree 1074 of 2015)

### 3.1 Specific Purpose per Table Containing PII

| Table with PII | Processed fields | Exclusive purpose disclosed to data subject | Operational retention |
|---|---|---|---|
| **`usuario`** | `correo_unico`, `nombre_completo`, `telefono` | Secure authentication (`BCrypt`/`JWT`), own order/service history lookup, status alerts, and counter reporting. | While account remains active (`activo = 1`). |
| **`pedido`** | `nombre_cliente`, `correo_cliente`, `telefono_cliente`, `nit_cliente`, `direccion_entrega`, `ciudad_entrega` | Tax invoicing, physical dispatch of equipment/supplies, and statutory warranty support (`Law 1480/2011`). | Per statutory commercial/accounting retention period. |
| **`cotizacion`** | `nombre_cliente`, `correo_cliente`, `telefono_cliente` | Issuance and commercial follow-up of formal quotes within `vigencia_dias` (`1`–`90` days). | Commercial validity window & quote history archive. |
| **`solicitud_servicio`** | `nombre_solicitante`, `telefono_contacto` | Scheduling preventive, corrective, or installation technical visits in the requested time slot. | Service ticket lifecycle & technical warranty log. |
| **`mensaje_contacto`** | `nombre`, `correo`, `telefono` | Timely reply to commercial or support inquiries sent from the public contact form. | Until inquiry resolution or deletion request. |

### 3.2 Capture of Prior, Explicit, and Informed Authorization

1. Every intake form (`account signup`, `order checkout`, `quote request`, `technical service booking`, and `contact`) renders an **unchecked-by-default consent checkbox** prior to submission, linked to the visible privacy notice describing the purposes above.
2. The system persists the creation timestamp (`fecha_creacion` in ISO-8601 UTC) as verifiable proof of when consent was granted prior to processing.
3. No transfers to external autonomous controllers occur without extra express authorization; external encrypted backup storage operates under a **data processor transmission** agreement (`Decree 1074/2015`).

### 3.3 Handling Inquiries, Updates, Rectification & Deletion Requests (`ARCO`)

- **Access & rectification:** authenticated users inspect and update profile data via verified session (`POL-CON-02`) or through Fotocopiadora SyP's official admin channel.
- **Deletion & revocation:** upon valid revocation request, the platform applies **immediate logical deactivation (`usuario.activo = 0`)** or anonymization in tables free of statutory retention (`mensaje_contacto`), preserving only legally required tax/order rows (`pedido`) blocked from secondary commercial use.

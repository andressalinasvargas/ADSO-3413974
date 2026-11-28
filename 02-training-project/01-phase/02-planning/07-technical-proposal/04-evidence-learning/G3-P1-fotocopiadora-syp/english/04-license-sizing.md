> **Spanish version (official rubric root):** [../04-dimensionamiento-licencias.md](../04-dimensionamiento-licencias.md)

# A4 · Parameterized Sizing and Real License Inventory — Fotocopiadora SyP

> **Scenario status:** **Provisional Variant B** (`120` monthly active users, `30` peak concurrent users, `2` sites in Neiva —Main Branch & Commercial/Warehouse Branch—, `99.5 %` availability target, reference budget cap `$70,000,000 COP`). Final commercial figures and provider comparisons will be consolidated in Day 2 deliverables (`A5`, `A6`, `B1`–`B4`).

---

## 1. Parameterized Scenario Matrix (`A` – `D`)

| Operational parameter | Scenario A (Local base) | **Scenario B (Provisional selected)** | Scenario C (Regional expanded) | Scenario D (High availability) |
|---|---:|---:|---:|---:|
| **Monthly active users** | `40` | **`120`** | `400` | `1,200+` |
| **Peak concurrency** | `10` users | **`30` users** | `90` users | `250` users |
| **Served locations** | `1` site | **`2` sites** | `4` sites | `8+` sites |
| **Availability target (`ANS-01`)** | `99.0 %` | **`99.5 %`** | `99.8 %` | `99.9 %` |
| **Recovery targets (`RPO` / `RTO`)** | `<= 24 h` / `<= 8 h` | **`<= 24 h` / `<= 2 h`** | `<= 6 h` / `<= 1 h` | `<= 15 min` / `<= 30 min` |
| **Compute & DB topology** | Single instance app + DB | **Docker API (`2` vCPU / `4 GB`) + Private PostgreSQL 16 + S3 Backups + `60 s` Monitoring** | Load-balanced cluster + read replica DB | Active Multi-AZ + dedicated cache + auto-failover |

---

## 2. Technical Sizing of the `8` Components Aligned 1:1 with `[N1]`–`[N7]`

The first `7` components map 1:1 to nodes `[N1]`–`[N7]` in [../../G3-P2-fotocopiadora-syp/03-diagrama-arquitectura-despliegue-g3.svg](../../G3-P2-fotocopiadora-syp/03-diagrama-arquitectura-despliegue-g3.svg), plus the Dev/QA CI-CD pipeline:

| # | Node / Component (`G3-P2`) | Specification in **Provisional Scenario B** | Scaling in Scenarios A / C / D | Licensing model |
|---:|---|---|---|---|
| **1** | **`[N1]` Client Browser PWA (`EXCLUDED`)** | Buyer's own devices (`PWA + sw.js + localStorage fallback`), **budget `$0`**. | Identical across A–D (customer hardware) | Open web standards (no commercial fee) |
| **2** | **`[N2]` Admin Workstation (`EXCLUDED`)** | Existing SyP staff PC in Neiva (`admin.html`, `ExportadorCsvSeguro`, reports), **budget `$0`**. | Identical across A–D (existing branch hardware) | Modern browser + custom web app |
| **3** | **`[N3]` Edge DNS + Proxy TLS 1.3** | `.com`/`.co` domain + `HTTPS 443` CDN + `Let's Encrypt` cert + `CSP`/`HSTS` headers. | A: standard TLS \| C: OWASP WAF \| D: multi-region WAF | Managed DNS/Proxy + open TLS |
| **4** | **`[N4]` Application API Server (`Docker`)** | Linux VPS (`2 vCPU`, `4 GB RAM`) running `FastAPI + Uvicorn + 9 Routers + BCrypt` and `HttpOnly` cookie `syp_session`. | A: `1 vCPU`, `2 GB` \| C: `2` balanced nodes \| D: auto-scaled `4+` nodes | Custom code + permissive `MIT`/`BSD-3`/`Apache-2.0` |
| **5** | **`[N5]` Private Database Server** | `PostgreSQL 16` in private Docker network (`TCP 5432` closed to public Internet), `2 vCPU`, `4 GB RAM`, `80 GB` encrypted SSD, `12` 3FN tables. | A: `1 vCPU`, `2 GB`, `30 GB SSD` \| C: `4 vCPU`, `8 GB` + replica \| D: Multi-AZ | PostgreSQL License (permissive, `$0` per core) |
| **6** | **`[N6]` Encrypted External S3 Backups** | External S3 object storage encrypted (`AES-256`), daily dump at `02:00 COT`, `30`-day minimum retention (`RPO <= 24 h`). | A: `30 GB` \| C: `250 GB` \| D: `500 GB` geo-replicated | Pay-per-use / standard S3 |
| **7** | **`[N7]` External Monitoring & SLA Alerts** | Continuous `60 s` `HTTPS` probes (`ANS-01` / `ANS-02`) with early `P1 <= 30 min` incident alerting. | A: `5 min` probe \| C: APM metrics \| D: SIEM & 24/7 support | SaaS / open external monitoring |
| **8** | **Test & CI-CD Pipeline (`Dev/QA`)** | Automated `node --check`, `pytest` + `httpx`, `Playwright` E2E, and `SQLite 3`/`PostgreSQL 16` DDL validation. | Identical across A–D | Open tooling (`MIT`/`BSD`/`Apache-2.0`) |

---

## 3. Verified Real Dependency Inventory from `Fotocopiadora-SyP-main`

Verified directly from project manifests (`Fotocopiadora-SyP-main/fastapi_backend/requirements.txt`, `requirements-dev.txt`, and `package.json`):

### 3.1 Production Backend Dependencies (`fastapi_backend/requirements.txt` — `8` packages)

| Package | Pinned version | Role in Fotocopiadora SyP | OSI license | Proprietary compatibility |
|---|---:|---|---|---|
| `fastapi` | `0.115.14` | REST ASGI framework & OpenAPI contracts | `MIT` | Compatible, zero copyleft |
| `starlette` | `0.46.2` | ASGI routing, middlewares & HTTP responses | `BSD-3-Clause` | Compatible, zero copyleft |
| `uvicorn` | `0.54.0` | Production ASGI server | `BSD-3-Clause` | Compatible, zero copyleft |
| `pydantic` | `2.14.4` | Strict schema validation & serialization | `MIT` | Compatible, zero copyleft |
| `email-validator` | `2.4.0` | Email syntax check on signup/contact | `Unlicense` | Public domain / compatible |
| `pyjwt` | `2.15.1` | Session JWT issuance & verification (`syp_session`) | `MIT` | Compatible, zero copyleft |
| `bcrypt` | `5.0.0` | Salted adaptive password hashing (`POL-CON-01` / `RNF-05`) | `Apache-2.0` | Compatible, zero copyleft |
| `python-multipart` | `0.0.34` | Multipart form & upload parsing | `Apache-2.0` | Compatible, zero copyleft |

### 3.2 QA & Automation Dependencies (`requirements-dev.txt` — `3` extra packages)

| Package | Pinned version | Dev/QA exclusive use | OSI license | Note |
|---|---:|---|---|---|
| `pytest` | `9.2.0` | Backend unit & integration test suite | `MIT` | Excluded from runtime bundle |
| `httpx` | `0.28.1` | FastAPI endpoint test HTTP client | `BSD-3-Clause` | Excluded from runtime bundle |
| `playwright` | `1.65.2` | Browser E2E & layout test automation | `Apache-2.0` | QA/CI only |

### 3.3 Frontend Runtime & Tooling (`package.json` — `fotocopiadora-syp` v`2.0.0`)

- **Real frontend stack:** Native HTML5 + CSS3 + modular JavaScript without a bundler or external npm production runtime dependencies (`0` third-party npm packages in prod), targeting `> 0.5% in CO`, `Chrome >= 90`, `Safari >= 14`, `Firefox >= 90`, `engines.node >= 18`.
- **Automated check:** `npm run check` (`node --check` over `js/config.js`, `js/products.js`, `js/auth.js`, `js/services.js`, `js/interactions.js`, `sw.js`, and `js/app/`).

---

## 4. Licensing & Intellectual Property Strategy

1. **Bespoke software (source code, SQL, views & docs):** Exclusive **proprietary license** owned by **Fotocopiadora SyP** via **written cession of economic rights** under **Law 23 of 1982** and **Andean Decision 351 of 1993**, with developers retaining inalienable moral authorship rights.
2. **Third-party license hygiene:** 100 % of the `11` inventoried Python packages (`8` prod + `3` QA) use permissive licenses (`MIT`, `BSD-3-Clause`, `Apache-2.0`, `Unlicense`), ensuring **zero copyleft (`GPL`/`AGPL`) contamination**.

> **Spanish version (official rubric root):** [../05-vista-despliegue.md](../05-vista-despliegue.md)

# A6 · Deployment View (`5` Nodes — `Fotocopiadora SyP`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P1 · Design artifacts (`RAP 593103`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Editable source:** [../05-vista-despliegue.drawio](../05-vista-despliegue.drawio) · **Exported image:** [../05-vista-despliegue.svg](../05-vista-despliegue.svg)

---

## 1. Node, Artifact, and Protocol Catalog

| ID | Deployment node | Hosted artifacts | Connection and protocol | Decisions addressing `NFR` |
| :- | :--- | :--- | :--- | :--- |
| **`N1`** | **`NavegadorClientePWA`** *(Visitor/customer mobile or PC)* | Bundled HTML/CSS/JS in `dist/`, `WebP` images, `sw.js`, and `localStorage` fallback | `HTTPS 443 (TLS 1.3)` to `N3` | Satisfies `RNF-02` (`>= 320 px`), `RNF-04` (`WebP` + `lazy`), and `RNF-06` (static fallback). |
| **`N2`** | **`EstacionAdministrador`** *(Admin workstation in Neiva)* | `admin.html`, `login.html`, on-demand CSV downloads | `HTTPS 443 (TLS 1.3)` to `N3` | Operates strictly with `HttpOnly` cookie (`RNF-05`) and sanitized CSV (`RF-11`). |
| **`N3`** | **`BordeEstaticoRenderCDN`** *(CDN / TLS Reverse Proxy)* | Static distribution `dist/` (hides backend/docs), `CSP`/`HSTS`/`X-Frame-Options` headers | Receives `HTTPS 443`; proxies REST API calls to `N4` over encrypted channel | Addresses `RNF-04` (CDN static caching) and `RNF-05` (minimal attack surface in static mode). |
| **`N4`** | **`ServidorAPIFastAPIDocker`** *(Python 3.12 + Uvicorn Docker Container)* | `fastapi_backend` (`main.py`, `core.py`, `schemas.py`, `9` routers), hexagonal core & `BCrypt`/`PyJWT` | Receives API traffic from `N3`; connects to `N5` via **private `TCP 5432`** | Isolates logic and `HttpOnly` sessions (`RNF-05`), validates Pydantic schemas, and enables portable E2E tests (`RNF-08`). |
| **`N5`** | **`MotorRelacionalPostgreSQL`** *(PostgreSQL 16 in prod / SQLite 3 in QA)* | `12` normalized 3FN tables, indexes, `ON DELETE` FKs, and periodic backups | Listens **only on private `TCP 5432` network** (closed to Internet) | Prevents direct exposure of personal data (`RNF-05`) and ensures ACID order/counter transactions (`RF-05`, `RF-10`). |

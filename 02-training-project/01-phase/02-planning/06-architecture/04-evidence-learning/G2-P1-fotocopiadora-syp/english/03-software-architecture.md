> **Spanish version (official rubric root):** [../03-arquitectura-software.md](../03-arquitectura-software.md)

# A4 · Software Architecture (Hexagonal / Ports & Adapters)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P1 · Design artifacts (`RAP 593103`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Editable source:** [../03-arquitectura-software.drawio](../03-arquitectura-software.drawio) · **Exported image:** [../03-arquitectura-software.svg](../03-arquitectura-software.svg)

---

## 1. Architectural Style and Communication Rules

The system adopts **Hexagonal Architecture (Ports and Adapters)** organized into three concentric rings with zero layer-skipping:

1. **Primary Adapters (Inbound):**
   - `PWA Web Pública` (`index.html`, `productos.html`, `cotizacion.html`, `servicio-tecnico.html`, `contacto.html`) and `Panel Admin SPA` (`admin.html`, `login.html`).
   - Communicate via **`HTTPS/JSON`** exclusively with **Input Ports (FastAPI Routers + Pydantic schemas + `HttpOnly` JWT)**; they never access SQL directly or hold authoritative pricing logic.
2. **Domain & Application Core (Center):**
   - Groups entities (`Persona`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador`), GoF commands (`IComandoOperacion`), and factories (`IFabricaEntregaComercial`).
   - Recalculates prices, VAT (`19 %`), stock availability (`stock_status`), and PII masking (`is_owner`) **independently of the database engine or HTTP framework**.
3. **Output Ports & Secondary Adapters:**
   - The domain defines port interfaces (`IRepositorioComercial`, `IExportadorCsvSeguro`, `ICanalMensajeria`).
   - Secondary adapters (`SQLAlchemy/PostgreSQL`, `Anti-formula CSV Exporter`, `WhatsApp + localStorage fallback`) implement those ports without coupling the core.

---

## 2. Architectural Decisions Mapped to All `8` NFR (`RNF-01`–`RNF-08`)

| NFR ID | Category | Architectural decision | How compliance is ensured |
|---|---|---|---|
| **`RNF-01`** | Usability | Role-separated primary adapters (`WebCatalogoPWA` vs. `PanelAdminWeb`) with 6-category hierarchy | Reduces navigation friction (`<= 3` clicks) and separates guest flows from admin panel. |
| **`RNF-02`** | Responsiveness | Responsive CSS grid system with uniform breakpoints (`320 px` to desktop) in HTML adapters | Prevents horizontal overflow and ensures `24–44 px` touch targets on mobile. |
| **`RNF-03`** | Accessibility | Semantic HTML, `>= 4.5:1` contrast tokens, and centralized focus management in UI adapters | Guarantees keyboard operation (`radiogroup`, `Escape`) in light and dark themes. |
| **`RNF-04`** | Performance | Static edge separation (`dist/` + `WebP` images + `sw.js`) from stateless REST endpoints | Shrinks payload (`6.5 MB -> 0.77 MB` in gallery) and keeps static asset delivery off the API. |
| **`RNF-05`** | Security & privacy | Input port validation (`Pydantic`, `BCrypt`, `HttpOnly` cookie `syp_session`, rate limiting, `is_owner`) | Prevents enumeration on quotes/orders and blocks injection/abuse before reaching the core. |
| **`RNF-06`** | Availability & contingency | Port decoupling enabling `localStorage` catalog fallback + WhatsApp adapter when API is offline | Keeps catalog and quoting usable in static deployment (`dist/`) without blocking visitors. |
| **`RNF-07`** | Localization & formats | `COP` currency and `es-CO` date formatting encapsulated in shared utilities | Uniform display across web receipts, printouts, and admin tables. |
| **`RNF-08`** | Maintainability & verification | Business rules isolated behind ports (`IRepositorioComercial`, `IComandoOperacion`) | Enables `pytest` API/command testing with isolated DB and Playwright E2E without brittle mocks. |

---

## 3. Discarded Architectural Alternatives

1. **Tightly coupled monolith without ports (SQL directly inside HTTP views/routes — discarded):**
   - **Reason for rejection:** Mixing raw SQL and business rules inside HTTP handlers blocks rule reuse across orders, quotes, and exports, breaks cohesion, and hinders isolated testing (`RNF-08`).
2. **Distributed microservices per entity (catalog, orders, service, and notifications as separate services — discarded):**
   - **Reason for rejection:** For a small team (`2` developers) and local retail volume, splitting into `4–5` network services adds unnecessary latency, eventual consistency risks in stock/orders, and infrastructure cost far beyond actual project needs.

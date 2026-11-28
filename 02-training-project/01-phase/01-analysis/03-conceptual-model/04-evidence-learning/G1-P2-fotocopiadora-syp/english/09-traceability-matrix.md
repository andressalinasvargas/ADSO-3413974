> **Spanish version (official rubric root):** [../09-matriz-trazabilidad.md](../09-matriz-trazabilidad.md)

# Requirement → Analysis Artifacts Traceability Matrix · Fotocopiadora SyP

Matrix built per **Annex C** of `Plantilla_README_Entrega_G1.md`, tracing **100 % (`12 / 12`)** of functional requirements from the SRS through use cases, behavior diagrams/templates, domain classes, ERD entities, and visual prototype screens.

---

## 1. Full Traceability (`RF-01` to `RF-12`)

| Requirement | Use case | Activity diagram | Template | Domain class | ERD entity | Screen |
|---|---|---|---|---|---|---|
| `RF-01` Display home and value proposition | `CU-01` Consult home and catalog | — *(browsing query)* | — | `Categoria`, `Producto` | `CATEGORIA`, `PRODUCTO` | [Screen 01 (`CU-01/02`)](../06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-02` Browse, filter, and compare | `CU-01` Consult home and catalog | — *(interactive search)* | — | `Categoria`, `Producto` | `CATEGORIA`, `PRODUCTO` | [Screen 01 (`CU-01/02`)](../06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-03` View sheet and compatibilities | `CU-01` Consult home and catalog | — *(interactive detail)* | — | `Producto`, `Categoria` | `PRODUCTO` *(includes recursive compatibility)* | [Screen 01 (`CU-01/02`)](../06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-04` Manage persistent cart | `CU-02` Manage shopping cart | — *(prepares `CU-03`)* | Referenced in `CU-03` *(precondition)* | `CarritoCompra`, `Producto` | `PRODUCTO` *(prior state before `PEDIDO`/`DETALLE_PEDIDO`)* | [Screen 01 (`CU-01/02`)](../06-prototipo-inicial/pantalla-01-cu01-cu02-catalogo-carrito.png) |
| `RF-05` Confirm purchase order | `CU-03` Confirm order, `CU-05` View commercial doc | [CU-03 Confirm order](../01-actividad-cu03-confirmar-pedido.svg) | [Template 1 (`CU-03`)](03-extended-use-case-templates.md#template-1--cu-03--confirm-purchase-order) | `Pedido`, `DetallePedido`, `Cliente`, `Producto` | `PEDIDO`, `DETALLE_PEDIDO`, `PRODUCTO`, `USUARIO` | [Screen 02 (`CU-03`)](../06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |
| `RF-06` Generate and view formal quote | `CU-04` Generate quote, `CU-05` View commercial doc | Extended from `CU-02` / parallel to `CU-03` | — *(managed in `CU-11`)* | `Cotizacion`, `Producto`, `Cliente` | `COTIZACION`, `DETALLE_COTIZACION`, `PRODUCTO` | [Screen 02 (`CU-03` / Quote option)](../06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) |
| `RF-07` Manage account & history | `CU-06` Authenticate, `CU-07` Profile & history | — | Prior req cited in `CU-11` | `Persona`, `Cliente`, `Pedido`, `SolicitudServicio` | `USUARIO`, `PEDIDO`, `SOLICITUD_SERVICIO` | [Screen 02 (`CU-03`)](../06-prototipo-inicial/pantalla-02-cu03-confirmar-pedido.png) / [Screen 04 (`CU-11`)](../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-08` Send contact inquiry | `CU-08` Send contact inquiry | — | Referenced in admin (`CU-11`) | `Persona` *(sender)*, `Administrador` | `MENSAJE_CONTACTO` | [Screen 03 (`CU-09` direct support)](../06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |
| `RF-09` Request technical service & diagnosis | `CU-09` Request technical service | [CU-09 Technical service](../02-actividad-cu09-servicio-tecnico.svg) | [Template 2 (`CU-09`)](03-extended-use-case-templates.md#template-2--cu-09--request-technical-service-and-diagnosis) | `SolicitudServicio`, `Cliente`, `Producto` | `SOLICITUD_SERVICIO`, `USUARIO` | [Screen 03 (`CU-09`)](../06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) |
| `RF-10` Report renting counters | `CU-10` Report renting counters *(includes `CU-06`)* | — | Referenced in domain & `CU-11` | `ReporteContador`, `Cliente` | `REPORTE_CONTADOR`, `USUARIO` | [Screen 03 (`CU-09`/Renting)](../06-prototipo-inicial/pantalla-03-cu09-solicitar-servicio-tecnico.png) & [Screen 04 (`CU-11`)](../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-11` Administer catalog & operations | `CU-11` Administer catalog & operations | — *(extends to `CU-12`)* | [Template 3 (`CU-11`)](03-extended-use-case-templates.md#template-3--cu-11--administer-catalog-and-commercial-operations) | `Administrador`, `Producto`, `Categoria`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador` | `USUARIO`, `CATEGORIA`, `PRODUCTO`, `PEDIDO`, `COTIZACION`, `SOLICITUD_SERVICIO`, `REPORTE_CONTADOR` | [Screen 04 (`CU-11`)](../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |
| `RF-12` Manage status notifications | `CU-12` Manage status notifications | Parallel branch in [CU-03](../01-actividad-cu03-confirmar-pedido.svg) & [CU-09](../02-actividad-cu09-servicio-tecnico.svg) | Extension point in `CU-11` step 5 | `Notificacion`, `Persona`, `Cliente`, `Administrador` | `NOTIFICACION` *(weak entity)*, `USUARIO` | [Screen 04 (`CU-11` alerts)](../06-prototipo-inicial/pantalla-04-cu11-panel-administrativo.png) |

---

## 2. Quantitative Coverage Summary

- **Functional requirements traced to use case, domain class, and ERD entity:** `12 / 12` (**`100 %`**).
- **Critical use cases traced end-to-end (activity diagram, extended template, and labeled screen):** `3 / 3` (`CU-03`, `CU-09`, `CU-11`, plus `CU-01`/`CU-02` on Screen 01).
- **Orphan ERD entities lacking requirement support:** `0`.
- **Orphan domain classes lacking use case/requirement traceability:** `0`.

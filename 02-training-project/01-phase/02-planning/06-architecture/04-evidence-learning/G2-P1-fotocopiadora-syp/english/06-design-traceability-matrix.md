> **Spanish version (official rubric root):** [../06-matriz-trazabilidad-diseno.md](../06-matriz-trazabilidad-diseno.md)

# A7 · Full Traceability Matrix (`Analysis → Design`) — `Fotocopiadora SyP`

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P1 · Design artifacts (`RAP 593103`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Verified coverage:** **`12 / 12` `RF` (`100 %`) · `8 / 8` `RNF` (`100 %`) · `24 / 24` classes/interfaces (`0` orphans)**.

---

## 1. Forward Traceability: Functional Requirements (`RF-01`–`RF-12`) → Design

| FR ID | Functional requirement (`G1-P1`) | Classes & interfaces in `A2`/`A3` | Component(s) in `A5` | Table(s) in `G2-P2` | Architectural / pattern decision |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`RF-01`** | Display home and value proposition | `Categoria`, `Producto` | `WebCatalogoPWA`, `AdaptadorPersistenciaSQL` | `categoria`, `producto` | Static edge separation `dist/` (`RNF-04`) |
| **`RF-02`** | Browse, filter, and compare catalog | `Categoria`, `Producto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `categoria`, `producto` | 12-item pagination & filters via output port |
| **`RF-03`** | View sheet and compatibilities | `Producto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones` | `producto`, `compatibilidad_producto` | Recursive `N:M` resolved in bridge table |
| **`RF-04`** | Manage persistent shopping cart | `CarritoCompra`, `Producto` | `WebCatalogoPWA` | `producto` *(stock/price lookup)* | Atomic client state + server validation in `RF-05` |
| **`RF-05`** | Confirm purchase order | `Cliente`, `Pedido`, `DetallePedido`, `DespachadorComandos`, `ComandoConfirmarPedido`, `FabricaEntregaPedido` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `pedido`, `detalle_pedido`, `notificacion` | **Command** + **Abstract Factory**; server recalculation |
| **`RF-06`** | Generate and view formal quote | `Cotizacion`, `DetalleCotizacion`, `DespachadorComandos`, `ComandoEmitirCotizacion`, `FabricaEntregaCotizacion` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `cotizacion`, `detalle_cotizacion`, `notificacion` | `is_owner` PII masking + static fallback `RNF-06` |
| **`RF-07`** | Manage user account & history | `Persona`, `Cliente`, `Administrador`, `IRepositorioComercial` | `NucleoIdentidadAcceso`, `PanelAdminWeb`, `AdaptadorPersistenciaSQL` | `usuario`, `pedido`, `cotizacion` | Salted `BCrypt` + `HttpOnly` cookie (`POL-CON-01`) |
| **`RF-08`** | Send inquiry via contact channel | `MensajeContacto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `mensaje_contacto` | WhatsApp adapter + inbox persistence |
| **`RF-09`** | Request technical service & diagnosis | `SolicitudServicio`, `ComandoRadicarSolicitud`, `DespachadorComandos` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `solicitud_servicio`, `notificacion` | **Command** pattern with slot/type validation |
| **`RF-10`** | Report renting counters | `Cliente`, `ReporteContador`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `reporte_contador` | Restricted to authenticated `Cliente` (`RBAC`) |
| **`RF-11`** | Administer catalog and operations | `Administrador`, `Producto`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ExportadorCsvSeguro` | `PanelAdminWeb`, `NucleoPedidosCotizaciones`, `NucleoNotificacionesExport` | `usuario`, `producto`, `pedido`, `cotizacion`, `solicitud_servicio`, `reporte_contador`, `mensaje_contacto` | Strict RBAC + anti-formula CSV sanitizer |
| **`RF-12`** | Manage status notifications | `Persona`, `Notificacion`, `IFabricaEntregaComercial` | `NucleoNotificacionesExport`, `PanelAdminWeb`, `WebCatalogoPWA` | `notificacion` | Weak entity tied to `usuario` + delivery factory |

---

## 2. Reverse Verification: All `24` Classes/Interfaces Traced to Requirements (`0` Orphans)

| # | OO Element in `A2`/`A3` | Type | Requirements addressed | Component in `A5` |
| :- | :--- | :---: | :--- | :--- |
| `1` | `Persona` (`{abstract}`) | Class | `RF-07`, `RF-12`, `RNF-05` | `NucleoIdentidadAcceso` |
| `2` | `Cliente` | Class | `RF-05`, `RF-06`, `RF-07`, `RF-09`, `RF-10` | `NucleoIdentidadAcceso` |
| `3` | `Administrador` | Class | `RF-07`, `RF-11`, `RNF-05` | `NucleoIdentidadAcceso` |
| `4` | `Categoria` | Class | `RF-01`, `RF-02` | `NucleoPedidosCotizaciones` |
| `5` | `Producto` | Class | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RF-11` | `NucleoPedidosCotizaciones` |
| `6` | `CarritoCompra` | Class | `RF-04`, `RF-05`, `RNF-06` | `WebCatalogoPWA` |
| `7` | `Pedido` | Class | `RF-05`, `RF-11` | `NucleoPedidosCotizaciones` |
| `8` | `DetallePedido` | Class | `RF-05`, `RF-11` | `NucleoPedidosCotizaciones` |
| `9` | `Cotizacion` | Class | `RF-06`, `RF-11` | `NucleoPedidosCotizaciones` |
| `10` | `DetalleCotizacion` | Class | `RF-06`, `RF-11` | `NucleoPedidosCotizaciones` |
| `11` | `Notificacion` | Class | `RF-05`, `RF-09`, `RF-12` | `NucleoNotificacionesExport` |
| `12` | `SolicitudServicio` | Class | `RF-09`, `RF-11` | `NucleoServicioRenting` |
| `13` | `ReporteContador` | Class | `RF-10`, `RF-11` | `NucleoServicioRenting` |
| `14` | `MensajeContacto` | Class | `RF-08`, `RF-11` | `NucleoServicioRenting` |
| `15` | `ExportadorCsvSeguro` | Class | `RF-11`, `RNF-05` | `NucleoNotificacionesExport` |
| `16` | `IRepositorioComercial` | Interface | `RF-02`–`RF-12`, `RNF-08` | `AdaptadorPersistenciaSQL` |
| `17` | `DespachadorComandos` | GoF Class | `RF-05`, `RF-06`, `RF-09`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `18` | `IComandoOperacion` | GoF Interface | `RF-05`, `RF-06`, `RF-09`, `RNF-08` | `NucleoPedidosCotizaciones` |
| `19` | `ComandoConfirmarPedido` | GoF Class | `RF-05`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `20` | `ComandoEmitirCotizacion` | GoF Class | `RF-06`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `21` | `ComandoRadicarSolicitud` | GoF Class | `RF-09`, `RNF-06` | `NucleoServicioRenting` |
| `22` | `IFabricaEntregaComercial` | GoF Interface | `RF-05`, `RF-06`, `RF-12` | `NucleoPedidosCotizaciones` |
| `23` | `FabricaEntregaPedido` | GoF Class | `RF-05`, `RF-12` | `NucleoPedidosCotizaciones` |
| `24` | `FabricaEntregaCotizacion` | GoF Class | `RF-06`, `RF-12` | `NucleoPedidosCotizaciones` |

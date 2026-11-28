# A7 · Matriz de Trazabilidad Completa (`Análisis → Diseño`) — `Fotocopiadora SyP`

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Cobertura verificada:** **`12 / 12` `RF` (`100 %`) · `8 / 8` `RNF` (`100 %`) · `24 / 24` clases/interfaces (`0` huérfanas)**.

---

## 1. Trazabilidad Hacia Adelante: Requisitos Funcionales (`RF-01`–`RF-12`) → Diseño

| ID RF | Requisito funcional (`G1-P1`) | Clases e interfaces en `A2`/`A3` | Componente(s) en `A5` | Tabla(s) en `G2-P2` | Decisión arquitectónica / patrón |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`RF-01`** | Visualizar inicio y propuesta de valor | `Categoria`, `Producto` | `WebCatalogoPWA`, `AdaptadorPersistenciaSQL` | `categoria`, `producto` | Separación de borde estático `dist/` (`RNF-04`) |
| **`RF-02`** | Explorar catálogo, filtrar y comparar | `Categoria`, `Producto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `categoria`, `producto` | Paginación `12` en `12` y filtros por puerto de salida |
| **`RF-03`** | Consultar ficha y compatibilidades | `Producto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones` | `producto`, `compatibilidad_producto` | Recursiva `N:M` resuelta en tabla puente |
| **`RF-04`** | Gestionar carrito persistente | `CarritoCompra`, `Producto` | `WebCatalogoPWA` | `producto` *(consulta stock/precio)* | Estado atómico en cliente + validación servidor en `RF-05` |
| **`RF-05`** | Confirmar pedido de compra | `Cliente`, `Pedido`, `DetallePedido`, `DespachadorComandos`, `ComandoConfirmarPedido`, `FabricaEntregaPedido` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `pedido`, `detalle_pedido`, `notificacion` | Patrón **Comando** + **Fábrica Abstracta**; recálculo servidor |
| **`RF-06`** | Generar y consultar cotización formal | `Cotizacion`, `DetalleCotizacion`, `DespachadorComandos`, `ComandoEmitirCotizacion`, `FabricaEntregaCotizacion` | `WebCatalogoPWA`, `NucleoPedidosCotizaciones`, `AdaptadorPersistenciaSQL` | `cotizacion`, `detalle_cotizacion`, `notificacion` | Enmascaramiento PII `is_owner` + fallback estático `RNF-06` |
| **`RF-07`** | Gestionar cuenta de usuario e historial | `Persona`, `Cliente`, `Administrador`, `IRepositorioComercial` | `NucleoIdentidadAcceso`, `PanelAdminWeb`, `AdaptadorPersistenciaSQL` | `usuario`, `pedido`, `cotizacion` | Hash+sal `BCrypt` + cookie `HttpOnly` (`POL-CON-01`) |
| **`RF-08`** | Enviar consulta por canal de contacto | `MensajeContacto`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `mensaje_contacto` | Adaptador WhatsApp + persistencia de bandeja |
| **`RF-09`** | Solicitar servicio técnico y diagnóstico | `SolicitudServicio`, `ComandoRadicarSolicitud`, `DespachadorComandos` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `solicitud_servicio`, `notificacion` | Patrón **Comando** con verificación de franja/tipo |
| **`RF-10`** | Reportar contadores de renting | `Cliente`, `ReporteContador`, `IRepositorioComercial` | `WebCatalogoPWA`, `NucleoServicioRenting`, `AdaptadorPersistenciaSQL` | `reporte_contador` | Acceso exclusivo a `Cliente` autenticado (`RBAC`) |
| **`RF-11`** | Administrar catálogo y operaciones | `Administrador`, `Producto`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ExportadorCsvSeguro` | `PanelAdminWeb`, `NucleoPedidosCotizaciones`, `NucleoNotificacionesExport` | `usuario`, `producto`, `pedido`, `cotizacion`, `solicitud_servicio`, `reporte_contador`, `mensaje_contacto` | RBAC estricto + sanitizador CSV anti-fórmulas |
| **`RF-12`** | Gestionar notificaciones de estado | `Persona`, `Notificacion`, `IFabricaEntregaComercial` | `NucleoNotificacionesExport`, `PanelAdminWeb`, `WebCatalogoPWA` | `notificacion` | Entidad débil ligada a `usuario` + fábrica de entrega |

---

## 2. Verificación Inversa: Todas las `24` Clases/Interfaces Trazadas a Requisitos (`0` Huérfanas)

| # | Elemento OO en `A2`/`A3` | Tipo | Requisitos que atiende | Componente en `A5` |
| :- | :--- | :---: | :--- | :--- |
| `1` | `Persona` (`{abstract}`) | Clase | `RF-07`, `RF-12`, `RNF-05` | `NucleoIdentidadAcceso` |
| `2` | `Cliente` | Clase | `RF-05`, `RF-06`, `RF-07`, `RF-09`, `RF-10` | `NucleoIdentidadAcceso` |
| `3` | `Administrador` | Clase | `RF-07`, `RF-11`, `RNF-05` | `NucleoIdentidadAcceso` |
| `4` | `Categoria` | Clase | `RF-01`, `RF-02` | `NucleoPedidosCotizaciones` |
| `5` | `Producto` | Clase | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RF-11` | `NucleoPedidosCotizaciones` |
| `6` | `CarritoCompra` | Clase | `RF-04`, `RF-05`, `RNF-06` | `WebCatalogoPWA` |
| `7` | `Pedido` | Clase | `RF-05`, `RF-11` | `NucleoPedidosCotizaciones` |
| `8` | `DetallePedido` | Clase | `RF-05`, `RF-11` | `NucleoPedidosCotizaciones` |
| `9` | `Cotizacion` | Clase | `RF-06`, `RF-11` | `NucleoPedidosCotizaciones` |
| `10` | `DetalleCotizacion` | Clase | `RF-06`, `RF-11` | `NucleoPedidosCotizaciones` |
| `11` | `Notificacion` | Clase | `RF-05`, `RF-09`, `RF-12` | `NucleoNotificacionesExport` |
| `12` | `SolicitudServicio` | Clase | `RF-09`, `RF-11` | `NucleoServicioRenting` |
| `13` | `ReporteContador` | Clase | `RF-10`, `RF-11` | `NucleoServicioRenting` |
| `14` | `MensajeContacto` | Clase | `RF-08`, `RF-11` | `NucleoServicioRenting` |
| `15` | `ExportadorCsvSeguro` | Clase | `RF-11`, `RNF-05` | `NucleoNotificacionesExport` |
| `16` | `IRepositorioComercial` | Interfaz | `RF-02`–`RF-12`, `RNF-08` | `AdaptadorPersistenciaSQL` |
| `17` | `DespachadorComandos` | Clase GoF | `RF-05`, `RF-06`, `RF-09`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `18` | `IComandoOperacion` | Interfaz GoF | `RF-05`, `RF-06`, `RF-09`, `RNF-08` | `NucleoPedidosCotizaciones` |
| `19` | `ComandoConfirmarPedido` | Clase GoF | `RF-05`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `20` | `ComandoEmitirCotizacion` | Clase GoF | `RF-06`, `RNF-05` | `NucleoPedidosCotizaciones` |
| `21` | `ComandoRadicarSolicitud` | Clase GoF | `RF-09`, `RNF-06` | `NucleoServicioRenting` |
| `22` | `IFabricaEntregaComercial` | Interfaz GoF | `RF-05`, `RF-06`, `RF-12` | `NucleoPedidosCotizaciones` |
| `23` | `FabricaEntregaPedido` | Clase GoF | `RF-05`, `RF-12` | `NucleoPedidosCotizaciones` |
| `24` | `FabricaEntregaCotizacion` | Clase GoF | `RF-06`, `RF-12` | `NucleoPedidosCotizaciones` |

---

## 3. Auditoría Cruzada Día 2 (`2026-11-28`): Componentes (`G2-P1`) ↔ Tablas y Políticas `POL-*` (`G2-P2`)

> Cierre del hallazgo **`H-04`** (verificado en [`07-lista-chequeo-verificacion.md`](../G2-P2-fotocopiadora-syp/07-lista-chequeo-verificacion.md)): cobertura verificada de **`12 / 12` tablas** y **`9 / 9` políticas `POL-*`** sin huérfanas.

| # | Componente (`A5`) | Tablas de `G2-P2` (`12`) que opera | Políticas `POL-*` (`G2-P2/06-politicas-seguridad-datos.md`) aplicadas |
| :- | :--- | :--- | :--- |
| `1` | **`WebCatalogoPWA`** | `categoria`, `producto`, `compatibilidad_producto`, `pedido`, `cotizacion`, `solicitud_servicio`, `reporte_contador`, `mensaje_contacto`, `notificacion` | `POL-CON-02` (`TLS 1.3`), `POL-CON-03` (consentimiento Ley 1581 y `is_owner`), `POL-DIS-03` (respaldo PWA `dist/` + `localStorage` + WhatsApp). |
| `2` | **`PanelAdminWeb`** | `usuario`, `categoria`, `producto`, `pedido`, `cotizacion`, `solicitud_servicio`, `reporte_contador`, `mensaje_contacto`, `notificacion` | `POL-INT-02` (`activo = 0`), `POL-CON-01` (omisión de `clave_hash`), `POL-CON-02` (cookie `HttpOnly` `syp_session`), `POL-CON-03` (exportación CSV anti-fórmulas). |
| `3` | **`NucleoIdentidadAcceso`** | `usuario` | `POL-INT-02` (desactivación lógica), `POL-CON-01` (`BCrypt` hash+sal), `POL-CON-02` (`JWT HttpOnly`), `POL-CON-03` (titularidad `is_owner`). |
| `4` | **`NucleoPedidosCotizaciones`** | `categoria`, `producto`, `compatibilidad_producto`, `pedido`, `detalle_pedido`, `cotizacion`, `detalle_cotizacion` | `POL-INT-01` (`FK` + `CHECK`), `POL-INT-02` (anti-doble envío), `POL-INT-03` (recálculo de precios e IVA en servidor), `POL-CON-03` (`is_owner`). |
| `5` | **`NucleoServicioRenting`** | `solicitud_servicio`, `reporte_contador`, `mensaje_contacto` | `POL-INT-01` (`CHECK`), `POL-INT-02` (`UNIQUE uk_rep_usuario_eq_mes`), `POL-CON-03` (autorización Ley 1581 en formularios), `POL-DIS-03` (canal alterno WhatsApp). |
| `6` | **`NucleoNotificacionesExport`** | `notificacion`, `pedido`, `cotizacion`, `solicitud_servicio`, `reporte_contador` | `POL-INT-01` (`CASCADE` por usuario), `POL-CON-03` (`ExportadorCsvSeguro` neutraliza `=,+,-,@`). |
| `7` | **`AdaptadorPersistenciaSQL`** | **`12 / 12` tablas** (`usuario` a `mensaje_contacto`) | `POL-INT-01` (`12` FK con `ON DELETE` y `33` `CHECK`), `POL-DIS-01` (respaldo diario `02:00 a. m. AES-256`), `POL-DIS-02` (prueba mensual de restauración `RPO <= 24 h`, `RTO <= 2 h`). |

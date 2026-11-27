# B6 · Marco Contractual, Términos de Referencia (TdR) y Acuerdos de Nivel de Servicio (ANS) — Fotocopiadora SyP

> **Propósito:** Definir la estructura contractual completa (`14` elementos esenciales), los Términos de Referencia técnicos específicos (`TdR-01`–`TdR-08`) y los Acuerdos de Nivel de Servicio medibles (`ANS-01`–`ANS-04`) para la puesta en marcha y operación de la plataforma **Fotocopiadora SyP** bajo el **Escenario B provisional**, trazados 1:1 a los `7` nodos de [`03-diagrama-arquitectura-despliegue-g3.svg`](./03-diagrama-arquitectura-despliegue-g3.svg).

---

## 1. Elementos esenciales del contrato de desarrollo e implantación (`14` componentes)

| # | Elemento contractual | Contenido mínimo obligatorio para Fotocopiadora SyP | Documento / evidencia vinculada |
|---:|---|---|---|
| **1** | **Partes contratantes y objeto** | Identificación de **Fotocopiadora SyP** (Contratante) y del Contratista; objeto dirigido al diseño, construcción, despliegue e implantación del portal web e-commerce y sistema de servicio técnico con reporte mensual de contadores. | Propuesta técnica y económica `G3-P2` |
| **2** | **Alcance funcional y exclusiones explícitas** | Inclusión de los `12 RF` (`RF-01`–`RF-12`), `8 RNF` (`RNF-01`–`RNF-08`), `12` tablas en PostgreSQL 16 y pasarela configurable; exclusión de integraciones ERP contables no especificadas o suministro físico de hardware cliente (`[N1]` y `[N2]`). | [`00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) |
| **3** | **Propiedad intelectual y licenciamiento** | Cesión escrita de derechos patrimoniales sobre código fuente, scripts DDL, vistas, diagramas y manuales a favor del Contratante (`Ley 23/1982`, `Decisión Andina 351/1993`); cumplimiento de atribuciones permisivas (`MIT`/`BSD`/`Apache-2.0`). | [`04-dimensionamiento-licencias.md`](../G3-P1-fotocopiadora-syp/04-dimensionamiento-licencias.md) |
| **4** | **Cronograma e hitos de entrega verificables** | Fases de análisis/diseño, backend/BD, frontend/cotizador, pruebas integrales (`pytest` + `Playwright` + `node --check`), despliegue productivo y entrega documental contra actas de aceptación. | Plan de entregas e hitos de implementación |
| **5** | **Valor del contrato, impuestos y forma de pago** | Desglose de CAPEX/OPEX y honorarios dentro del tope presupuestal de referencia (**`$70.000.000 COP`** en Escenario B provisional), pagos sujetos a entrega y validación de hitos. | Presupuesto y cotizaciones (`B1`–`B4`, Día 2) |
| **6** | **Acuerdos de Nivel de Servicio (ANS)** | Compromisos cuantitativos de disponibilidad (`ANS-01`), latencia (`ANS-02`), respaldo (`ANS-03`) y atención de incidentes (`ANS-04`), con ventanas de mantenimiento programadas. | Sección 3 de este documento |
| **7** | **Protección de datos y confidencialidad (`Ley 1581/2012`)** | Cláusula de reserva confidencial, rol explícito del proveedor de infraestructura como **encargado** (contrato de **transmisión** bajo `Decreto 1074/2015`) y prohibición de uso comercial de datos de clientes SyP. | [`03-referente-tecnico-normativo.md`](../G3-P1-fotocopiadora-syp/03-referente-tecnico-normativo.md) |
| **8** | **Seguridad de la información y auditoría** | Cumplimiento de `TLS 1.3` en `[N3]`, `BCrypt`, `PyJWT` en cookie `HttpOnly` `syp_session` en `[N4]`, red privada `TCP 5432` en `[N5]`, respaldos cifrados `AES-256` en `[N6]` y auditoría técnica (`POL-INT/CON/DIS`). | [`06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/06-politicas-seguridad-datos.md) |
| **9** | **Garantía técnica y soporte post-implantación** | Periodo de garantía correctiva sobre defectos atribuibles al código entregado y opción de póliza de mantenimiento evolutivo posterior. | Matriz de severidad y tiempos ANS |
| **10** | **Capacitación y transferencia de conocimiento** | Sesiones prácticas de administración de catálogo, cotizaciones, órdenes de servicio técnico y lectura de contadores para personal de las `2` sedes + manuales de usuario y operación. | Guías operativas de cierre |
| **11** | **Gestión de control de cambios** | Procedimiento formal de solicitud, análisis de impacto técnico/presupuestal y aprobación escrita previa para requerimientos fuera del alcance base. | Formato de solicitud de cambio |
| **12** | **Obligaciones del Contratante y Contratista** | Suministro oportuno de catálogo real inicial y accesos de dominio por parte de SyP; entrega probada, limpia y documentada por parte del Contratista. | Lista de verificación `B5` |
| **13** | **Penalidades, créditos de servicio y fuerza mayor** | Esquema proporcional de créditos o remediación por incumplimiento reiterado de `ANS-01`..`ANS-04`, exceptuando fuerza mayor o fallas de terceros fuera de control razonable. | Tabla de créditos ANS |
| **14** | **Terminación, reversibilidad y solución de controversias** | Mecanismos de arreglo directo y entrega garantizada de código fuente, base de datos en formato estándar SQL/CSV y activos digitales al término del vínculo sin retención. | Cláusula de salida y portabilidad |

---

## 2. Términos de Referencia técnicos específicos (`TdR-01` – `TdR-08`)

| Código TdR | Título del requerimiento técnico | Especificación exigible al sistema Fotocopiadora SyP | Traza G1 / G2 / G3 |
|---|---|---|---|
| **`TdR-01`** | **Catálogo comercial, compatibilidad de insumos y carrito** | Publicación paginada (`12` ítems) de categorías y productos (equipos multifuncionales, tóneres, repuestos), relación M:N equipo-insumo (`compatibilidad_producto` con `ck_comp_distintos`), comparación lado a lado y carrito persistente (`precio_cop >= 0`, `estado_stock`, contingencia `localStorage`). | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RNF-01`, `RNF-04`, `RNF-06` \| `[N1]`, `[N3]`, `[N4]` |
| **`TdR-02`** | **Gestión transaccional de pedidos y pagos** | Registro atómico de `pedido` y `detalle_pedido` con snapshot de `precio_unitario_pactado`, recálculo exclusivo en servidor (`subtotal`, `iva`, `total >= subtotal` con `CHECK ck_ped_tot`), estados de pago/envío y bloqueo de doble envío. | `RF-05`, `POL-INT-03`, `Ley 1480/2011` \| `[N4]`, `[N5]` |
| **`TdR-03`** | **Motor de cotizaciones formales e imprimibles** | Generación y consulta de cotizaciones con código único (`codigo_cotizacion`), vigencia configurable (`vigencia_dias` `1..90` días), enmascaramiento de PII `is_owner` para no titulares y despacho mediante **Fábrica Abstracta** (`IFabricaEntregaComercial`). | `RF-06`, `POL-CON-03`, `Ley 527/1999` \| `[N4]`, `[N5]` |
| **`TdR-04`** | **Mesa de servicio técnico y reporte mensual de contadores** | Radicación de citas/diagnóstico técnico (`solicitud_servicio` con `codigo_seguimiento`) y reporte mensual único de contadores B/N y color por cliente autenticado (`reporte_contador`, `uk_rep_usuario_eq_mes`, `contador >= 0`). | `RF-09`, `RF-10`, `G2-P2` \| `[N1]`, `[N4]`, `[N5]` |
| **`TdR-05`** | **Contacto público, notificaciones y administración operativa** | Buzón de contacto (`mensaje_contacto`) y canal WhatsApp, entidad débil `notificacion` ligado a usuario, panel administrativo en `[N2]` y exportación CSV sanitizada (`ExportadorCsvSeguro`) contra inyección de fórmulas (`=,+,-,@`). | `RF-07`, `RF-08`, `RF-11`, `RF-12` \| `[N2]`, `[N4]`, `[N5]` |
| **`TdR-06`** | **Arquitectura Hexagonal y topología de despliegue de `7` nodos** | Núcleo OO de `24` elementos (`Comando` + `Fábrica Abstracta`, `7` componentes), BD `PostgreSQL 16` (`12` tablas `3FN`) y despliegue en nodos `[N1]`–`[N7]` sin vendor lock-in que impida portabilidad. | `G2-P1` Hexagonal \| `[N1]`–`[N7]` |
| **`TdR-07`** | **Controles de seguridad, privacidad y accesibilidad** | Tráfico exclusivo `HTTPS 443 TLS 1.3` en `[N3]`, `BCrypt`, sesiones JWT en cookie `HttpOnly` `syp_session` en `[N4]`, BD aislada en red privada `TCP 5432` `[N5]`, respaldos `AES-256` en `[N6]`, cumplimiento `Ley 1581/2012` y `WCAG 2.2 AA`. | `RNF-02`, `RNF-03`, `RNF-05`, `POL-CON-01..03` \| `[N3]`–`[N6]` |
| **`TdR-08`** | **Calidad, automatización de pruebas y localización `es-CO`** | Cobertura automatizada con `pytest` + `httpx`, E2E `Playwright`, verificación sintáctica `node --check`, localización `es-CO` / `COP` y entrega de manuales técnicos/usuario. | `RNF-07`, `RNF-08`, `A4` |

---

## 3. Acuerdos de Nivel de Servicio medibles (`ANS-01` – `ANS-04`)

| Código ANS | Indicador clave (KPI) | Escenario A (Base) | **Escenario B (Provisional)** | Escenario D (Enterprise) | Nodos implicados y mecanismo de medición (`[N1]`–`[N7]`) |
|---|---|---:|---:|---:|---|
| **`ANS-01`** | **Disponibilidad mensual operativa** | `99,0 %` (<= `7,3 h` caída/mes) | **`99,5 %`** (<= `3,6 h` caída/mes) | `99,9 %` (<= `43 min` caída/mes) | Sondeo `HTTPS` continuo cada `60 s` desde **`[N7]`** sobre **`[N3]`**, **`[N4]`** y **`[N5]`**. |
| **`ANS-02`** | **Latencia de respuesta API (`p95`)** | `<= 2,0 s` | **`<= 1,5 s`** | `<= 800 ms` | Percentil `95` en endpoints de catálogo, pedidos y cotizaciones medido sobre **`[N3]` → `[N4]`** por **`[N7]`**. |
| **`ANS-03`** | **Punto Objetivo de Recuperación (`RPO`)** | `<= 24 h` | **`<= 24 h`** (backup diario `02:00 COT`) | `<= 15 min` | Verificación automática de volcados diarios de **`[N5]`** cifrados con `AES-256` hacia **`[N6]`** (retención `30 d`). |
| **`ANS-04`** | **Atención de incidentes y recuperación (`RTO`)** | Primera respuesta `<= 1 h`; `RTO <= 8 h` | **Incidente `P1 <= 30 min`; `RTO <= 2 h`** | `P1 <= 15 min`; `RTO <= 30 min` | Alertas tempranas de **`[N7]`** + prueba mensual de restauración desde **`[N6]`** hacia **`[N5]`** y **`[N4]`**. |

### Niveles de severidad de incidentes asociados a `ANS-04`

| Prioridad | Definición operativa en Fotocopiadora SyP | Tiempo máx. primera respuesta (Escenario B) | Objetivo de mitigación / restauración |
|---|---|---:|---:|
| **`P1` — Crítico** | Caída total de `[N3]` / `[N4]`, indisponibilidad de PostgreSQL `[N5]` o incidente de seguridad con exposición potencial de datos. | **`<= 30 min`** | **`<= 2 h` (`RTO`)** |
| **`P2` — Alto** | Falla en módulo crítico en `[N4]` (pedidos, cotizaciones o reporte de contadores) con el resto del portal operativo. | `<= 2 h` | `<= 6 h` |
| **`P3` — Medio** | Degradación parcial no bloqueante, errores cosméticos responsivos o fallas menores no críticas en vistas PWA. | `<= 8 h` hábiles | Próximo mantenimiento programado (`<= 48 h`) |

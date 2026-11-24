# B3 · Propuesta Técnica y Económica — Versión `1.0` (`asistencia-sena`)

**Código de documento:** `PROP-ASIS-SENA-2026-v1.0` · **Estado:** Emitida para validación con contraparte (`B4` / `B5`)  
**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Proponente / Autor:** `@andressalinasvargas` · Ficha `3413974`  
**Fecha de emisión:** `2026-11-24` · **Vigencia de la oferta:** `30` días calendario (`hasta 2026-12-24`)  
**Escenario parametrizado:** **Variante B (Provisional)** — `120` usuarios totales, `30` concurrentes pico, `2` sedes físicas, disponibilidad mensual `≥ 99,5 %`, tope presupuestal Año 1 con IVA `$70.000.000 COP`.

---

## 1. Resumen Ejecutivo

El presente documento formula la propuesta técnica y económica integral (`v1.0`) para diseñar, desarrollar, desplegar, dotar con lectores ópticos QR y operar durante `12` meses (con proyección TCO a `36` meses) el **Sistema Web de Control de Asistencia Institucional (`asistencia-sena`)** bajo las condiciones de la **Variante B provisional** (`120` usuarios activos, `30` concurrentes en hora pico, `2` sedes de formación y disponibilidad mínima mensual del `99,5 %`).

La solución sustituye el registro manual en planillas físicas y hojas de cálculo aisladas por una aplicación web en tres capas (`PHP 8.3` POO + `MariaDB 10.11` 3FN) desplegada en contenedores `Docker` detrás de un proxy inverso `TLS 1.3`, con cuatro canales complementarios de registro —**código QR rotativo en aula, código numérico de `6` dígitos, lector óptico 2D USB con base en recepción y contingencia manual trazable**—, integrando validación de geocerca por fórmula Haversine (`≤ 100 m` de precisión en radio `300 m`) y consentimiento expreso exigido por la **Ley 1581 de 2012**.

- **Plazo de implementación hasta paso a producción:** `40` días hábiles (`8` semanas calendario), distribuidos en `12` actividades (`T01`–`T12`) y `4` hitos de verificación (`H1`–`H4`).
- **Inversión Año 1 (Costo Base con Contingencia e IVA `19 %`):** **`$53.520.250 COP`**.
- **Precio de Venta Total del Contrato (incluyendo margen `18 %` sobre precio e IVA `19 %`):** **`$65.268.598 COP`**, valor **inferior en `$4.731.402 COP`** al tope presupuestal de la Variante B (`$70.000.000 COP`).
- **TCO proyectado a `36` meses (Costo base de propiedad e operación 3 años con IVA):** **`$67.883.550 COP`**.
- **Niveles de servicio garantizados (`ANS`):** disponibilidad `≥ 99,5 %`, latencia `p95 ≤ 2,0 s`, copias diarias cifradas en S3 externo (`RPO ≤ 24 h`) y recuperación ante incidentes críticos (`P1 ≤ 30 min`, `RTO ≤ 2 h`).

---

## 2. Entendimiento de la Necesidad y Diagnóstico del Problema

A partir de la caracterización del dominio realizada en [`G1-P1`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/README.md) y la especificación de requisitos [`G1-P2`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/README.md), la gestión actual de asistencia en centros de formación enfrenta cinco cuellos de botella críticos:

1. **Pérdida de tiempo lectivo y congestión al inicio de jornada:** El llamado de lista tradicional consume entre `8` y `15` minutos efectivos en grupos de `30` aprendices y genera filas en accesos físicos.
2. **Vulnerabilidad a suplantación y registros duplicados:** La firma en planillas de papel permite registrar a terceros ausentes o duplicar anotaciones sin marca de tiempo confiable ni verificación física en sede.
3. **Retraso y error humano en consolidación de reportes:** La digitación posterior en hojas de cálculo locales provoca inconsistencias al calcular tardanzas (`> 15 min` según tolerancia configurada) y retrasa la generación de alertas tempranas de deserción.
4. **Riesgo de incumplimiento en tratamiento de datos personales y ubicación:** Capturar ubicación o datos académicos sin autorización previa, sin bitácora de consentimiento ni aislamiento de red expone a la institución a sanciones bajo la Ley 1581 de 2012 y el Decreto 1074 de 2015.
5. **Dependencia crítica de conectividad móvil única:** Si un aprendiz carece de cámara funcional o presenta intermitencia celular momentánea, un sistema sin canal alterno paraliza la entrada a clase.

La solución `asistencia-sena` resuelve de raíz estas cinco problemáticas automatizando el registro en `< 2 s` por transacción, impidiendo duplicados a nivel de motor relacional (`uk_reg_aprendiz_sesion`), registrando evidencia de geocerca y consentimiento con integridad referencial (`MariaDB InnoDB`) y ofreciendo canales alternos (lector USB 2D en recepción y código `6` dígitos / contingencia con novedad auditada).

---

## 3. Alcance del Proyecto (Inclusiones, Exclusiones y Supuestos)

### 3.1. Inclusiones (`Dentro del alcance`)

1. **Desarrollo, personalización y endurecimiento de la aplicación `asistencia-sena` (`FT-SW-01`):** Implementación completa de los `12` requisitos funcionales (`RF-01` a `RF-12`) y `6` requisitos no funcionales (`RNF-01` a `RNF-06`) en arquitectura 3 capas PHP 8.3 POO + MariaDB 10.11 (`10` tablas en 3FN), incluyendo auto-alojamiento de `qrcode.min.js` (`G3-P1/A4`), protección `.htaccess` (`HTTP 403`), sesiones `HttpOnly` y exportación CSV UTF-8.
2. **Infraestructura productiva gestionada por Año 1 (`FT-SW-02` + `FT-INF-01`):** Aprovisionamiento en **DigitalOcean** (`4 vCPU`, `8 GiB RAM`, `160 GB NVMe`, región US-East) para borde proxy TLS `1.3` (`[N3]`), servidor de aplicaciones Docker (`[N4]`) y motor de base de datos (`[N5]`), más bucket externo compatible S3 `250 GB` (`[N6]`), dominio institucional DNS (`1` año) y monitoreo externo `24/7` (`[N7]`).
3. **Dotación de hardware periférico de lectura (`FT-HW-02`):** Suministro, configuración Plug & Play y prueba en sitio de **`2` lectores ópticos QR 2D USB con base manos libres (Zebra DS2208-SR)** y `2` kits de cable USB blindado con regleta supresora (`1` conjunto por sede en Variante B).
4. **Aseguramiento de calidad automatizado (`M09`):** Ejecución de suite completa de pruebas E2E (`Playwright`), pruebas de carga de `30` usuarios concurrentes (`p95 ≤ 2,0 s`), verificación de integridad SQL negativa (`SQLSTATE 23000`) y prueba de restauración desde respaldos S3.
5. **Capacitación, manuales y soporte (`TdR-08` + `ANS`):** Capacitación de `16` horas en total (`8 h × 2 sedes`), entrega de manual técnico, manual de usuario/instructor y servicio de soporte + monitoreo por `12` meses con garantía de defectos de código por `6` meses.

### 3.2. Exclusiones (`Fuera del alcance`)

Para evitar ambigüedades contractuales y en trazabilidad directa con [`03-diagrama-arquitectura-despliegue-g3.svg`](03-diagrama-arquitectura-despliegue-g3.svg) y [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx), se excluyen explícitamente:

- **Estaciones de escritorio cliente (`[N1]`):** Computadores de instructores, coordinadores y puestos de portería (hardware existente del contratante).
- **Teléfonos inteligentes de aprendices (`[N2]`):** Dispositivos personales bajo esquema `BYOD`; para aprendices sin teléfono o batería se contempla el uso del lector QR en puesto o contingencia manual del instructor.
- **Infraestructura física local de red y energía:** Cableado estructurado, puntos de acceso Wi-Fi en aulas y plantas eléctricas UPS de las sedes.
- **Integraciones no solicitadas:** Conexión automática en tiempo real vía API con sistemas externos de nómina o Sofía Plus (intercambio previsto mediante exportación estándar CSV `RF-10`).

### 3.3. Supuestos Operativos y Financieros

1. Se adopta la **Variante B** de forma provisional (`120` usuarios, `30` concurrentes, `2` sedes, `99,5 %`); si el instructor confirma otra variante (`A`, `C` o `D`), el presupuesto `.xlsx` recalcula automáticamente cantidades de hardware, nodos y cumplimiento de tope.
2. El contratante designa un responsable técnico funcional para probar el piloto (`T11`), validar la propuesta (`B5`) y suministrar datos maestros iniciales de sedes, fichas e instructores sin datos personales reales sensibles en ambientes públicos de demostración.
3. Valores de infraestructura nube en dólares estadounidenses se estiman a **TRM de referencia `$4.000 COP/USD`**; el **IVA del `19 %`** se aplica al total consolidado conforme al Anexo D.

---

## 4. Solución Propuesta y Arquitectura de Despliegue (`[N1]`–`[N7]`)

La solución evoluciona la arquitectura multicapa y de despliegue definida en `G2-P1` hacia una topología productiva aislada de **`7` nodos identificables (`N1` a `N7`)**, documentada en el diagrama ajustado de esta entrega:

> **Diagrama oficial de arquitectura y despliegue (`B3`):** [03-diagrama-arquitectura-despliegue-g3.svg](03-diagrama-arquitectura-despliegue-g3.svg) · Fuente editable: [03-diagrama-arquitectura-despliegue-g3.drawio](03-diagrama-arquitectura-despliegue-g3.drawio)

### 4.1. Descripción de Nodos y Trazabilidad `1:1` con el Presupuesto (`B2`)

| ID Nodo | Nombre del nodo en el diagrama | Protocolo / Tecnología | Rol funcional y de seguridad | Vínculo exacto en `02-presupuesto-proyecto.xlsx` |
| :- | :--- | :--- | :--- | :--- |
| **`[N1]`** | **Cliente Escritorio** (`WebAppInstructor`) + Periférico QR | Navegador Web `HTTPS 443` + USB HID | Panel de instructor/coordinador, proyección de QR rotativo y lectura en recepción con escáner USB 2D. | **PC escritorio EXCLUIDO** (`P07 = $0`). **Periféricos QR (`P05`, `P06`) y Capacitación (`P13`) INCLUIDOS**. |
| **`[N2]`** | **Cliente Móvil** (`WebAppAprendiz`) | Navegador Móvil `HTTPS 443` (`≥ 390 px`) | Escaneo/ingreso de código `6d`, consentimiento Ley 1581 y captura de geocerca HTML5. | **Teléfono BYOD EXCLUIDO** (`P08 = $0`). Soporte UX móvil incluido en `P01`. |
| **`[N3]`** | **Borde DNS + Proxy Inverso TLS** | `DNS + Nginx/Caddy (TLS 1.3)` | Terminación TLS obligatoria para `Geolocation API`/`Camera`, redirección `HTTP->HTTPS` y limitación de tasa. | **Dominio DNS (`P11`)** + configuración en `P01`/`P03`. |
| **`[N4]`** | **Servidor Aplicación (`Docker`)** | `PHP 8.3 + Apache 2.4` | Lógica de negocio POO (patrones **Estrategia** para modos de registro y **Fachada** para auditoría/asistencia) + `qrcode.min.js` local. | **VPS DigitalOcean (`P09`)** compartido con N5 + desarrollo `P01` + código propio `P04`. |
| **`[N5]`** | **Servidor Datos (`MariaDB 10.11`)** | `TCP 3306` en red Docker privada | `10` tablas normalizadas en 3FN (`InnoDB`), restricción `uk_reg_aprendiz_sesion` (`1` asistencia/sesión), sin acceso público. | **Alojado en VPS (`P09`)** en red puente privada + diseño/QA `P01`. |
| **`[N6]`** | **Respaldos Externos S3** | `HTTPS 443` + Cifrado `AES-256` | Almacenamiento de volcados diarios (`02:00 a. m.`) con retención `30` días para garantizar `RPO ≤ 24 h`. | **Spaces S3 250 GB (`P10`)**. |
| **`[N7]`** | **Monitoreo y Alertas ANS** | Sondeo `HTTPS` cada `60 s` | Medición independiente `24/7` de disponibilidad (`ANS-01`), tiempo de respuesta (`ANS-02`) y disparo de alertas `P1`. | **Monitor externo (`P12`)** + bolsa de soporte (`P14`). |

---

## 5. Especificaciones Técnicas, Selección de Proveedores y Marco Normativo

1. **Fichas Técnicas Verificables (`G3-P1/A2`):** Todos los requisitos de capacidad, compatibilidad y pruebas de aceptación se rigen por las cuatro fichas neutrales definidas en [02-fichas-tecnicas.md](../G3-P1-asistencia-sena/02-fichas-tecnicas.md): `FT-SW-01` (Aplicación propia), `FT-SW-02` (Servicio Cloud VPS + S3 + Monitor), `FT-INF-01` (Nodo de cómputo `4 vCPU / 8 GiB / 160 GB NVMe`) y `FT-HW-02` (Lector Óptico QR 2D USB con base).
2. **Parámetros de Capacidad Calculados (`G3-P1/A5`):** Con base en [05-condiciones-tecnicas.md](../G3-P1-asistencia-sena/05-condiciones-tecnicas.md), el sistema soporta `U = 120` usuarios, pico `C = 30` concurrentes (diseño `2x` hasta `60 req/s`), consumo de BD proyectado a `36` meses de `~255 MB` (`160 GB NVMe` + `250 GB S3`), transferencia de `~5,9 GB/mes` (`≥ 2.000 GB` incluidos), ancho de banda pico `~38,4 Mbps` y latencia `p95 ≤ 2,0 s`.
3. **Proveedores Seleccionados (`B1`):** De acuerdo con la evaluación ponderada sobre `100 %` en [01-comparativo-proveedores.md](01-comparativo-proveedores.md), se selecciona **DigitalOcean** en Categoría 1 (`4,64 / 5,00`, TCO 36m `$8.865.000 sin IVA`, superando a AWS Lightsail `4,23` y Hetzner `3,57` por latencia US-East, previsibilidad tarifaria e integración unificada) y **Zebra DS2208-SR** en Categoría 2 (`4,75 / 5,00`, TCO 36m `$920.000 sin IVA` por `2` uds., superando a Honeywell `1470g` `4,53` y Datalogic `QD2590` `4,29`).
4. **Licenciamiento y Normativa (`G3-P1/A3` y `A4`):** Cero costo de licencias comerciales de producción (`Ubuntu`, `Docker CE`, `Apache 2.4`, `PHP 8.3`, `MariaDB 10.11`, `qrcode.min.js MIT`), inventario auditado en [04-dimensionamiento-licencias.md](../G3-P1-asistencia-sena/04-dimensionamiento-licencias.md), y cumplimiento estricto de **Ley 1581 de 2012 / Decreto 1074 de 2015**, **Ley 23 de 1982 / Decisión Andina 351**, **Ley 1273 de 2009** y **WCAG 2.2 AA**.

---

## 6. Metodología, Estructura de Desglose del Trabajo (EDT) y Ruta Crítica

El proyecto se ejecutará bajo un enfoque **iterativo e incremental (Scrum en `4` sprints de `2` semanas)** con demostraciones quincenales sobre entorno de pruebas y entrega continua trazable al repositorio Git.

### 6.1. EDT de `12` Tareas (`T01`–`T12`), Dependencias y Cálculo de Ruta Crítica (CPM)

Duración total: **`40` días hábiles (`8` semanas)**, jornada lunes a viernes (`5` días/semana). Tiempos expresados en días hábiles acumulados desde el día `0`:

| ID | Fase / Actividad de la EDT (trazable a `A6`) | Duración (días) | Predecesoras | ES | EF | LS | LF | Holgura (`LS-ES`) | ¿Ruta Crítica? | Responsable |
| :- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **`T01`** | Levantamiento definitivo, cierre de variante (`B`), alcance y diseño técnico (`M11`) | `4` | — | `0` | `4` | `0` | `4` | **`0`** | **Sí** | Líder Técnico |
| **`T02`** | Aprovisionamiento VPS DigitalOcean, DNS `.com/.co` y proxy TLS `[N3]` (`M10`) | `3` | `T01` | `4` | `7` | `19` | `22` | `15` | No | DevOps / Infra |
| **`T03`** | Despliegue MariaDB 3FN `[N5]` y módulos `M01` (Auth RBAC) + `M02` (Sedes/Aprendices) | `5` | `T01` | `4` | `9` | `4` | `9` | **`0`** | **Sí** | Dev Backend/BD |
| **`T04`** | Desarrollo módulo `M03` (sesiones, token CSPRNG y código `6` dígitos) | `5` | `T03` | `9` | `14` | `9` | `14` | **`0`** | **Sí** | Dev Full-Stack |
| **`T05`** | Desarrollo módulos `M04` + `M05` (autorregistro móvil Ley 1581 y geocerca Haversine) | `7` | `T04` | `14` | `21` | `14` | `21` | **`0`** | **Sí** | Dev Full-Stack |
| **`T06`** | Desarrollo módulo `M06` (estrategias escáner QR 2D y contingencia manual novedades) | `6` | `T04` | `14` | `20` | `15` | `21` | `1` | No | Dev Frontend/PHP |
| **`T07`** | Desarrollo módulos `M07` + `M08` (tardanzas, CSV, `qrcode.min.js` local y `.htaccess`) | `5` | `T05, T06` | `21` | `26` | `21` | `26` | **`0`** | **Sí** | Dev Backend/Seg |
| **`T08`** | Configuración respaldos diarios S3 `AES-256` `[N6]` y monitor HTTP `[N7]` (`M10`) | `4` | `T02, T03` | `9` | `13` | `22` | `26` | `13` | No | DevOps / Admin BD |
| **`T09`** | Compra, calibración USB HID y entrega de `2` lectores Zebra DS2208 (`FT-HW-02`) | `4` | `T01` | `4` | `8` | `22` | `26` | `18` | No | Soporte Hardware |
| **`T10`** | Suite E2E Playwright (`M09`), pruebas de carga (`30` conc.), lectores y simulacro S3 | `5` | `T07, T08, T09` | `26` | `31` | `26` | `31` | **`0`** | **Sí** | Especialista QA |
| **`T11`** | Piloto controlado en `2` sedes, capacitación (`16 h`, `TdR-08`) y ajustes finales | `5` | `T10` | `31` | `36` | `31` | `36` | **`0`** | **Sí** | Líder + Soporte |
| **`T12`** | Puesta en producción oficial, entrega de manuales/código y firma acta de cierre | `4` | `T11` | `36` | `40` | `36` | `40` | **`0`** | **Sí** | Líder Técnico |

- **Ruta Crítica Calculada (`Holgura = 0`):** **`T01 -> T03 -> T04 -> T05 -> T07 -> T10 -> T11 -> T12`** (`4 + 5 + 5 + 7 + 5 + 5 + 5 + 4 = 40 días hábiles`). Cualquier retraso en estas `8` actividades desplaza la fecha de salida a producción; `T02`, `T06`, `T08` y `T09` corren en paralelo aprovechando sus holguras (`1` a `18` días).

### 6.2. Hitos de Control y Aprobación (`H1`–`H4`)

| Hito | Semana / Día hábil | Entregables verificables de entrada/salida | Criterio de aprobación |
| :- | :---: | :--- | :--- |
| **`H1`** | Final Sem. `2` (Día `9`) | Esquema MariaDB 3FN desplegado, `M01`/`M02` operativos y ambiente base | Acta de arranque técnico y validación de estructura (`Pago 1: 30 %`). |
| **`H2`** | Inicio Sem. `6` (Día `26`) | Código funcional completo (`M01`–`M08`), respaldos `[N6]`/`[N7]` y `2` lectores QR entregados (`T09`) | Demostración integral en pruebas + acta de entrega de hardware (`Pago 2: 40 %`). |
| **`H3`** | Inicio Sem. `8` (Día `36`) | Suite Playwright `100 %` aprobada (`T10`) + capacitación `2` sedes completada (`T11`) | Listado de asistencia a capacitación y acta de piloto sin bloqueantes. |
| **`H4`** | Cierre Sem. `8` (Día `40`) | Despliegue en producción `HTTPS`, manuales técnicos/usuario, DNDA y código fuente | Acta final de recibo a satisfacción + inicio `ANS 12 meses` (`Pago 3: 30 %`). |

---

## 7. Equipo de Trabajo y Responsabilidades

| Rol en el proyecto | Perfil mínimo y dedicación en el proyecto | Responsabilidades principales |
| :--- | :--- | :--- |
| **Líder Técnico / Arquitecto** | Ingeniero de Sistemas / Tecnólogo ADSO senior (`M10`/`M11`) | Gobierno técnico, cierre de alcance, control de cambios, arquitectura `N1`–`N7` y actas `H1`–`H4`. |
| **Desarrollador Full-Stack PHP / BD** | Desarrollador PHP 8.3 POO y MariaDB (`M01`–`M08`) | Implementación limpia 3 capas, índices SQL, `qrcode.min.js` local, geocerca y reportes CSV. |
| **Especialista QA & Automatización** | Analista QA con `Playwright` (`M09`) | Suite E2E automatizada, pruebas de concurrencia `p95 ≤ 2,0 s` y pruebas negativas SQL/CSRF. |
| **DevOps / Soporte Infraestructura y HW** | Administrador Linux / Docker / Hardware (`12` meses soporte) | Hardening VPS, SSL/TLS, cron S3 `AES-256`, alistamiento Zebra DS2208, capacitación y atención ANS. |
| **Contraparte del Contratante (Cliente)** | Coordinador académico / TI institucional (designado por SENA) | Confirmación de variante, validación `B5`, apertura DNS subdominio, logística de sedes y firmas `H1`–`H4`. |

---

## 8. Costos, Presupuesto Detallado y Flujo a `36` Meses (`B2`)

Todas las cifras provienen directamente de las fórmulas vivas del libro [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx) bajo las convenciones del **Anexo D** (precios unitarios en `COP sin IVA`, `Subtotal -> Contingencia -> IVA 19 % -> Margen 18 % sobre precio`, `TRM $4.000/USD`).

### 8.1. Resumen Presupuestal Año `1` (`6` Categorías Obligatorias — Variante B Provisional)

| Categoría presupuestal (`B2`) | Clasificación (`D/I` · `SW/HW` · `U/R`) | Nodos del diagrama | Costo Año 1 (COP sin IVA) |
| :--- | :--- | :--- | :---: |
| **1. Talento Humano** (`350 h` directas + `40 h` gestión = `390 h`) | Directo `$29.860.000` · Indirecto `$3.400.000` · SW · Único | `[N3]`, `[N4]`, `[N5]`, `[N6]`, Transversal | `$33.260.000` |
| **2. Licencias y Auditoría Legal** (`OSS $0` + auditoría/DNDA) | Indirecto `$480.000` (`OSS Directo $0`) · SW · Único/Rec. | `[N3]`, `[N4]`, `[N5]`, Código propio | `$480.000` |
| **3. Hardware e Infraestructura** (`2` Zebra DS2208 + `2` kits cable/regleta; `[N1]`/`[N2]` excluidos `$0`) | Directo · Hardware · Único | Periférico `[N1]` en `2` sedes *(N1/N2 `$0` excl.)* | `$1.000.000` |
| **4. Nube y Operación** (DigitalOcean VPS `4vCPU/8GB`, S3 `250 GB`, Dominio, Monitor) | Directo `$2.619.000` · Indirecto `$336.000` · SW · Recurrente | `[N3]`, `[N4]`, `[N5]`, `[N6]`, `[N7]` | `$2.955.000` |
| **5. Capacitación y Soporte** (Capacitación `2` sedes + Bolsa soporte `12` meses) | Directo `$1.280.000` · Indirecto `$3.000.000` · SW · Mixto | `[N1]`, `[N4]`, `[N5]`, `[N6]`, `[N7]` | `$4.280.000` |
| **Subtotal Categorías 1 a 5 (sin IVA ni contingencia)** | **Directo `$35.095.000` · Indirecto `$6.880.000` · SW `$40.975.000` · HW `$1.000.000`** | **100 % trazable `N1`–`N7`** | **`$41.975.000`** |
| **6. Reserva de Contingencia** (`SUMIF` de riesgos `R1`–`R6`, `7,15 %` del subtotal) | Gestión de riesgos (`5 %–15 %` saludable) | Transversal | **`$3.000.000`** |
| **Base Gravable con Contingencia (`Subtotal + Contingencia`)** | — | — | **`$44.975.000`** |
| **IVA (`19 %` sobre Base con Contingencia)** | Régimen tributario Colombia (`Anexo D`) | — | **`$8.545.250`** |
| **Costo Total Año 1 del Proyecto (con Contingencia e IVA)** | Costo real estimado de ejecución | — | **`$53.520.250`** |
| **Precio de Venta sin IVA** (`Margen 18 % sobre precio = Base / (1 - 0,18)`) | Precio comercial neto antes de IVA | — | **`$54.847.561`** |
| **Precio de Venta Total del Contrato (con IVA `19 %`)** (`= Costo_con_IVA / (1 - 0,18)`) | **Valor ofertado en propuesta `B3`** | **Tope Variante B: `$70.000.000`** | **`$65.268.598`** |
| **Estado vs. Tope Variante B (`$70.000.000 COP`)** | Holgura disponible: **`$4.731.402 COP`** | — | **`CUMPLE TOPE`** |

### 8.2. Flujo Financiero y Costo Total de Propiedad (TCO) a `36` Meses

| Concepto (`02-presupuesto-proyecto.xlsx!4_Flujo_36_Meses`) | Año 1 (Implantación + Operación) | Año 2 (Operación) | Año 3 (Operación + Mto HW) | Total `36` Meses |
| :--- | :---: | :---: | :---: | :---: |
| **1. Talento Humano** (`M01`–`M11`) | `$33.260.000` | `$0` | `$0` | `$33.260.000` |
| **2. Licencias y Auditoría Legal** | `$480.000` | `$0` | `$0` | `$480.000` |
| **3. Hardware e Infraestructura Física** (`Mto Año 3: $80.000 × 2`) | `$1.000.000` | `$0` | `$160.000` | `$1.160.000` |
| **4. Nube y Operación** (DigitalOcean + S3 + Dominio + Monitor) | `$2.955.000` | `$2.955.000` | `$2.955.000` | `$8.865.000` |
| **5. Capacitación (`Año 1`) y Soporte Operativo (`Año 1–3`)** | `$4.280.000` | `$3.000.000` | `$3.000.000` | `$10.280.000` |
| **6. Reserva de Contingencia Cubierta** (`R1`–`R6`) | `$3.000.000` | `$0` | `$0` | `$3.000.000` |
| **Subtotal Base (sin IVA)** | **`$44.975.000`** | **`$5.955.000`** | **`$6.115.000`** | **`$57.045.000`** |
| **IVA (`19 %`)** | `$8.545.250` | `$1.131.450` | `$1.161.850` | `$10.838.550` |
| **Total con IVA (Costo TCO `36` Meses)** | **`$53.520.250`** | **`$7.086.450`** | **`$7.276.850`** | **`$67.883.550`** |

*(Nota: Los años `2` y `3` reflejan el costo operativo recurrente opcional de renovación de nube y bolsa de soporte en caso de que el contratante extienda el servicio tras el Año 1 incluido).*

---

## 9. Matriz de Riesgos, Valor Esperado y Reserva de Contingencia

En consistencia exacta con `02-presupuesto-proyecto.xlsx!2_Riesgos_Contingencia`, se analizan `7` riesgos reales (`R1`–`R7`); seis se respaldan financieramente (`$3.000.000`, equivalente al `7,15 %` del subtotal) y `R7` se mitiga funcionalmente dentro del alcance sin reserva monetaria:

| ID | Riesgo identificado | Causa raíz | Prob. | Impacto (COP) | Valor Esperado (`P × I`) | ¿Cubre reserva? | Estrategia de respuesta y mitigación | Responsable |
| :- | :--- | :--- | :---: | :---: | :---: | :---: | :--- | :--- |
| **`R1`** | Cambios de alcance en reglas de tardanza, reportes o geocerca tras validación `B5` | Ajustes solicitados por coordinación académica en pruebas piloto | `25,0 %` | `$3.200.000` | `$800.000` | **Sí** | Mitigar: control de cambios formal y horas de ajuste reservadas | Líder Técnico |
| **`R2`** | Retraso en provisión de subdominio institucional o apertura de puertos `HTTPS 443` | Trámites internos de TI institucional previos a puesta en producción | `30,0 %` | `$2.000.000` | `$600.000` | **Sí** | Mitigar: validación temprana en semana `2` (`T02`) y proxy temporal | DevOps / Cliente |
| **`R3`** | Variación cambiaria TRM (`+15 % USD/COP`) sobre servicios nube VPS, S3 y monitoreo | Volatilidad del dólar en renovaciones anuales/mensuales | `35,0 %` | `$800.000` | `$280.000` | **Sí** | Aceptar con reserva financiera cubierta para Año `1` | Gestión Financiera |
| **`R4`** | Desabastecimiento o falla temprana de lectores ópticos QR 2D en sedes | Demora logística de distribuidor o defecto de puerto USB en sede | `20,0 %` | `$1.100.000` | `$220.000` | **Sí** | Transferir (garantía `5` años) + reserva de reemplazo urgente | Soporte Hardware |
| **`R5`** | Incidente de corrupción lógica o restauración de emergencia en MariaDB `[N5]` | Falla operativa o actualización errónea durante ventana académica | `15,0 %` | `$4.000.000` | `$600.000` | **Sí** | Mitigar: respaldos S3 diarios cifrados `[N6]` + prueba mensual | Admin. BD |
| **`R6`** | Indisponibilidad temporal de técnico asignado a soporte en ventana crítica | Incapacidad o cruce de horarios durante soporte de Año `1` | `20,0 %` | `$2.500.000` | `$500.000` | **Sí** | Mitigar: documentación completa y respaldo cruzado de desarrolladores | Contratista |
| **`R7`** | Caída masiva de conectividad móvil de aprendices en el aula durante registro | Saturación de red celular o zonas sin cobertura en sede | `40,0 %` | `$1.500.000` | `$600.000` | **No** | Mitigar en alcance sin reserva: canal alterno código `6d` y contingencia manual | Instructor / App |
| **—** | **Totales Matriz de Riesgos** | `Valor Esperado total (R1–R7): $3.600.000` | — | — | **`$3.000.000`** *(cubierto `R1–R6`)* | `7,15 %` del Subtotal | La reserva de `$3.000.000` solo se ejecuta ante materialización documentada. | Comité Control |

---

## 10. Garantías, Soporte y Acuerdos de Nivel de Servicio (`ANS`)

La operación y el aseguramiento contractual se rigen íntegramente por [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md):

- **Garantía de software (`FT-SW-01`):** `6` meses sin costo adicional contados desde el acta final `H4` para corrección de errores funcionales o fallas de integridad imputables al código entregado.
- **Garantía de hardware (`FT-HW-02`):** `5` años de garantía de fabricante gestionada a través del proveedor nacional sobre los `2` lectores Zebra DS2208-SR.
- **Soporte técnico (`12` meses incluidos en Año 1):** Mantenimiento preventivo mensual, verificación mensual de restauración desde `[N6]` y atención de incidentes según severidad:
  - **`ANS-01` Disponibilidad mensual:** `≥ 99,5 %` *(máximo `3,6 h/mes` de caída no programada, medida cada `60 s` por `[N7]`)*.
  - **`ANS-02` Latencia de registro `p95`:** `≤ 2,0 s` bajo concurrencia de `30` usuarios simultáneos.
  - **`ANS-03` RPO (Pérdida máxima de datos):** `≤ 24 horas` mediante volcado diario cifrado `AES-256` en `[N6]`.
  - **`ANS-04` Respuesta inicial `P1` y RTO:** Respuesta `≤ 30 min` y recuperación completa `RTO ≤ 2 horas`.
- **Compensaciones por incumplimiento:** Créditos automáticos de servicio del `5 %` al `20 %` del canon mensual de soporte/operación según la escala definida en `06-contrato-tdr-ans.md` §3.

---

## 11. Condiciones Comerciales, Pagos, Propiedad Intelectual y Datos

### 11.1. Forma de Pago Vinculada a Hitos (`Valor Total Contrato: $65.268.598 COP IVA incluido`)

| Cuota | Porcentaje | Monto (COP con IVA) | Condición de exigibilidad y soporte de facturación |
| :- | :---: | :---: | :--- |
| **Pago `1` · Anticipo / Arranque y Hito `1`** | **`30 %`** | **`$19.580.579`** | Firma de contrato/orden de inicio y entrega aprobada de Hito `1` (Día `9`: BD 3FN `[N5]` y entorno TLS base `[N3]`). |
| **Pago `2` · Entrega en Pruebas y Hardware (`H2`)** | **`40 %`** | **`$26.107.439`** | Despliegue funcional integral en ambiente de pruebas (`M01`–`M08`), respaldos `[N6]`/`[N7]` activos y entrega física de `2` lectores Zebra DS2208 (`H2`). |
| **Pago `3` · Recibo a Satisfacción (`H4`)** | **`30 %`** | **`$19.580.580`** | Superación del `100 %` de pruebas E2E (`T10`), capacitación `2` sedes (`T11`), entrega de manuales/código fuente y firma del acta de cierre `H4`. |
| **TOTAL CONTRATO** | **`100 %`** | **`$65.268.598`** | Facturación dentro de los `30` días siguientes a cada acta aprobada. *(Nota: `$19.580.579 + $26.107.439 + $19.580.580 = $65.268.598` exactos).* |

### 11.2. Propiedad Intelectual y Protección de Datos Personales

- **Propiedad Intelectual (Ley 23 de 1982 y Decisión Andina 351 de 1993):** El proponente suscribe **cesión expresa y por escrito de derechos patrimoniales** sobre los módulos propios desarrollados (`FT-SW-01`) a favor del contratante una vez cancelado el `100 %` del contrato (`H4`), conservando únicamente los **derechos morales de autoría (`@andressalinasvargas`)**. Las librerías libres inventariadas en `04-dimensionamiento-licencias.md` conservan sus licencias originales (`PHP 3.01`, `Apache 2.0`, `MIT`).
- **Transmisión de Datos (Ley 1581 de 2012 y Decreto 1074 de 2015, Art. `2.2.2.25.5.2`):** La institución educativa actúa como **Responsable del Tratamiento** y el contratista actúa exclusivamente como **Encargado del Tratamiento** bajo contrato escrito de **transmisión** (sin transferencia o comercialización hacia terceros), restringido al control de asistencia académica y obligado a devolución/borrado certificado al terminar el servicio.

---

## 12. Vigencia, Control de Cambios (`v1.0 -> v1.1`) y Anexos de Soporte

- **Vigencia de la propuesta `v1.0`:** **`30` días calendario** contados desde el `2026-11-24` (sujeta a actualización cuantificada en **versión `1.1` (`B7`)** una vez se firme el acta de validación con contraparte real `B5` y el instructor confirme la variante oficial `A`, `B`, `C` o `D`).
- **Trazabilidad documental de anexos:**
  - `A2` Fichas técnicas neutrales: [`02-fichas-tecnicas.md`](../G3-P1-asistencia-sena/02-fichas-tecnicas.md)
  - `A3` Marco normativo: [`03-referente-tecnico-normativo.md`](../G3-P1-asistencia-sena/03-referente-tecnico-normativo.md)
  - `A4` Inventario y auditoría de licencias: [`04-dimensionamiento-licencias.md`](../G3-P1-asistencia-sena/04-dimensionamiento-licencias.md)
  - `A5` Condiciones técnicas de capacidad: [`05-condiciones-tecnicas.md`](../G3-P1-asistencia-sena/05-condiciones-tecnicas.md)
  - `A6` Estimación económica inicial: [`06-estimacion-economica.xlsx`](../G3-P1-asistencia-sena/06-estimacion-economica.xlsx) · [`06-estimacion-economica.md`](../G3-P1-asistencia-sena/06-estimacion-economica.md)
  - `B1` Comparativo de proveedores TCO 36m: [`01-comparativo-proveedores.md`](01-comparativo-proveedores.md)
  - `B2` Presupuesto definitivo `.xlsx`: [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx)
  - `B3` Diagrama de arquitectura/despliegue: [`03-diagrama-arquitectura-despliegue-g3.svg`](03-diagrama-arquitectura-despliegue-g3.svg)
  - `B6` Lista de verificación contractual, TdR y ANS: [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md)

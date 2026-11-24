# G3 · Propuesta técnica · README de entrega (Producto 2)

## 1. Identificación

| Campo | Valor |
| :--- | :--- |
| **Producto** | P2 · Propuesta técnica y validación (`RAP 593062` y `RAP 593061`) |
| **Usuario de GitHub del autor** | `@andressalinasvargas` |
| **Ficha** | `3413974` |
| **Variante del escenario asignada (A, B, C o D)** | **Variante B *(provisional hasta confirmación del instructor)***: `120` usuarios totales, `30` concurrentes pico, `2` sedes físicas, disponibilidad `≥ 99,5 %`, tope Año 1 **`$70.000.000 COP`**. El libro [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx) recalcula automáticamente cualquier cambio a `A`, `C` o `D` en `1_Parametros!B3`. *(Propuesta completa `B1`–`B7` en `v1.1` tras validación `B5` con `@Kevin81A`, sujeta únicamente a su confirmación escrita previa al `2026-12-05`)* |
| **Caso de estudio (nombre del proyecto de mi fork)** | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) |
| **Fecha de la última actualización** | `2026-11-24` |
| **Plazo de entrega** | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

---

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen en mi fork (ruta) | Cómo lo reutilicé |
| :--- | :--- | :--- |
| Diagrama de despliegue base (`B3`) | [`G2-P1-asistencia-sena/05-vista-despliegue.drawio`](../../../06-architecture/04-evidence-learning/G2-P1-asistencia-sena/05-vista-despliegue.drawio) y [`05-vista-despliegue.md`](../../../06-architecture/04-evidence-learning/G2-P1-asistencia-sena/05-vista-despliegue.md) | Evolucioné la vista de `4` nodos locales (`G2`) hacia `7` nodos productivos identificables (`N1`–`N7`) listos para ligarse 1:1 a la columna de trazabilidad del presupuesto `B2`. |
| Políticas de seguridad, respaldos y Ley 1581 (`B6`) | [`G2-P2-asistencia-sena/06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-asistencia-sena/06-politicas-seguridad-datos.md) y [`G3-P1-asistencia-sena/03-referente-tecnico-normativo.md`](../G3-P1-asistencia-sena/03-referente-tecnico-normativo.md) | Traduje los objetivos `RPO ≤ 24 h`, `RTO ≤ 2 h`, transmisión de datos y derechos patrimoniales en cláusulas verificables para contrato, TdR y ANS. |
| Plan de contingencia y socialización MVP (`B3` riesgos / `B4` — próximos commits) | [`03-execute/18-week/02-optional-activity/Plan de contingencia.png`](../../../../../../03-execute/18-week/02-optional-activity/Plan%20de%20contingencia.png) y [`03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md`](../../../../../../03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md) | Insumos base para la matriz de `≥ 6` riesgos con valor esperado y la presentación a la contraparte. |
| Presentación y hoja de ruta previa (`B4` — próximos commits) | [`03-execute/27-week/02-optional-activity/Validación_y_Despliegue_Sistema_de_Asistencia_SENA.pptx`](../../../../../../03-execute/27-week/02-optional-activity/Validaci%C3%B3n_y_Despliegue_Sistema_de_Asistencia_SENA.pptx) | Base visual para construir la presentación de negociación (`B4`) enfocada en el interés del cliente. |

---

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué (necesidad del caso o criterio de la rúbrica) |
| :--- | :--- | :--- |
| **B1. Análisis comparativo de proveedores** | Construí el comparativo en `2` categorías (`Nube FT-SW-02` y `Lectores QR 2D FT-HW-02`) con `3` alternativas reales por categoría, pesos exactos al `100 %`, normalización TRM `$4.000` sin IVA y TCO `36` meses seleccionando DigitalOcean y Zebra DS2208-SR. | Cumple `C1` de `Rubricas_G3.md` y alimenta directamente la hoja `5_Comparativo_TCO` de `B2` explicando el descarte técnico-económico de las demás opciones. |
| **B2. Presupuesto con fórmulas `.xlsx` (`v1.1`)** | Construí [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx) en `5` hojas con fórmulas vivas (`=INDEX/MATCH`, `=SUM`, `=SUMIF`, `=IF`), trazabilidad `1:1` a nodos `N1`–`N7` (exclusiones `$0`), matriz de `7` riesgos con reserva (`$2.640.000`, `6,2 %`), `IVA 19 %`, margen `15 %` sobre precio ajustado en `B5` (`$63.679.000` vs. tope `$70.000.000`) y flujo `36` meses (`TCO $68.490.450`). | Cumple `C2` y el orden estricto del `Anexo D`, reflejando al peso los ajustes `AJ-01`, `AJ-02` y `AJ-03` de validación. |
| **Diagrama de arquitectura y despliegue (`B3`)** | Ajusté el diagrama de `G2-P1/A6` (`4` nodos) añadiendo `[N3]` Borde DNS/Proxy TLS, `[N6]` Respaldos externos S3 cifrados y `[N7]` Monitoreo externo ANS, etiquetando cada nodo con su vínculo o exclusión en el presupuesto `B2`. | Cumple el requisito de diagrama propio ajustado en `B3` (`C3`) y garantiza trazabilidad 1:1 con los rubros de `B2` (`C2`). |
| **B3. Propuesta técnica y económica `v1.0`** | Redacté las `12` secciones ejecutivas, técnicas, comerciales y contractuales base en [`03-propuesta-tecnica-v1.0.md`](03-propuesta-tecnica-v1.0.md), integrando EDT de `12` tareas (`T01`–`T12`) con cálculo CPM (`40` días hábiles), `7` riesgos y pagos `30/40/30 %`. | Cumple `C3` de `Rubricas_G3.md` y permanece intacta como línea base previa a `v1.1`. |
| **B4. Presentación de negociación** | Elaboré `10` diapositivas orientadas al interés del cliente con guion de `10` minutos, declaración de propósito, posición ideal (`$65,27 M`), mínima (`$59,47 M`), MAAN y `4` objeciones respondidas en [`04-presentacion-negociacion.md`](04-presentacion-negociacion.md). | Cumple `C4` como insumo directo de la sesión de validación `B5`. |
| **B5. Acta de validación con contraparte** | Documenté [`05-acta-validacion.md`](05-acta-validacion.md) con `@Kevin81A` como contraparte (distinta del autor, pendiente de su confirmación escrita antes del `2026-12-05`), `5` sugerencias convertidas en requisitos (`2` aceptadas, `2` negociadas y **`1` rechazada con sustento técnico-legal** sobre `TdR-01`/Ley 1581/tope) y `3` ajustes cuantificados (`AJ-01`–`AJ-03`). | Cumple `C5` y `C6` integrando el puente cuantificado hacia `B2`, `B6`, `B7` y `G3-P1`. |
| **B6. Contrato, TdR y ANS (`v1.1`)** | Actualicé [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md) a `v1.1` con la lista contractual (`14` elementos, pagos `25/45/30 %`), TdR (`8` requisitos, `3` videocápsulas `SUG-04`) y `4` métricas ANS medibles fijando **`ANS-01 ≥ 99,5 %`**, **`ANS-02 p95 ≤ 1,5 s`** y **`ANS-03 RPO ≤ 12 h`**. | Cumple `C7` y la propagación exigida por `C6` en el ANS y condiciones contractuales. |
| **B7. Propuesta técnica ajustada `v1.1`** | Emití [`07-propuesta-tecnica-v1.1.md`](07-propuesta-tecnica-v1.1.md) con tabla explícita de **control de cambios `v1.0 → v1.1`** y las `12` secciones recalculadas (`41` días hábiles, `400 h`, `$63.679.000` IVA incl., holgura `$6.321.000`, `R1 20 %`, `R5 10 %`). | Cumple `C3` y `C6` cerrando el ciclo de validación sin incoherencias entre Producto 1 y Producto 2. |

---

## 4. Enlaces a los entregables (Producto 2)

- [x] **B1.** Análisis comparativo de proveedores (`2` categorías, `3` alternativas reales cada una, criterios `100 %`, TCO `36` meses): [01-comparativo-proveedores.md](01-comparativo-proveedores.md)
- [x] **B2.** Presupuesto de software y hardware `v1.1` (`.xlsx` con fórmulas vivas en `5` hojas, trazabilidad `N1`–`N7`, Anexo D y flujo `36` meses): [02-presupuesto-proyecto.xlsx](02-presupuesto-proyecto.xlsx)
- [x] **B3.** Propuesta técnica línea base `v1.0` (`12` secciones, EDT `12` tareas con ruta crítica `40` d, `7` riesgos): [03-propuesta-tecnica-v1.0.md](03-propuesta-tecnica-v1.0.md) · Diagrama: [03-diagrama-arquitectura-despliegue-g3.drawio](03-diagrama-arquitectura-despliegue-g3.drawio) · [03-diagrama-arquitectura-despliegue-g3.svg](03-diagrama-arquitectura-despliegue-g3.svg)
- [x] **B4.** Presentación a la contraparte (`10` diapositivas, guion `10` min, estrategia de negociación y `4` objeciones): [04-presentacion-negociacion.md](04-presentacion-negociacion.md)
- [x] **B5.** Acta de validación (`5` sugerencias clasificadas incl. `1` rechazada, `3` ajustes cuantificados `AJ-01`–`AJ-03`, fecha `2026-11-24`, contraparte `@Kevin81A` pendiente de confirmación escrita antes del `2026-12-05`): [05-acta-validacion.md](05-acta-validacion.md)
- [x] **B6.** Lista de verificación para contrato (`14` elementos), matriz de TdR (`8` requisitos) y ANS `v1.1` (`4` métricas medibles): [06-contrato-tdr-ans.md](06-contrato-tdr-ans.md)
- [x] **B7.** Propuesta ajustada versión `1.1` con tabla de control de cambios y cifras recalculadas: [07-propuesta-tecnica-v1.1.md](07-propuesta-tecnica-v1.1.md)

---

## 5. Autoevaluación de mínimos (`7/7` entregables completados — sujeto a confirmación escrita de `@Kevin81A` y confirmación de variante)

| Mínimo | Mi conteo actual |
| :--- | :--- |
| `[P2]` Alternativas por categoría / criterios que suman 100 % | `2` cat. × `3` alt. / **`sí` (`100 %`)** |
| `[P2]` Riesgos en la matriz (`≥ 6`) / tareas de la EDT (`≥ 10` con ruta crítica) | **`7`** / **`12`** *(ruta crítica `v1.1`: `41 d`)* |
| `[P2]` Contrato (`≥ 10` elementos) / TdR (`≥ 6`) / ANS (`≥ 3` métricas medibles) | **`14`** / **`8`** / **`4`** *(`≥ 99,5 %`, `p95 ≤ 1,5 s`, `RPO ≤ 12 h`, `RTO ≤ 2 h`)* |
| `[P2]` Sugerencias clasificadas (`≥ 4`) / ajustes de parámetros (`≥ 2`) | **`5`** *(incl. `1` rechazada)* / **`3`** *(`AJ-01`–`AJ-03` propagados en `P1/B2/B6/B7`)* |
| `[P2]` Fecha del acta de validación (anterior a la entrega) | **`2026-11-24`** *(anterior al `2026-12-05`; falta confirmación escrita de `@Kevin81A`)* |
| Mis hojas de cálculo usan fórmulas | **`sí`** (`02-presupuesto-proyecto.xlsx`: `INDEX/MATCH`, `SUM`, `SUMIF`, `IF`) |

---

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
| :--- | :--- | :--- |
| `2026-11-23` (Día 1 — Commit 1) | Evolucioné el diagrama de arquitectura/despliegue de `G2` a `7` nodos productivos (`N1`–`N7`) para `B3`/`B2`, redacté `06-contrato-tdr-ans.md` (`B6`) y creé el `README.md` inicial de `G3-P2`. | [`af106d1`](https://github.com/andressalinasvargas/ADSO-3413974/commit/af106d1) (`feat(g3-p2): crear diagrama de despliegue B3, marco contrato-TdR-ANS B6 y README inicial`) |
| `2026-11-24` (Día 2 — Commit 2) | Elaboré el comparativo de proveedores con TCO 36m (`B1`), el libro Excel presupuestal con fórmulas vivas (`B2`), la propuesta técnica `v1.0` de 12 secciones con EDT/CPM (`B3`), la presentación de negociación (`B4`) y actualicé el `README.md`. | [`f99c8a8`](https://github.com/andressalinasvargas/ADSO-3413974/commit/f99c8a8) (`feat(g3-p2): agregar comparativo B1, presupuesto Excel B2, propuesta v1.0 B3 y presentacion B4`) |
| `2026-11-24` (Día 2 — Commit 3 · Cierre `B5`/`B7`) | Redacté el acta de validación `B5` (`@Kevin81A`, `5` sugerencias incl. rechazo `SUG-05`, `3` ajustes `AJ-01`–`AJ-03`), propagué `v1.1` en `02-presupuesto-proyecto.xlsx` (`B2`), `06-contrato-tdr-ans.md` (`B6`) y emití `07-propuesta-tecnica-v1.1.md` (`B7`). | Commit 3 (`feat(g3-p2): agregar acta de validacion B5, propuesta v1.1 B7 y propagar ajustes en B2 y B6`) |

---

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
| :--- | :--- | :--- |
| Función Pública — Ley 1581 de 2012 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981`) y Decreto 1074 de 2015 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=76608`) | `2026-11-23` | Cláusula contractual de transmisión de datos y cumplimiento `TdR-03` en `B3`/`B6`. |
| Función Pública — Ley 23 de 1982 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431`) y WIPO Lex — Decisión 351 (`https://www.wipolex.wipo.int/es/text/169152`) | `2026-11-23` | Cláusula de cesión escrita de derechos patrimoniales y reserva de derechos morales en `B3`/`B6`. |
| DigitalOcean Pricing (`https://www.digitalocean.com/pricing/droplets`, `https://www.digitalocean.com/pricing/spaces-object-storage`), AWS Lightsail (`https://aws.amazon.com/lightsail/pricing/`), Hetzner (`https://www.hetzner.com/cloud`) | `2026-11-24` | Tarifas públicas de cómputo VPS y S3 para normalización TCO `36` meses en `B1` y `B2`. |
| Zebra DS2200 Series (`https://www.zebra.com/us/en/products/spec-sheets/scanners/general-purpose-scanners/ds2200-series.html`), Honeywell Voyager 1470g (`https://automation.honeywell.com/us/en/products/productivity-products/barcode-scanners/general-duty/voyager-1470g`), Datalogic QuickScan QD2500 (`https://www.datalogic.com/eng/retail-manufacturing-transportation-logistics-healthcare/general-purpose-handheld-scanners/quickscan-qd2500-pd-915.html`) | `2026-11-24` | Especificaciones técnicas y comparación de lectores QR 2D USB (`FT-HW-02`) en `B1`. |

---

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
| :--- | :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en estructuración de cláusulas contractuales, métricas ANS, diagramación `.drawio`/`.svg`, generación en Python (`openpyxl`) de `02-presupuesto-proyecto.xlsx` (`v1.0` y `v1.1`) y redacción estructurada de `B1`/`B3`/`B4`/`B5`/`B7`. | `01-comparativo-proveedores.md`, `02-presupuesto-proyecto.xlsx`, `03-propuesta-tecnica-v1.0.md`, `03-diagrama-arquitectura-despliegue-g3.*`, `04-presentacion-negociacion.md`, `05-acta-validacion.md`, `06-contrato-tdr-ans.md`, `07-propuesta-tecnica-v1.1.md` y `README.md`. | Verifiqué todas las fórmulas del `.xlsx` (`INDEX/MATCH`, `SUM`, `SUMIF`, `IF`) contra el Anexo D, validé aritméticamente `v1.1` (`$63.679.000`, `41` d CPM, `ANS-02 ≤ 1,5 s`, `ANS-03 ≤ 12 h`), comprobé `100 %` en `B1` y revisé ausencia de datos personales reales. |

---

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año en mi fork, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. Para la validación de la propuesta (`B5`) participa **`@Kevin81A`** como contraparte cliente distinta del autor *(acta registrada el `2026-11-24`, pendiente únicamente de su confirmación escrita antes del `2026-12-05 06:00 a. m.`)*.

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `@andressalinasvargas` · Fecha: `2026-11-24`

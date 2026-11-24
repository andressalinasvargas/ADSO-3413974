# G3 · Propuesta técnica · README de entrega (Producto 2)

## 1. Identificación

| Campo | Valor |
| :--- | :--- |
| **Producto** | P2 · Propuesta técnica y validación (`RAP 593062` y `RAP 593061`) |
| **Usuario de GitHub del autor** | `@andressalinasvargas` |
| **Ficha** | `3413974` |
| **Variante del escenario asignada (A, B, C o D)** | *Pendiente de asignación oficial por el instructor* *(Commit 1 establece la arquitectura de despliegue trazable a presupuesto `B3` y el marco contractual/TdR/ANS `B6`; los cálculos de proveedores `B1`, presupuesto `B2`, propuesta `B3`, presentación `B4`, acta de validación `B5` y `v1.1` `B7` se completarán en Commits 2 y 3 con la variante confirmada)* |
| **Caso de estudio (nombre del proyecto de mi fork)** | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) |
| **Fecha de la última actualización** | `2026-11-23` |
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
| **Diagrama de arquitectura y despliegue (`B3`)** | Ajusté el diagrama de `G2-P1/A6` (`4` nodos) añadiendo `[N3]` Borde DNS/Proxy TLS, `[N6]` Respaldos externos S3 cifrados y `[N7]` Monitoreo externo ANS, etiquetando cada nodo con su vínculo o exclusión en el presupuesto `B2`. | Cumple el requisito de diagrama propio ajustado en `B3` (`C3`) y garantiza trazabilidad 1:1 con los rubros de `B2` (`C2`). |
| **B6. Contrato, TdR y ANS** | Construí desde cero la lista de verificación contractual (`14` elementos), la matriz de cumplimiento de TdR (`8` requisitos) y el ANS con `4` métricas medibles (`disponibilidad`, `p95 ≤ 2,0 s`, `RPO ≤ 24 h`, `RTO ≤ 2 h`) con ventana, fuente de medición y compensaciones. | Cumple `C7` de `Rubricas_G3.md` al 100 % sin adjetivos vagos y con alineación a Ley 1581/2012, Decreto 1074/2015 y Ley 23/1982. |

---

## 4. Enlaces a los entregables (Producto 2)

- [ ] **B1.** Análisis comparativo de proveedores (`2` categorías, `3` alternativas reales cada una, TCO 36 meses): *Programado para Día 2 / Commit 2*
- [ ] **B2.** Presupuesto de software y hardware (hoja de cálculo `.xlsx` con fórmulas, trazabilidad a `N1`–`N7` y margen): *Programado para Día 2 / Commit 2*
- [ ] **B3.** Propuesta técnica (`12` secciones, `6`–`12` páginas, EDT con ruta crítica y `≥ 6` riesgos) versión `1.0` — **Diagrama ajustado ya listo:** [03-diagrama-arquitectura-despliegue-g3.drawio](03-diagrama-arquitectura-despliegue-g3.drawio) · [03-diagrama-arquitectura-despliegue-g3.svg](03-diagrama-arquitectura-despliegue-g3.svg)
- [ ] **B4.** Presentación a la contraparte (`8`–`12` diapositivas o guion de 10 min con propósito de negociación): *Programado para Día 2 / Commit 2*
- [ ] **B5.** Acta de validación con contraparte real (`≥ 4` sugerencias clasificadas y `≥ 2` ajustes cuantificados, fechada antes del 5 de dic): *Programado para Día 3 / Commit 3*
- [x] **B6.** Lista de verificación para contrato (`14` elementos), matriz de TdR (`8` requisitos) y ANS (`4` métricas medibles): [06-contrato-tdr-ans.md](06-contrato-tdr-ans.md)
- [ ] **B7.** Propuesta ajustada versión `1.1` con control de cambios: *Programado para Día 3 / Commit 3*

---

## 5. Autoevaluación de mínimos (estado en avance — Día 1)

| Mínimo | Mi conteo actual |
| :--- | :--- |
| `[P2]` Alternativas por categoría / criterios que suman 100 % | *Pendiente Día 2 (objetivo: `2` cat. × `3` alt. / `sí`)* |
| `[P2]` Riesgos en la matriz (`≥ 6`) / tareas de la EDT (`≥ 10` con ruta crítica) | *Pendiente Día 2* |
| `[P2]` Contrato (`≥ 10` elementos) / TdR (`≥ 6`) / ANS (`≥ 3` métricas medibles) | `14` / `8` / `4` |
| `[P2]` Sugerencias clasificadas (`≥ 4`) / ajustes de parámetros (`≥ 2`) | *Pendiente reunión de validación `B5`* |
| `[P2]` Fecha del acta de validación (anterior a la entrega) | *Pendiente (antes del `2026-12-05`)* |
| Mis hojas de cálculo usan fórmulas | *Pendiente `B2` (se construirá con fórmulas vivas)* |

---

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
| :--- | :--- | :--- |
| `2026-11-23` (Día 1 — Commit 1) | Evolucioné el diagrama de arquitectura/despliegue de `G2` a `7` nodos productivos (`N1`–`N7`) para `B3`/`B2`, redacté `06-contrato-tdr-ans.md` (`B6`) y creé el `README.md` de `G3-P2`. | Commit 1 (`feat(g3-p2): crear diagrama de despliegue B3, marco contrato-TdR-ANS B6 y README inicial`) |
| *Día 2 (programado)* | Elaborar comparativo de proveedores con cotizaciones verificadas (`B1`), presupuesto `.xlsx` (`B2`), propuesta técnica `v1.0` (`B3`) y presentación de negociación (`B4`). | Commit 2 (pendiente) |
| *Día 3 (programado)* | Realizar validación con contraparte real, documentar acta (`B5`), propagar ajustes a `B2`/`B6` y emitir propuesta ajustada `v1.1` (`B7`). | Commit 3 (pendiente) |

---

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
| :--- | :--- | :--- |
| Función Pública — Ley 1581 de 2012 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981`) y Decreto 1074 de 2015 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=76608`) | `2026-11-23` | Cláusula contractual de transmisión de datos y cumplimiento `TdR-03` en `B6`. |
| Función Pública — Ley 23 de 1982 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431`) y WIPO Lex — Decisión 351 (`https://www.wipolex.wipo.int/es/text/169152`) | `2026-11-23` | Cláusula de cesión escrita de derechos patrimoniales y reserva de derechos morales en `B6`. |

---

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
| :--- | :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en estructuración de cláusulas contractuales, métricas ANS, generación XML del diagrama `.drawio`/`.svg` evolucionado desde `G2-P1` y verificación contra `Rubricas_G3.md`. | `03-diagrama-arquitectura-despliegue-g3.*`, `06-contrato-tdr-ans.md` y `README.md`. | Revisé que el diagrama sea una evolución propia del de `G2-P1` con protocolos y nodos `N1`–`N7` trazables a `B2`, que las 4 métricas de ANS sean medibles sin adjetivos vagos y que no haya datos personales reales. |

---

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año en mi fork, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. Si trabajé con compañeros de equipo, lo indico aquí: nada (trabajo individual; la contraparte de validación en `B5` se identificará únicamente por su usuario de GitHub).

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `@andressalinasvargas` · Fecha: `2026-11-23`

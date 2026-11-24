# B6 · Lista de Verificación para el Contrato, Matriz de Términos de Referencia y ANS

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P2 · Propuesta técnica y validación (`RAP 593061`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23` · **Versión:** `1.0` *(base pre-validación; se ajustará con el acta `B5` en `v1.1`)*

---

## 1. Lista de Verificación de Información Necesaria para el Contrato (`14` Elementos Obligatorios)

Verifica que la propuesta técnica (`B3`) y el presupuesto (`B2`) contengan toda la información indispensable para redactar un contrato formal de desarrollo e implantación de software en Colombia:

| # | Elemento contractual obligatorio | Qué debe precisar el contrato | Sección de la propuesta (`B3` / `B2`) donde se cumple | ¿Cubierto? |
| :- | :--- | :--- | :--- | :---: |
| **1** | **Partes contratantes** | Identificación jurídica del Contratante (entidad educativa) y del Contratista (proveedor de TI), sin datos personales reales en el repositorio público. | `B3` §1 (Resumen ejecutivo) y §11 (Condiciones comerciales) | Sí |
| **2** | **Objeto del contrato** | Desarrollo, parametrización, pruebas E2E, despliegue en producción y puesta en marcha del sistema `asistencia-sena` con soporte por 12 meses. | `B3` §1 y §2 (Entendimiento de la necesidad) | Sí |
| **3** | **Alcance (inclusiones, exclusiones y supuestos)** | Detalle verificable de los `12` RF y `6` RNF incluidos; exclusión explícita de hardware de usuarios (`N1`/`N2`), licencias comerciales no contempladas y red Wi-Fi del aula. | `B3` §3 (Alcance) y `03-diagrama-arquitectura-despliegue-g3.svg` | Sí |
| **4** | **Valor total, moneda e impuestos** | Precio de venta total en pesos colombianos (`COP`), discriminando subtotal, reserva de contingencia, margen/utilidad e **IVA del 19 %** aplicado sobre el total con contingencia, más TRM de referencia (`$4.000/USD`). | `B2` (Hoja de presupuesto) y `B3` §8 (Costos) | Sí |
| **5** | **Forma e hitos de pago** | Pagos ligados a entregables verificables: `30 %` al acta de inicio y aprobación de especificaciones, `40 %` a la entrega en entorno de pruebas con suite E2E aprobada y `30 %` contra acta de recibo a satisfacción en producción. | `B3` §11 (Condiciones comerciales) | Sí |
| **6** | **Plazos, cronograma e hitos** | Duración total en semanas, EDT de `≥ 10` tareas con predecesoras, ruta crítica calculada y fecha límite de puesta en producción. | `B3` §6 (Metodología, EDT y ruta crítica) | Sí |
| **7** | **Entregables formales** | Código fuente en repositorio Git, contenedores Docker (`Dockerfile`, `docker-compose.yml`), script DDL 3FN, suite E2E Playwright, manual técnico, manual de usuario y actas de capacitación. | `B3` §3 y §6 (Entregables por hito) | Sí |
| **8** | **Criterios de aceptación** | Recepción contra pruebas funcionales de los `12` RF, cumplimiento de `p95 ≤ 2,0 s`, validación `HTTP 403` de seguridad y ejecución sin errores de la suite E2E; plazo de `5` días hábiles para observaciones del contratante. | `B3` §5 (Remisión a `G3-P1/A2`), §6 y `B6` §2 | Sí |
| **9** | **Garantías y soporte post-entrega** | Garantía de corrección de defectos de código por `6` meses sin costo adicional y bolsa/plan de soporte operativo a `12` meses con canales y horarios definidos. | `B3` §10 (Garantías y soporte) | Sí |
| **10** | **Propiedad intelectual y titularidad** | Reconocimiento de derechos morales inalienables al autor y **cesión por escrito** de derechos patrimoniales al contratante contra pago total (Ley 23 de 1982, art. 28 Ley 1450/2011 y Decisión Andina 351/1993), respetando licencias OSS inventariadas en `G3-P1/A4`. | `B3` §11 y `G3-P1/A3–A4` | Sí |
| **11** | **Confidencialidad y protección de datos personales** | Cláusula de reserva de información y acuerdo de **transmisión de datos personales** (Ley 1581 de 2012 y Decreto 1074 de 2015, art. `2.2.2.25.5.2`) definiendo al contratante como Responsable y al proveedor/hosting como Encargado, prohibiendo transferencia a terceros. | `B3` §11 y `G3-P1/A3` §1–§2 | Sí |
| **12** | **Acuerdos de Niveles de Servicio (ANS)** | Compromisos cuantificados de disponibilidad, latencia `p95`, `RPO`, `RTO`, fuente de medición y esquema de compensaciones/créditos. | `B6` §3 (Anexo contractual de ANS) y `B3` §10 | Sí |
| **13** | **Causales de terminación y solución de controversias** | Terminación por mutuo acuerdo, incumplimiento grave con preaviso de `15` días hábiles para subsanación, fuerza mayor y mecanismo de arreglo directo antes de instancia legal; entrega ordenada de respaldos de BD al finalizar. | `B3` §11 (Condiciones comerciales) | Sí |
| **14** | **Vigencia de la oferta** | Validez de la propuesta técnica y económica por `30` días calendario desde la fecha de emisión, sujeta a variación de TRM superior al `±5 %` en rubros en dólares. | `B3` §12 (Vigencia de la oferta) | Sí |

---

## 2. Matriz de Cumplimiento de Términos de Referencia (`8` Requisitos del Contratante)

> Términos de referencia (TdR) consolidados con base en las necesidades institucionales del proyecto `asistencia-sena` (pendientes de contraste adicional durante la reunión de validación con la contraparte en `B5`).

| ID TdR | Requisito de los Términos de Referencia (TdR) | Estado | Evidencia verificable en la propuesta |
| :--- | :--- | :---: | :--- |
| **TdR-01** | El sistema debe operar vía navegador web en escritorio y móvil (`≥ 390 px`) sin exigir instalación de aplicaciones nativas en teléfonos de aprendices. | **Cumple** | `G2-P1/A6`, `03-diagrama-arquitectura-despliegue-g3.svg` (`N1`, `N2`) y ficha `FT-SW-01` (`G3-P1/A2`). |
| **TdR-02** | Debe garantizar registro de asistencia multi-canal con respaldo inmediato ante fallas de cámara, GPS o ausencia de teléfono móvil. | **Cumple** | Canales QR rotativo, código de 6 dígitos, escáner del instructor y registro manual con novedad (`RF-05`, `RF-08`, `RF-09`; patrón Estrategia `G2-P1/A3`). |
| **TdR-03** | Debe cumplir integralmente la Ley 1581 de 2012 y el Decreto 1074 de 2015, impidiendo captura móvil sin consentimiento previo y sin transferir datos a terceros. | **Cumple** | Referente 1 de `G3-P1/A3`, cláusula de transmisión en `B6` §1 (#11) y `consentimiento_datos = 1` obligatorio en `G2-P2/B6`. |
| **TdR-04** | Toda la pila de software en producción debe contar con licenciamiento legalmente verificado, priorizando software libre/código abierto sin costos ocultos por usuario. | **Cumple** | `G3-P1/04-dimensionamiento-licencias.md`: `8` componentes y `6` dependencias auditadas con costo de licencia base `$0` y control de copyleft. |
| **TdR-05** | La infraestructura debe aislar la base de datos de Internet, cifrar el tráfico con `TLS 1.2/1.3` y ejecutar respaldos diarios cifrados fuera del servidor principal. | **Cumple** | Nodos `N3` (TLS 1.3), `N5` (`TCP 3306` privado) y `N6` (respaldos S3 cifrados `AES-256`) en `03-diagrama-arquitectura-despliegue-g3.svg`. |
| **TdR-06** | El presupuesto debe respetar el tope del primer año definido por la variante asignada, incluir TCO a 36 meses, contingencia ligada a riesgos e IVA del 19 %. | **Cumple** *(por validar cifras finales con variante en `B2`)* | Estructura de `G3-P1/A6` y `G3-P2/B1–B2` diseñada con fórmulas vivas y tope validado en Commit 2. |
| **TdR-07** | El proveedor debe comprometerse a métricas medibles de disponibilidad, tiempo de respuesta, `RPO` y `RTO`, respaldadas por monitoreo externo independiente. | **Cumple** | Tabla ANS de `B6` §3 (`4` métricas medibles con ventana, fuente `N7`/`N6` y compensación). |
| **TdR-08** | El proyecto debe incluir capacitación a instructores/coordinadores y documentación técnica para transferencia de conocimiento sin dependencia permanente del proveedor. | **Cumple** | Incluido en `B2` (categoría Capacitación y Soporte) y `B3` §6 (tareas de capacitación y entrega de manuales en la EDT). |

---

## 3. Acuerdo de Niveles de Servicio — ANS (`4` Métricas Medibles)

> **Nota de parametrización por variante:** La meta de disponibilidad mensual (`ANS-01`) adopta el umbral exacto exigido por la variante asignada (`99,0 %` en A · `99,5 %` en B/C · `99,9 %` en D). Al confirmar la variante en Commit 2 y tras la negociación de `B5`, se fija el valor definitivo en `v1.1`.

| ID ANS | Métrica medible | Valor objetivo (meta) | Ventana de medición y exclusiones | Fuente objetiva de medición | Compensación por incumplimiento |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **ANS-01** | **Disponibilidad mensual del servicio web** | **`≥ [Meta de variante: 99,0 % / 99,5 % / 99,9 %]`** mensual *(tiempo máximo de caída no programada: `7,2 h` en 99,0 %; `3,6 h` en 99,5 %; `43 min` en 99,9 %)* | `24 horas × 7 días`, evaluación mensual calendario. Excluye mantenimientos programados `≤ 2 h/mes` en horario `00:00–05:00` notificados con `≥ 48 h` de antelación. | Reporte mensual del monitor HTTP externo independiente (`N7`, sondeo cada `60 s` sobre `HTTPS 443`). | Descuento (crédito de servicio) sobre la cuota mensual de operación/soporte: **`5 %`** si cae hasta `0,5` puntos por debajo de la meta; **`10 %`** entre `0,5` y `1,0` punto; **`15 %`** si supera `1,0` punto de desviación. |
| **ANS-02** | **Tiempo de respuesta en registro de asistencia (`p95`)** | **`≤ 2,0 segundos`** en el percentil 95 bajo la concurrencia pico definida por la variante | Lunes a sábado, franja académica `06:00–22:00` (hora Colombia `-05:00`), medición mensual consolidada. | Logs de latencia del proxy inverso (`N3`) + pruebas sintéticas semanales sobre `registro.php` y `registrar_asistencia.php`. | Plan de optimización correctivo obligatorio en `≤ 5` días hábiles; crédito del **`5 %`** sobre soporte mensual si el `p95` supera `2,0 s` en dos meses consecutivos. |
| **ANS-03** | **Objetivo de Punto de Recuperación (`RPO`)** | **`≤ 24 horas`** *(pérdida máxima tolerable de datos ante desastre del nodo `N5`)* | Evaluación mensual sobre respaldos diarios ejecutados a las `02:00 a. m.` (hora Colombia) con retención de `30` días. | Logs automatizados del cron `mysqldump`, verificación de checksums SHA-256 en `N6` y acta mensual de prueba de restauración. | Crédito del **`10 %`** de la mensualidad de operación si un incidente imputable al contratista provoca pérdida superior a `24 h` de registros, más plan de remediación inmediata. |
| **ANS-04** | **Objetivo de Tiempo de Recuperación (`RTO`) y respuesta a incidentes críticos (`P1`)** | **Respuesta inicial `P1 ≤ 30 min`** y **recuperación total del servicio (`RTO`) `≤ 2 horas`** | Incidentes `P1` (caída total del registro de asistencia): lunes a sábado `06:00–22:00`; incidentes `P2` (degradación parcial con contingencia activa): resolución `≤ 8 h` hábiles. | Registro con marca temporal en mesa de incidentes + reporte del monitor `N7` confirmando retorno a `HTTP 200`. | Crédito del **`5 %`** por cada incidente `P1` que exceda `RTO = 2 h` (tope acumulado `20 %` mensual) y análisis causa raíz (RCA) entregado en `≤ 48 h`. |

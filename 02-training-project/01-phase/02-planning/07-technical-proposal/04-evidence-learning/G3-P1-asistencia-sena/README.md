# G3 · Propuesta técnica · README de entrega (Producto 1)

## 1. Identificación

| Campo | Valor |
| :--- | :--- |
| **Producto** | P1 · Especificaciones técnicas (`RAP 593060`) |
| **Usuario de GitHub del autor** | `@andressalinasvargas` |
| **Ficha** | `3413974` |
| **Variante del escenario asignada (A, B, C o D)** | *Variante B adoptada como escenario provisional (`120` usuarios, `30` concurrentes, `2` sedes, `99,5 %` disp., tope `$70.000.000`)* *(parametrizada dinámicamente con `INDEX/MATCH` en `.xlsx` para `A`–`D` y pendiente de confirmación oficial del instructor en Día 3)* |
| **Caso de estudio (nombre del proyecto de mi fork)** | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) |
| **Fecha de la última actualización** | `2026-11-24` |
| **Plazo de entrega** | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

---

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen en mi fork (ruta) | Cómo lo reutilicé |
| :--- | :--- | :--- |
| SRS, requisitos funcionales y no funcionales (`A1`, `A2`, `A5`) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) y [`03-execute/16-week/02-optional-activity/Tema Tomar asistencia_0.1.txt`](../../../../../../03-execute/16-week/02-optional-activity/Tema%20Tomar%20asistencia_0.1.txt) | Tomé los 12 RF (`RF-01`–`RF-12`) y 6 RNF (`RNF-01`–`RNF-06`) como base de trazabilidad para el formato de ficha técnica (`A1`) y el mapeo normativo (`A3`). |
| Contexto normativo interno y estándares (`A3`) | [`03-execute/13-week/02-optional-activity/Problema y Contexto Normativo del Proyecto.docx`](../../../../../../03-execute/13-week/02-optional-activity/Problema%20y%20Contexto%20Normativo%20del%20Proyecto.docx) y [`G2-P2-asistencia-sena/06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-asistencia-sena/06-politicas-seguridad-datos.md) | Reutilicé las políticas internas de seguridad, roles y tratamiento de datos, **separándolas explícitamente** de la normatividad legal colombiana verificada en fuentes oficiales. |
| Plataforma, despliegue y arquitectura de referencia (`A2`, `A4`, `A5`) | [`G2-P1-asistencia-sena/01-ficha-interpretacion-y-plataforma.md`](../../../06-architecture/04-evidence-learning/G2-P1-asistencia-sena/01-ficha-interpretacion-y-plataforma.md) y [`G2-P1-asistencia-sena/05-vista-despliegue.md`](../../../06-architecture/04-evidence-learning/G2-P1-asistencia-sena/05-vista-despliegue.md) | Base de nodos (`Cliente Escritorio`, `Cliente Móvil`, `Servidor Aplicación`, `Servidor Datos`) y pila tecnológica (`PHP 8.3`, `Apache 2.4`, `MariaDB 10.11`) para fichas, licenciamiento y capacidad. |
| Código y dependencias base (`A4` — próximo commit) | [`03-execute/24-week/02-optional-activity/Toma_Asistencia.zip`](../../../../../../03-execute/24-week/02-optional-activity/Toma_Asistencia.zip) y [`03-execute/17-week/02-optional-activity/Sistema_Asistencia.zip`](../../../../../../03-execute/17-week/02-optional-activity/Sistema_Asistencia.zip) | Punto de partida para el inventario de dependencias y licencias de software en Commit 2. |

Si algún artefacto no existe en mi fork (formato formal de ficha técnica `A1`, referentes legales verificados con vigencia `A3`, dimensionamiento formal de licencias `A4` y hoja de costos `A6`), se construye desde cero siguiendo `Rubricas_G3.md`.

---

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué (necesidad del caso o criterio de la rúbrica) |
| :--- | :--- | :--- |
| **A1. Formato de ficha técnica** | Construí desde cero un formato propio de **15 campos** basado en `ISO/IEC/IEEE 29148:2018` e `ISO/IEC 25010:2023`, con subtabla obligatoria de valor, unidad y método de verificación y regla explícita de neutralidad de marcas. | Cumple `C1` de `Rubricas_G3.md` (`≥ 12` campos y estándar declarado) y sirve como plantilla reutilizable en `A2` y en la prueba de desempeño. |
| **A3. Referente técnico y normativo** | Construí tabla verificada de **5 referentes legales y técnicos** (`Ley 1581/2012 + Decreto 1074/2015`, `Ley 23/1982`, `Decisión Andina 351/1993`, `WCAG 2.2 / ISO/IEC 25010:2023` y `Ley 1273/2009`), separando la normativa interna del proyecto (`GOB-01`–`GOB-04`) y explicando transmisión vs. transferencia de datos. | Cumple `C3` de `Rubricas_G3.md` al 100 % con fuentes oficiales verificadas el `2026-11-23` y evita confundir normas internas con leyes vigentes. |
| **A4. Dimensionamiento de licencias e inventario** | Construí tabla de **8 componentes** con fórmulas parametrizadas para variantes `A`–`D`, inventario real de **6 dependencias** auditadas del código (`Dockerfile`, `docker-compose.yml`, `e2e/package.json`, `sesion.php`) con análisis copyleft (`MariaDB GPL v2`), alerta de CDN (`qrcodejs`) y decisión justificada de licencia propia. | Cumple `C4` de `Rubricas_G3.md` (`≥ 6` componentes, `≥ 5` dependencias con compatibilidad y licencia propia decidida con fundamento legal). |
| **A2. Fichas técnicas diligenciadas** | Diligencié **`4` fichas técnicas** (`FT-SW-01`, `FT-SW-02`, `FT-INF-01`, `FT-HW-02`) usando los `15` campos de `A1`, con `6`–`7` características medibles (valor, unidad y método de verificación) cada una y **neutralidad de marcas**. | Cumple `C2` de `Rubricas_G3.md` (`2` software/servicio y `2` hardware/infraestructura trazadas a `RF`/`RNF` y Variante B provisional). |
| **A5. Estimación de condiciones técnicas** | Documenté **`7` parámetros medibles** (`CAP-01`–`CAP-07`: usuarios, almacenamiento a 36 meses, ancho de banda, disponibilidad `99,5 %`, `p95 ≤ 2,0 s`, `RPO ≤ 24 h`, `RTO ≤ 2 h`) con fórmulas, supuestos y matriz `A`–`D`. | Cumple `C5` de `Rubricas_G3.md` en coherencia exacta con las fichas `A2` y el ANS de `G3-P2/B6`. |
| **A6. Estimación preliminar económica** | Construí libro Excel con **fórmulas vivas** (`INDEX/MATCH`, `SUM`, `SUMIF`, `IF`) en `4` hojas (`11` módulos por horas = `390 h`, costos a `12` y `36` meses, Directo/Indirecto, Único/Recurrente, rango `±15 %` y verificación de tope) más resumen `.md`. | Cumple `C6` de `Rubricas_G3.md` y permite recálculo inmediato al confirmar la variante oficial en Día 3. |

---

## 4. Enlaces a los entregables (Producto 1)

- [x] **A1.** Formato de ficha técnica (`15` campos, estándar base declarado): [01-formato-ficha-tecnica.md](01-formato-ficha-tecnica.md)
- [x] **A2.** Fichas técnicas diligenciadas (`4` fichas: `2` software/servicio y `2` hardware/infraestructura, `6`–`7` características medibles c/u, sin marcas): [02-fichas-tecnicas.md](02-fichas-tecnicas.md)
- [x] **A3.** Referente técnico (`5` referentes legales y técnicos verificados con enlace y fecha + separación de normativa interna): [03-referente-tecnico-normativo.md](03-referente-tecnico-normativo.md)
- [x] **A4.** Dimensionamiento de licencias (`8` componentes parametrizados) e inventario real de dependencias (`6` dependencias verificadas) + decisión de licencia propia: [04-dimensionamiento-licencias.md](04-dimensionamiento-licencias.md)
- [x] **A5.** Estimación de condiciones técnicas (`7` parámetros medibles derivados de la variante con fórmulas y matriz `A`–`D`): [05-condiciones-tecnicas.md](05-condiciones-tecnicas.md)
- [x] **A6.** Estimación preliminar de condiciones económicas (libro Excel con fórmulas vivas a 12 y 36 meses + guía): [06-estimacion-economica.xlsx](06-estimacion-economica.xlsx) · [06-estimacion-economica.md](06-estimacion-economica.md)

---

## 5. Autoevaluación de mínimos (estado en avance — Día 2)

| Mínimo | Mi conteo actual |
| :--- | :--- |
| `[P1]` Formato de ficha técnica (`≥ 12` campos + estándar base) | `15` campos (`ISO/IEC/IEEE 29148` + `ISO/IEC 25010:2023`) |
| `[P1]` Fichas diligenciadas / características medibles por ficha | `4` fichas (`2` SW/servicio + `2` HW/infraestructura) / `6`–`7` características medibles c/u |
| `[P1]` Referentes técnicos (`≥ 4`) / incluyen Ley 1581/2012, Ley 23/1982, Decisión Andina 351 y estándar | `5` / `sí` (incluye además `Ley 1273/2009`) |
| `[P1]` Componentes de licencias / dependencias inventariadas | `8` / `6` *(incluye análisis copyleft y licencia propia)* |
| `[P1]` Parámetros técnicos (`≥ 5`) / hoja económica con fórmulas vivas | `7` parámetros (`CAP-01`–`CAP-07`) / `sí` (`06-estimacion-economica.xlsx` con `INDEX/MATCH`, `SUM`, `SUMIF`, `IF` a `12` y `36` meses) |

---

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
| :--- | :--- | :--- |
| `2026-11-23` (Día 1 — Commit 1) | Diseñé el formato propio de ficha técnica (`A1`), verifiqué fuentes oficiales para el referente técnico-normativo (`A3`) y creé el `README.md` inicial de `G3-P1`. | [`f79d3cb`](https://github.com/andressalinasvargas/ADSO-3413974/commit/f79d3cb) |
| `2026-11-23` (Día 1 — Commit 2) | Audité las dependencias reales del código (`Dockerfile`, `docker-compose.yml`, `e2e/package.json`, `sesion.php`) y construí `04-dimensionamiento-licencias.md` (`A4`) con `8` componentes, `6` dependencias y licencia propia. | [`6ff37af`](https://github.com/andressalinasvargas/ADSO-3413974/commit/6ff37af) |
| `2026-11-24` (Día 2 — Commit 3) | Diligencié `4` fichas técnicas (`A2`), estimé `7` condiciones técnicas de capacidad y servicio (`A5`) y construí el libro económico con fórmulas vivas a 12 y 36 meses (`A6`) bajo escenario provisional Variante B. | Commit 3 (`feat(g3-p1): agregar fichas tecnicas A2, condiciones tecnicas A5 y hoja economica A6 con formulas`) |
| *Día 3 (programado antes del `2026-12-05`)* | Fijar la variante definitiva asignada por el instructor en `1_Parametros_Variante!B3` (si difiere de B) y propagar eventuales ajustes posteriores a la validación `B5` de `G3-P2`. | Commit 4 (pendiente confirmación variante / `B5`) |

---

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
| :--- | :--- | :--- |
| Función Pública — Ley Estatutaria 1581 de 2012 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981`) | `2026-11-23` | Verificar vigencia, principios, derechos ARCO y protección de menores en `A3`. |
| Función Pública / SUIN-Juriscol — Decreto 1074 de 2015 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=76608` · `https://www.suin-juriscol.gov.co/viewDocument.asp?id=30019935`) | `2026-11-23` | Verificar reglamentación compilada de la Ley 1581 y distinción transmisión vs. transferencia en `A3`. |
| Función Pública — Ley 23 de 1982 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431`) | `2026-11-23` | Verificar derechos morales y patrimoniales de autor en `A3`. |
| WIPO Lex / DNDA — Decisión Andina 351 de 1993 (`https://www.wipolex.wipo.int/es/text/169152` · `https://www.derechodeautor.gov.co`) | `2026-11-23` | Verificar protección de programas de ordenador como obra literaria en `A3`. |
| Función Pública — Ley 1273 de 2009 (`https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=34492`) | `2026-11-23` | Verificar tipos penales informáticos aplicables a controles de seguridad en `A3`. |
| W3C — WCAG 2.2 (`https://www.w3.org/TR/WCAG22/`) e ISO (`https://www.iso.org`) | `2026-11-23` | Verificar criterios de accesibilidad web móvil AA y modelo de calidad `ISO/IEC 25010:2023` en `A1` y `A3`. |

---

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
| :--- | :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en estructuración de la plantilla de 15 campos (`A1`), fichas técnicas (`A2`), organización normativa (`A3`), parámetros técnicos (`A5`) y generación del libro `.xlsx` (`A6`). | `01-formato-ficha-tecnica.md`, `02-fichas-tecnicas.md`, `03-referente-tecnico-normativo.md`, `05-condiciones-tecnicas.md`, `06-estimacion-economica.*` y `README.md`. | Verifiqué cada URL oficial el `2026-11-23`, comprobé neutralidad de marcas en `A2`, validé las fórmulas `INDEX/MATCH`/`SUM`/`SUMIF`/`IF` en `06-estimacion-economica.xlsx` y confirmé coherencia numérica con `G3-P2/B2`. |

---

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año en mi fork, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. Si trabajé con compañeros de equipo, lo indico aquí: nada (trabajo individual).

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `@andressalinasvargas` · Fecha: `2026-11-24`

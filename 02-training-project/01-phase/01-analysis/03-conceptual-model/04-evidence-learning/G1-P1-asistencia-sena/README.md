# Entrega · Guía 1 · Modelo conceptual (Producto 1)

Ruta de entrega en mi fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/`

---

## 1. Datos de la entrega

- **Producto:** P1 · Plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `@andressalinasvargas`
- **Caso de estudio:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha 3413974
- **Trabajo en equipo del año:** No (trabajo individual sobre el proyecto del año en `03-execute/`)

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| Requisitos iniciales e informe SRS base | [`03-execute/16-week/02-optional-activity/Tema Tomar asistencia_0.1.txt`](../../../../../../03-execute/16-week/02-optional-activity/Tema%20Tomar%20asistencia_0.1.txt) y [`03-execute/17-week/02-optional-activity/Sistema_Asistencia_1.1.txt`](../../../../../../03-execute/17-week/02-optional-activity/Sistema_Asistencia_1.1.txt) | Solo |
| Resumen de socialización MVP y contingencias | [`03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md`](../../../../../../03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md) | Solo |
| Priorización MoSCoW y Design Thinking | [`03-execute/18-week/02-optional-activity/MOSCOW.jpeg`](../../../../../../03-execute/18-week/02-optional-activity/MOSCOW.jpeg) y [`03-execute/18-week/02-optional-activity/DESIGN THINKING.jpeg`](../../../../../../03-execute/18-week/02-optional-activity/DESIGN%20THINKING.jpeg) | Solo |
| Diagrama base de Casos de Uso (`.drawio`) | [`03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio`](../../../../../../03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio) | Solo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
| :- | :--- | :--- | :--- |
| 1 | `00-insumo-srs-base.md` y `04-matriz-rf-casos-uso.md` | Consolidé las necesidades dispersas de semana 16/17 en **12 RF** (`RF-01`–`RF-12`) y **6 RNF** (`RNF-01`–`RNF-06`) separados, explicando por qué los RNF no son casos de uso (`C3` de `Rubricas_G1.md`). | [b788032](https://github.com/andressalinasvargas/ADSO-3413974/commit/b7880329509b0dd5828c2c9914cbf3ffda15d539) |
| 2 | `03-diagrama-casos-uso.drawio` / `.png` / `.svg` | Amplié el diagrama de semana 16 (que tenía solo `Instructor` y 5 CU con 3 pasos de UI) a **12 casos de uso** con verbo + objeto, frontera del sistema, 3 actores primarios y 2 secundarios fuera de ella (`C4`). | [b788032](https://github.com/andressalinasvargas/ADSO-3413974/commit/b7880329509b0dd5828c2c9914cbf3ffda15d539) |
| 3 | `03-diagrama-casos-uso.*` y `03-justificacion-relaciones-cu.md` | Corregí la granularidad de `«include»` hacia subprocesos reales (`CU-05`, `CU-06`) e incorporé **4 relaciones `«extend»`** (`CU-09` tardanza, `CU-10` contingencia) con puntos de extensión, flecha hacia el caso base y justificación de 1 línea (`C4`). | [b788032](https://github.com/andressalinasvargas/ADSO-3413974/commit/b7880329509b0dd5828c2c9914cbf3ffda15d539) |
| 4 | `04-matriz-rf-casos-uso.md` y `README.md` | Agregué la auditoría inversa `Caso de Uso → RF` (`12/12` sin casos huérfanos) para habilitar la transición hacia diseño (Guía 2) y completé los enlaces directos al commit publicado del Día 1 (`C3`, `C5`). | Día 2 (`2026-11-23`) · revisión cruzada de cierre |

## 4. Qué construí nuevo

- **Caracterización completa de la solución (4 aspectos) y comparación de 4 metodologías** (RUP, Scrum, XP, RAD) con 5 criterios propios en [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md).
- **Plan de actividades de análisis en Scrum** con 8 actividades priorizadas, responsable, fecha y entregable en [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md).
- **Matriz completa de cobertura `RF → Caso de Uso`** al 100 % con separación de RNF en [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md).

## 5. Artefactos entregados

**Producto 1**

- [x] Insumo SRS base consolidado (`RF-01`–`RF-12` y `RNF-01`–`RNF-06`): [00-insumo-srs-base.md](00-insumo-srs-base.md)
- [x] Caracterización de la solución y comparación de metodologías con selección justificada: [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio)
- [x] Diagrama de casos de uso (imágenes y justificación): [03-diagrama-casos-uso.png](03-diagrama-casos-uso.png) · [03-diagrama-casos-uso.svg](03-diagrama-casos-uso.svg) · [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md)
- [x] Matriz requisito → caso de uso: [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi trabajo del año está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: `@andressalinasvargas` · Fecha: `2026-11-23`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en estructuración de tablas comparativas, redacción técnica libre de detalles de implementación, generación XML `.drawio`/`.svg` y validación cruzada contra `Rubricas_G1.md`. | Verifiqué manualmente que los requisitos y casos de uso correspondan al proyecto real trabajado en `03-execute/` (semanas 16–19), comprobé el sentido de flechas `«include»`/`«extend»`, la inspección visual de imágenes `.png` y los porcentajes de cobertura. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: `2026-11-22` [`b788032`] · Día 2: `2026-11-23`, revisión de trazabilidad inversa y enlaces a commits)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] No incluí datos personales reales ni de terceros.

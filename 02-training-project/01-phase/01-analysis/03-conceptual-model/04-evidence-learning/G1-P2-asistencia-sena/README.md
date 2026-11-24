# Entrega · Guía 1 · Modelo conceptual (Producto 2)

Ruta de entrega en mi fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/`

---

## 1. Datos de la entrega

- **Producto:** P2 · Modelo de análisis y verificación
- **Usuario de GitHub del autor:** `@andressalinasvargas`
- **Caso de estudio:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha 3413974
- **Trabajo en equipo del año:** No (trabajo individual sobre el proyecto del año en `03-execute/`)

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| Diagrama base de clases (`Instructor`, `Asistencia`, `Aprendiz`) | [`03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio`](../../../../../../03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio) | Solo |
| Descripciones iniciales de casos de uso y flujos de error | [`03-execute/17-week/02-optional-activity/Sistema_Asistencia_1.1.txt`](../../../../../../03-execute/17-week/02-optional-activity/Sistema_Asistencia_1.1.txt) | Solo |
| Pantallas base del prototipo inicial | [`03-execute/17-week/02-optional-activity/Mockups_Instructor.png`](../../../../../../03-execute/17-week/02-optional-activity/Mockups_Instructor.png), [`Mockups_Aprendiz.png`](../../../../../../03-execute/17-week/02-optional-activity/Mockups_Aprendiz.png), [`Mockups_Lista.png`](../../../../../../03-execute/17-week/02-optional-activity/Mockups_Lista.png), [`asistencia_sena_historial.png`](../../../../../../03-execute/17-week/02-optional-activity/asistencia_sena_historial.png) | Solo |
| Apuntes de contingencias e ingeniería inversa | [`03-execute/18-week/02-optional-activity/Plan de contingencia.png`](../../../../../../03-execute/18-week/02-optional-activity/Plan%20de%20contingencia.png) y [`03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md`](../../../../../../03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md) | Solo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
| :- | :--- | :--- | :--- |
| 1 | `04-modelo-dominio.*` y `04-modelo-dominio-descripcion.md` | Transformé el diagrama de semana 16 (3 clases con métodos y claves `id*`) en un **Modelo de Dominio** puro con **11 clases conceptuales** sin métodos ni claves técnicas, generalización `Persona` y 2 clases de asociación (`C3` de `Rubricas_G1.md`). | [9209ff2](https://github.com/andressalinasvargas/ADSO-3413974/commit/9209ff23ec6cb8c56d1399f4192aac006d3844ea) |
| 2 | `03-plantillas-casos-uso.md` | Expandí las descripciones de semana 17 en **4 plantillas extendidas** (`CU-03`, `CU-04`, `CU-08`, `CU-12`) con precondiciones estrictas previas, ≥ 6 pasos, flujos alternos, excepciones y redacción libre de SQL/PHP (`C2`). | [9209ff2](https://github.com/andressalinasvargas/ADSO-3413974/commit/9209ff23ec6cb8c56d1399f4192aac006d3844ea) |
| 3 | `06-prototipo-inicial/*` | Rotulé 4 pantallas derivadas de los mockups de semana 17 con su caso de uso (`CU-03`, `CU-04`, `CU-08`, `CU-12`) y requisitos cubiertos, vinculándolas a las plantillas y matriz (`C5`). | [9209ff2](https://github.com/andressalinasvargas/ADSO-3413974/commit/9209ff23ec6cb8c56d1399f4192aac006d3844ea) |
| 4 | `08-registro-ajustes.md`, `10-informe-analisis.md` y `README.md` | Registré el cierre de verificación del Día 2 (`H-07`), validé consistencia del MER hacia diseño lógico (Guía 2) y enlacé los commits exactos publicados del Día 1 (`b788032` y `9209ff2`). | [9f3b490](https://github.com/andressalinasvargas/ADSO-3413974/commit/9f3b4902b6012b8b1d4923b63632c74bf5932da7) |

## 4. Qué construí nuevo

- **Dos diagramas de actividades UML** con calles por actor, guardas `[...]` en todas las decisiones y barra fork/join para flujos concurrentes (`01-actividad-cu04-registro-qr.*` y `02-actividad-cu03-cu11-ciclo-sesion.*`).
- **Modelo Entidad-Relación (MER)** en notación **Pata de gallo** con 9 entidades, 2 relaciones N:M resueltas mediante entidad asociativa (`ASIGNACION_INSTRUCTOR_FICHA`, `REGISTRO_ASISTENCIA`) y entidad débil `NOVEDAD_CONTINGENCIA` (`05-modelo-entidad-relacion.*`).
- **Instrumentos de verificación y trazabilidad:** lista de chequeo de 18 criterios ([07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md)), registro de 6 ajustes ([08-registro-ajustes.md](08-registro-ajustes.md)), matriz de trazabilidad completa al 100 % ([09-matriz-trazabilidad.md](09-matriz-trazabilidad.md)) e informe de análisis ([10-informe-analisis.md](10-informe-analisis.md)).

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2 completos en `.drawio`, `.png`, `.svg`): [01-actividad-cu04-registro-qr.drawio](01-actividad-cu04-registro-qr.drawio) · [01-actividad-cu04-registro-qr.png](01-actividad-cu04-registro-qr.png) · [02-actividad-cu03-cu11-ciclo-sesion.drawio](02-actividad-cu03-cu11-ciclo-sesion.drawio) · [02-actividad-cu03-cu11-ciclo-sesion.png](02-actividad-cu03-cu11-ciclo-sesion.png)
- [x] Plantillas extendidas de casos de uso (`CU-03`, `CU-04`, `CU-08`, `CU-12`): [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md)
- [x] Modelo de dominio (`.drawio`, `.png`, `.svg` y descripción): [04-modelo-dominio.drawio](04-modelo-dominio.drawio) · [04-modelo-dominio.png](04-modelo-dominio.png) · [04-modelo-dominio-descripcion.md](04-modelo-dominio-descripcion.md)
- [x] Modelo entidad-relación (`.drawio`, `.png`, `.svg` y descripción): [05-modelo-entidad-relacion.drawio](05-modelo-entidad-relacion.drawio) · [05-modelo-entidad-relacion.png](05-modelo-entidad-relacion.png) · [05-mer-descripcion.md](05-mer-descripcion.md)
- [x] Prototipo inicial (4 pantallas rotuladas): [06-prototipo-inicial.md](06-prototipo-inicial/06-prototipo-inicial.md) · [pantalla-01](06-prototipo-inicial/pantalla-01-cu03-abrir-sesion.png) · [pantalla-02](06-prototipo-inicial/pantalla-02-cu04-registro-aprendiz.png) · [pantalla-03](06-prototipo-inicial/pantalla-03-cu08-contingencia-manual.png) · [pantalla-04](06-prototipo-inicial/pantalla-04-cu12-historial-reportes.png)
- [x] Lista de chequeo diligenciada (18 criterios): [07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación: [08-registro-ajustes.md](08-registro-ajustes.md)
- [x] Matriz de trazabilidad (Anexo C): [09-matriz-trazabilidad.md](09-matriz-trazabilidad.md)
- [x] Informe de análisis: [10-informe-analisis.md](10-informe-analisis.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi trabajo del año está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma: `@andressalinasvargas` · Fecha: `2026-11-23`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en redacción de plantillas extendidas sin detalles técnicos, generación XML `.drawio`/`.svg` de diagramas UML/MER, renderizado de imágenes `.png` y revisión cruzada contra `Rubricas_G1.md`. | Revisé que cada diagrama incluya las guardas `[...]`, barras fork/join, ausencia de métodos/FK en el dominio, notación Pata de gallo con entidad débil en el MER y coincidencia exacta 1:1 con los flujos del sistema de asistencia. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: `2026-11-22` [`9209ff2`] · Día 2: `2026-11-23` [`9f3b490`], cierre `H-07` y enlaces a commits)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] No incluí datos personales reales ni de terceros.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.

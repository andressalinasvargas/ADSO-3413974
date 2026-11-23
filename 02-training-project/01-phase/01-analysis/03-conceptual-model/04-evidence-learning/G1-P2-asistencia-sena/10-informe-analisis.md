# Informe de Análisis — Sistema Web de Control de Asistencia SENA

**Proyecto:** `asistencia-sena` · **Ficha:** 3413974 (ADSO)  
**Producto:** G1-P2 · Modelo de análisis y verificación  
**Autor:** `@andressalinasvargas` · **Fecha:** 2026-11-23

---

## 1. Requisitos Interpretados (Funcionales y No Funcionales)

A partir de los insumos de levantamiento trabajados durante el año (`03-execute/16-week/02-optional-activity/Tema Tomar asistencia_0.1.txt`, `17-week/Sistema_Asistencia_1.1.txt` y `19-week/Resumen_Socializacion_MVP.md`), se consolidó la especificación del sistema en [00-insumo-srs-base.md](../G1-P1-asistencia-sena/00-insumo-srs-base.md):

- **12 Requisitos Funcionales (`RF-01` a `RF-12`):** Cubren el ciclo completo de control de asistencia en formación SENA bajo modalidad multi-canal: autenticación por rol (`RF-01`), gestión y borrado lógico de fichas/aprendices con credencial QR (`RF-02`), apertura de sesiones temporales con tolerancia (`RF-03`), validación de vigencia y pertenencia a ficha (`RF-04`), autorregistro móvil por QR rotativo o código de 6 dígitos (`RF-05`), verificación de ubicación GPS y consentimiento expreso de datos (`RF-06`), bloqueo estricto de duplicados (`RF-07`), lectura mediante escáner QR del instructor (`RF-08`), registro manual de contingencia con novedades auditables (`RF-09`), cálculo automático de tardanza (`RF-10`), cierre manual/automático de sesión (`RF-11`) y consulta histórica con reportes (`RF-12`).
- **6 Requisitos No Funcionales (`RNF-01` a `RNF-06`):** Diferenciados explícitamente de los funcionales como restricciones transversales de seguridad y propiedad de sesiones (`RNF-01`), cumplimiento de la Ley 1581 de 2012 y Decreto 1377 de 2013 (`RNF-02`), tiempos de respuesta menores a 2 segundos (`RNF-03`), usabilidad móvil desde 390 px en ≤ 3 pasos (`RNF-04`), continuidad ante fallas técnicas (`RNF-05`) e integridad de auditoría (`RNF-06`).

---

## 2. Enlaces a los Modelos de Análisis Construidos

### Modelos del Producto 1 (`G1-P1-asistencia-sena`)
- **Plan metodológico (Scrum + MoSCoW):** [Caracterización y metodologías](../G1-P1-asistencia-sena/01-caracterizacion-y-metodologias.md) · [Plan de 8 actividades](../G1-P1-asistencia-sena/02-plan-actividades-analisis.md)
- **Modelo funcional (Casos de Uso UML):** [Editable `.drawio`](../G1-P1-asistencia-sena/03-diagrama-casos-uso.drawio) · [Imagen `.png`](../G1-P1-asistencia-sena/03-diagrama-casos-uso.png) · [Justificación `«include»`/`«extend»`](../G1-P1-asistencia-sena/03-justificacion-relaciones-cu.md) · [Matriz RF → CU (100 %)](../G1-P1-asistencia-sena/04-matriz-rf-casos-uso.md)

### Modelos del Producto 2 (`G1-P2-asistencia-sena`)
- **Diagramas de Actividades UML:**
  - `CU-04` Autorregistro móvil del aprendiz: [Editable `.drawio`](01-actividad-cu04-registro-qr.drawio) · [Imagen `.png`](01-actividad-cu04-registro-qr.png)
  - `CU-03`–`CU-11` Ciclo concurrente de sesión activa (con barras fork/join): [Editable `.drawio`](02-actividad-cu03-cu11-ciclo-sesion.drawio) · [Imagen `.png`](02-actividad-cu03-cu11-ciclo-sesion.png)
- **Especificación detallada de casos críticos:** [4 plantillas extendidas (`CU-03`, `CU-04`, `CU-08`, `CU-12`)](03-plantillas-casos-uso.md)
- **Modelo de Dominio (11 clases conceptuales sin métodos ni FK):** [Editable `.drawio`](04-modelo-dominio.drawio) · [Imagen `.png`](04-modelo-dominio.png) · [Descripción](04-modelo-dominio-descripcion.md)
- **Modelo Entidad-Relación (Notación Pata de Gallo, 9 entidades):** [Editable `.drawio`](05-modelo-entidad-relacion.drawio) · [Imagen `.png`](05-modelo-entidad-relacion.png) · [Descripción](05-mer-descripcion.md)
- **Prototipo Inicial Rotulado:** [4 pantallas críticas (`CU-03`, `CU-04`, `CU-08`, `CU-12`)](06-prototipo-inicial/06-prototipo-inicial.md)
- **Matriz de Trazabilidad Completa (100 % RF):** [09-matriz-trazabilidad.md](09-matriz-trazabilidad.md)

---

## 3. Resultado de la Verificación y Ajustes Realizados

Los artefactos fueron auditados mediante la lista de chequeo [07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md) compuesta por **18 criterios verificables** (5 de cobertura y trazabilidad). A partir de la comparación contra los borradores de semanas 16–17 y el cierre del Día 2 se documentaron y corrigieron **7 hallazgos (`H-01` a `H-07`)** en [08-registro-ajustes.md](08-registro-ajustes.md):

1. Se amplió el diagrama de casos de uso de 5 casos (un solo actor y pasos de UI) a **12 casos de uso**, 3 actores primarios, 2 secundarios y relaciones `«include»`/`«extend»` justificadas (`H-01`, `H-03`, commit `b788032`).
2. Se separaron formalmente `RF-01`–`RF-12` y `RNF-01`–`RNF-06` con trazabilidad al 100 % (`H-02`, commit `b788032`).
3. Se depuraron términos técnicos en plantillas y se transformó el diagrama de 3 clases con métodos de semana 16 en un **Modelo de Dominio de 11 clases conceptuales** con generalización (`Persona`) y clases de asociación (`H-04`, commit `9209ff2`).
4. Se formalizó el **MER en notación Pata de Gallo** con 9 entidades, resolución N:M (`ASIGNACION_INSTRUCTOR_FICHA`, `REGISTRO_ASISTENCIA`) y entidad débil (`NOVEDAD_CONTINGENCIA`) (`H-05`, commit `9209ff2`).
5. Se rotularon las 4 pantallas de prototipo de semana 17 con su caso de uso y requisitos (`H-06`, commit `9209ff2`).
6. En el cierre del Día 2 (`2026-11-23`), se completó la verificación inversa `CU → RF` (`12/12` sin huérfanos), la validación de entidades del MER hacia diseño y los enlaces directos a los commits del Día 1 (`H-07`).

Tras aplicar los ajustes, la **segunda verificación obtuvo 18 / 18 criterios cumplidos (100 %)**, confirmando consistencia bidireccional entre requisitos, modelos conceptuales, flujo de actividades, datos y prototipos de interfaz.

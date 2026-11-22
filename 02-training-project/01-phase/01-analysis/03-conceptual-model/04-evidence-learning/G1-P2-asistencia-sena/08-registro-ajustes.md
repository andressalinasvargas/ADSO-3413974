# Registro de Hallazgos, Ajustes y Segunda Verificación

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Formato:** Anexo D de `Plantilla_README_Entrega_G1.md`  
**Responsable:** `@andressalinasvargas`

---

## 1. Registro de Ajustes (6 Hallazgos Corregidos y Re-verificados)

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes (Insumo semanas 16–17) | Después (Entrega G1-P1 / G1-P2) | Commit de referencia | ¿Se verificó de nuevo? |
| :- | :--- | :--- | :--- | :--- | :--- | :---: |
| **H-01** | Diagrama de casos de uso incompleto: solo 1 actor, 5 casos y subpasos de UI incluidos como casos (`G1-P1 C4`) | `G1-P1/03-diagrama-casos-uso.drawio` | `Diagramas_UML_Asistencia_SENA.drawio` (semana 16) tenía solo `Instructor`, `UC01`–`UC05` y 3 elipses de UI (*Mostrar lista*, *Guardar registro*) | Frontera definida, 3 actores primarios + 2 secundarios fuera de la frontera, **12 casos de uso** con verbo + objeto y cobertura 100 % de `RF-01`–`RF-12` | Día 1 (2026-11-22) · ajuste de trazabilidad Día 2 | Sí (Criterios 4 y 6 de lista de chequeo) |
| **H-02** | Requisitos funcionales y no funcionales mezclados sin matriz ni RNF separados (`G1-P1 C3`) | `G1-P1/00-insumo-srs-base.md` y `04-matriz-rf-casos-uso.md` | `Tema Tomar asistencia_0.1.txt` mezclaba necesidades técnicas de escalabilidad con RF sin sección formal de RNF | Separación estricta de `RF-01`–`RF-12` y `RNF-01`–`RNF-06`, con explicación explícita de por qué los RNF no son casos de uso | Día 1 (2026-11-22) | Sí (Criterio 5 de lista de chequeo) |
| **H-03** | Ausencia de relaciones `«extend»`, puntos de extensión y justificación de relaciones (`G1-P1 C4`) | `G1-P1/03-diagrama-casos-uso.drawio` y `03-justificacion-relaciones-cu.md` | El diagrama original solo tenía `«include»` hacia subpasos técnicos y ninguna justificación escrita | Incorporadas 4 relaciones `«include»` válidas (`CU-05`, `CU-06`) y 4 `«extend»` (`CU-09`, `CU-10`) con flecha hacia el caso base, punto de extensión y justificación de 1 línea | Día 1 (2026-11-22) | Sí (Criterio 7 de lista de chequeo) |
| **H-04** | Diagrama de clases de semana 16 mezclaba métodos de programación, IDs técnicos y omitía generalización (`G1-P2 C3`) | `G1-P2/04-modelo-dominio.drawio` y `04-modelo-dominio-descripcion.md` | `Diagramas_UML_Asistencia_SENA.drawio` tenía solo 3 clases (`Instructor`, `Asistencia`, `Aprendiz`) con métodos (`+ guardar()`) e `id*` | Modelo de dominio puro con **11 clases conceptuales** sin métodos ni claves técnicas, atributos de negocio, generalización `Persona` y clases de asociación `AsignacionInstructor` y `RegistroAsistencia` | Día 1 (2026-11-22) | Sí (Criterios 11 y 12 de lista de chequeo) |
| **H-05** | Modelo de datos carecía de notación formal declarada, entidad débil y resolución N:M explícita de instructores (`G1-P2 C4`) | `G1-P2/05-modelo-entidad-relacion.drawio` y `05-mer-descripcion.md` | No existía MER formal de `asistencia-sena` en semana 16/17; solo apuntes de clases en texto | MER completo en notación **Pata de gallo** con **9 entidades**, 2 relaciones N:M resueltas con entidad asociativa (`ASIGNACION_INSTRUCTOR_FICHA`, `REGISTRO_ASISTENCIA`) y entidad débil `NOVEDAD_CONTINGENCIA` | Día 1 (2026-11-22) | Sí (Criterio 14 de lista de chequeo) |
| **H-06** | Mockups originales sin rótulo del caso de uso al que atienden ni vínculo en plantillas (`G1-P2 C5`) | `G1-P2/06-prototipo-inicial/` | Imágenes sueltas en `03-execute/17-week/02-optional-activity/` sin etiqueta de caso de uso ni tabla de trazabilidad | 4 pantallas rotuladas (`pantalla-01-cu03` a `pantalla-04-cu12`) vinculadas directamente desde cada plantilla extendida y desde la matriz de trazabilidad | Día 1 (2026-11-22) | Sí (Criterio 15 de lista de chequeo) |

---

## 2. Resultado de la Segunda Verificación

Tras incorporar los 6 ajustes en los artefactos de `G1-P1-asistencia-sena` y `G1-P2-asistencia-sena`, se ejecutó la segunda verificación sobre los **18 criterios** de `07-lista-chequeo-validacion.md`, obteniendo **18 / 18 criterios en estado Sí (100 %)**. En la iteración del **Día 2** (antes de la entrega final) se actualizarán los enlaces exactos a los commits publicados en GitHub y se realizará la auditoría final previa al sábado 28 de noviembre.

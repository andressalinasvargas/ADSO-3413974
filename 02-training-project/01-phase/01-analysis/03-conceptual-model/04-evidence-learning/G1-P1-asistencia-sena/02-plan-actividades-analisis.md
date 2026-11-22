# Plan de Actividades de Análisis (Marco Scrum Iterativo)

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Metodología:** Scrum adaptado a iteraciones cortas con priorización MoSCoW  
**Insumo reutilizado:** `03-execute/18-week/02-optional-activity/MOSCOW.jpeg` y `03-execute/18-week/02-optional-activity/DESIGN THINKING.jpeg`  
**Responsable:** `@andressalinasvargas`

---

## 1. Enfoque del Plan (Coherencia con Scrum)

En coherencia con la selección de **Scrum**, el trabajo de análisis se organiza en **dos Sprints de Análisis y Verificación** dentro de la ventana del **22 al 27 de noviembre de 2026**, priorizando primero los elementos de valor crítico (*Must Have*: alcance, casos de uso core, seguridad/consentimiento y contingencia) y ejecutando revisiones tempranas con retroalimentación verificable mediante listas de chequeo antes del cierre del producto.

---

## 2. Cronograma y Plan de Actividades Priorizadas (8 Actividades)

| ID | Sprint / Iteración | Actividad de Análisis | Prioridad (MoSCoW) | Responsable | Fecha planificada | Entregable verificable |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **ACT-01** | Sprint 1 · Inicio y Backlog | Consolidar el informe de requisitos (`RF-01`–`RF-12` y `RNF-01`–`RNF-06`) diferenciando requisitos funcionales y no funcionales a partir de los apuntes de semana 16, 17 y 19. | Must | `@andressalinasvargas` | 2026-11-22 | [00-insumo-srs-base.md](00-insumo-srs-base.md) |
| **ACT-02** | Sprint 1 · Inicio y Backlog | Caracterizar la solución en sus 4 dimensiones y seleccionar la metodología mediante matriz comparativa de 4 enfoques (RUP, Scrum, XP, RAD). | Must | `@andressalinasvargas` | 2026-11-22 | [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md) y [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md) |
| **ACT-03** | Sprint 1 · Modelado Funcional | Refinar el diagrama de casos de uso UML (evolución del archivo de semana 16): incorporar actores secundarios, frontera, 12 CU y relaciones `«include»`/`«extend»` justificadas. | Must | `@andressalinasvargas` | 2026-11-22 | [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio), [03-diagrama-casos-uso.png](03-diagrama-casos-uso.png) y [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md) |
| **ACT-04** | Sprint 1 · Trazabilidad Inicial | Elaborar la matriz de cobertura `RF → Caso de Uso` verificando cobertura del 100 % de los RF y exclusión justificada de los RNF. | Must | `@andressalinasvargas` | 2026-11-22 | [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md) |
| **ACT-05** | Sprint 2 · Detalle Comportamental | Diseñar 2 diagramas de actividades UML (autorregistro y ciclo concurrente de sesión) y redactar 4 plantillas extendidas de casos de uso críticas en lenguaje de negocio. | Must | `@andressalinasvargas` | 2026-11-22 al 2026-11-24 | `01-actividad-cu04-registro-qr.*`, `02-actividad-cu03-cu11-ciclo-sesion.*` y `03-plantillas-casos-uso.md` (en `G1-P2`) |
| **ACT-06** | Sprint 2 · Modelado Estructural | Construir el Modelo de Dominio (11 clases conceptuales sin métodos ni FK, generalización y clases de asociación) y el MER en pata de gallo (9 entidades, N:M resuelta y entidad débil). | Must | `@andressalinasvargas` | 2026-11-22 al 2026-11-24 | `04-modelo-dominio.*` y `05-modelo-entidad-relacion.*` (en `G1-P2`) |
| **ACT-07** | Sprint 2 · Prototipo y Revisión | Rotular 4 pantallas de prototipo inicial reutilizando los mockups de semana 17 y aplicar la lista de chequeo (18 criterios) sobre P1 y P2 para detectar hallazgos. | Should | `@andressalinasvargas` | 2026-11-23 | `06-prototipo-inicial/*` y `07-lista-chequeo-validacion.md` (en `G1-P2`) |
| **ACT-08** | Sprint 2 · Cierre y Retrospectiva | Ejecutar ajustes detectados en la revisión (commits en día 2 distinto), registrar segunda verificación, emitir matriz de trazabilidad completa e informe final de análisis. | Must | `@andressalinasvargas` | 2026-11-24 al 2026-11-25 | `08-registro-ajustes.md`, `09-matriz-trazabilidad.md`, `10-informe-analisis.md` y `README.md` actualizados |

# Plan de Actividades de Análisis · Fotocopiadora SyP

Bajo la metodología seleccionada (**Scrum** en [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md)), la fase de análisis se ejecuta en **dos incrementos cortos** (Ventana del **21 al 28 de noviembre de 2026**), priorizando primero el entendimiento del dominio comercial/técnico, luego el modelado funcional y finalmente la verificación integral previa al cierre de entrega.

---

## Cronograma y Plan de Actividades Priorizadas

| ID | Prioridad (Scrum) | Actividad de análisis | Responsable | Fecha límite | Entregable verificable |
|---|---|---|---|---|---|
| `ACT-01` | Alta (Sprint 1) | Consolidar el insumo SRS base separando `12` requisitos funcionales y `8` no funcionales libres de detalles técnicos. | `@andressalinasvargas` | `2026-11-25` | [00-insumo-srs-base.md](00-insumo-srs-base.md) |
| `ACT-02` | Alta (Sprint 1) | Caracterizar la solución en los 4 aspectos obligatorios, comparar 4 metodologías y justificar la selección de Scrum. | `@andressalinasvargas` | `2026-11-25` | [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md) |
| `ACT-03` | Alta (Sprint 1) | Modelar el diagrama de casos de uso UML (frontera, actores primarios/secundarios, `«include»`, `«extend»` y generalización) y documentar justificaciones. | `@andressalinasvargas` | `2026-11-25` | [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio), [`.png`](03-diagrama-casos-uso.png), [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md) |
| `ACT-04` | Alta (Sprint 1) | Construir la matriz bidireccional `RF → Caso de Uso` verificando cobertura >= 90 % y auditoría inversa `CU → RF`. | `@andressalinasvargas` | `2026-11-25` | [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md) |
| `ACT-05` | Alta (Sprint 2) | Elaborar `2` diagramas de actividades de casos de uso críticos (`CU-03` y `CU-09`) y `3` plantillas extendidas coherentes entre sí. | `@andressalinasvargas` | `2026-11-25` | Diagramas de actividades y plantillas extendidas en `G1-P2-fotocopiadora-syp/` |
| `ACT-06` | Media-Alta (Sprint 2) | Abstraer el modelo de dominio (clases conceptuales sin métodos ni claves foráneas) y diseñar el MER en notación Pata de gallo con entidad débil y N:M resueltas. | `@andressalinasvargas` | `2026-11-25` | Modelos conceptuales de dominio y MER en `G1-P2-fotocopiadora-syp/` |
| `ACT-07` | Media (Sprint 2) | Construir prototipo inicial (4 pantallas rotuladas por CU) y ejecutar la verificación con lista de chequeo (>= 15 criterios). | `@andressalinasvargas` | `2026-11-26` | Prototipo inicial y lista de chequeo diligenciada en `G1-P2-fotocopiadora-syp/` |
| `ACT-08` | Alta (Cierre Sprint 2) | Aplicar correcciones de los hallazgos detectados, ejecutar segunda verificación (Día 2), emitir informe de análisis y cerrar matriz de trazabilidad. | `@andressalinasvargas` | `2026-11-27` | Registro de ajustes, segunda verificación, matriz Anexo C e informe final en `G1-P2-fotocopiadora-syp/` |

---

## Criterios de Terminado (Definition of Done)

1. Cada actividad produce un archivo versionado con enlaces relativos válidos y sin datos personales reales.
2. Los cambios del Incremento 1 y del Incremento 2 quedan registrados en **al menos 2 días calendario distintos** antes del **sábado 28 de noviembre de 2026 a las 6:00 a. m.**.
3. Ningún caso de uso, plantilla o modelo de dominio mezcla nombres de tecnologías de implementación, tablas de base de datos ni protocolos técnicos.

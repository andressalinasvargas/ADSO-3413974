# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) · [`G1-P2-fotocopiadora-syp/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/10-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el proyecto del año (**Fotocopiadora SyP**) se desarrolló en equipo de `2` integrantes (`@andressalinasvargas` y `@Kevin81A`), pero el consolidado analítico en `G1-P1-fotocopiadora-syp`/`G1-P2-fotocopiadora-syp` y todo este diseño de datos son elaboración individual propia. |
| ¿Qué parte del SRS es tuya? | El 100 % de los `12 RF`, `8 RNF` y el MER base de `11` entidades documentados en `G1-P2-fotocopiadora-syp`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, trabajo individual y diferenciado (`12` tablas propias, normalización sobre `planilla_cotizacion_bruta` y `registro_servicio_tecnico_bruto`, SQL validado en SQLite). |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. No se copió ningún archivo de datos ni SQL del otro integrante. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
| :--- | :--- | :--- | :--- |
| **B1.** Modelo conceptual ajustado | [01-modelo-conceptual.md](01-modelo-conceptual.md) · [`.drawio`](01-modelo-conceptual.drawio) · [`.svg`](01-modelo-conceptual.svg) | [`G1-P2-fotocopiadora-syp/05-modelo-entidad-relacion.drawio`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/05-modelo-entidad-relacion.drawio) | Formalicé `11` entidades Crow's Foot con justificación de BD relacional (`4` razones), `2` N:M resueltas, relación recursiva `PRODUCTO` y entidad débil `NOTIFICACION`. |
| **B2.** Modelo lógico relacional | [02-modelo-logico-y-transformacion.md](02-modelo-logico-y-transformacion.md) · [`.drawio`](02-modelo-logico.drawio) · [`.svg`](02-modelo-logico.svg) | Nuevo (transformado desde `B1`) | Transformé el modelo en **`12` tablas** con PK, FK, tabla puente recursiva `compatibilidad_producto` y cuadro de `7` reglas aplicadas. |
| **B3.** Evidencia de normalización `0FN → 3FN` | [03-normalizacion.md](03-normalizacion.md) | Nuevo | Normalicé paso a paso `planilla_cotizacion_bruta` (llave compuesta) y `registro_servicio_tecnico_bruto` (dependencia transitiva) con DF explícitas y justificación histórica de `precio_unitario_*`. |
| **B4.** Diccionario de datos | [04-diccionario-datos.md](04-diccionario-datos.md) | Nuevo | Documenté estándar `snake_case` singular y el `100 %` de columnas de las `12` tablas con tipo, tamaño, restricciones y dominio. |
| **B5.** Script SQL y evidencia de ejecución | [05-script-creacion.sql](05-script-creacion.sql) · [05-evidencia-ejecucion-sql.md](05-evidencia-ejecucion-sql.md) · [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt) | Nuevo | Construí script DDL (`12` tablas, `12` PK, `12` FK con `ON DELETE`, `33` `CHECK` y carga sintética sin PII) y lo ejecuté realmente en **SQLite 3** (`4/4` pruebas negativas rechazadas con `IntegrityError`). |
| **B6.** Políticas de seguridad y roles | [06-politicas-seguridad-datos.md](06-politicas-seguridad-datos.md) | Nuevo | Definí `9` políticas (`BCrypt` hash+sal, `TLS 1.3`, Ley 1581 `is_owner`, CSV seguro, respaldo diario y prueba mensual) y matriz de `4` roles × `12` tablas. |
| **B7.** Lista de chequeo y hallazgos | [07-lista-chequeo-verificacion.md](07-lista-chequeo-verificacion.md) | Nuevo | Apliqué `24` criterios medibles sobre `G2-P1` y `G2-P2` con evidencia y `4` hallazgos (`H-01`–`H-03` cerrados hoy; `H-04` programado para cierre Día 2). |

**Qué reutilicé (resumen):**
Partí del MER de `11` entidades y los `12 RF`/`8 RNF` elaborados por mí en `G1-P2-fotocopiadora-syp`, conservando las reglas del catálogo, compras como invitado, servicio técnico, contadores de renting y notificaciones.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**
Alineé los nombres de entidades hacia `snake_case` singular, definí claves foráneas anulables (`ON DELETE SET NULL`) para compras/citas de visitantes y agregué la restricción `id_equipo <> id_insumo` en compatibilidad recursiva.

**Qué hice completamente nuevo (resumen):**
Construí desde cero las `12` tablas lógicas, la normalización formal `0FN → 3FN` de dos tablas propias, el diccionario completo, el script SQL con `33` `CHECK` validado con pruebas negativas reales en SQLite, las `9` políticas de seguridad y los `24` criterios de evaluación.

---

## 4. Autoverificación de mínimos

- [x] **B1** Modelo conceptual: `11` entidades (`≥ 6`), cardinalidades mín/máx, `2` N:M, recursiva y `1:N`, justificación de BD relacional.
- [x] **B2** Modelo lógico: `12` tablas (`≥ 8`) con PK/FK y cuadro de `7` reglas de transformación.
- [x] **B3** Normalización: `2` tablas propias `0FN → 3FN` con DF escritas (una con llave compuesta y una con dependencia transitiva).
- [x] **B4** Diccionario de datos completo (`12/12` tablas coincidentes 1:1 con el script SQL).
- [x] **B5** Script SQL ejecutado sin errores ([05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt)), `ON DELETE` en las `12` FK y `33` `CHECK`.
- [x] **B6** `9` políticas de seguridad (hash+sal `BCrypt`, `TLS 1.3`, Ley 1581, respaldo/restauración) y matriz de `4` roles × `12` tablas.
- [x] **B7** Lista de chequeo de `24` criterios (`≥ 20`), diligenciada sobre `G2-P1` y `G2-P2`, con evidencia y `4` hallazgos (`3` cerrados, `H-04` para cierre Día 2).

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-27` (Día 1) | `feat(g2-p2): agregar modelo conceptual, logico 12 tablas, normalizacion 3FN, DDL verificado en SQLite y seguridad de fotocopiadora-syp` — Construcción de `B1`–`B7` y validación real en SQLite 3 (`ExitCode = 0`). |
| *`2026-11-28` (Día 2 programado antes `06:00 a. m.`)* | Cierre de auditoría cruzada `H-04` (`P1 ↔ P2` contra `POL-*`), completando `24/24` criterios y cumpliendo los `2` días calendario distintos de `push`. |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en redacción de tablas de normalización 3FN, diccionario de datos, sintaxis DDL ANSI/SQLite y generación XML `.drawio`/`.svg` de los diagramas `B1`–`B2`. | Ejecuté personalmente `05-script-creacion.sql` en motor SQLite real con `PRAGMA foreign_keys = ON` (`4/4` pruebas negativas `IntegrityError`), verifiqué concordancia columna por columna entre `B2`, `B4` y `B5`, y comprobé ausencia de datos personales reales. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) · [`G1-P2-fotocopiadora-syp/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/10-informe-analisis.md)
- Carpeta de esta entrega en GitHub: [`G2-P2-fotocopiadora-syp`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp)
- Carpeta par Producto 1: [`G2-P1-fotocopiadora-syp`](../G2-P1-fotocopiadora-syp/README.md)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@andressalinasvargas`  Fecha: `2026-11-27`

# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) · [`G1-P2-asistencia-sena/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/10-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | No, fue consolidado individualmente desde mi trabajo del año en `03-execute/`. |
| ¿Qué parte del SRS es tuya? | El 100 % (`RF-01`–`RF-12`, `RNF-01`–`RNF-06`, MER base y modelo de dominio). |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, elaboración individual completa. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
| :--- | :--- | :--- | :--- |
| **B1.** Modelo conceptual ajustado | [01-modelo-conceptual.md](01-modelo-conceptual.md) · [`.drawio`](01-modelo-conceptual.drawio) · [`.svg`](01-modelo-conceptual.svg) | [`G1-P2-asistencia-sena/05-modelo-entidad-relacion.drawio`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/05-modelo-entidad-relacion.drawio) | Evolucioné `INSTRUCTOR` hacia `USUARIO_SISTEMA` con roles, añadí atributo multivaluado `telefonos{}` en `APRENDIZ`, especifiqué geocerca en `SEDE`, cardinalidades mín/máx y trazabilidad a requisitos. |
| **B2.** Modelo lógico relacional y reglas | [02-modelo-logico-y-transformacion.md](02-modelo-logico-y-transformacion.md) · [`.drawio`](02-modelo-logico.drawio) · [`.svg`](02-modelo-logico.svg) | Nuevo (transformado desde `B1`) | Generé **10 tablas** con PK/FK, tabla intermedia N:M, tabla multivaluada `telefono_aprendiz`, entidad débil y cuadro completo de 7 reglas de transformación. |
| **B3.** Normalización `0FN → 3FN` | [03-normalizacion.md](03-normalizacion.md) | Nuevo | Normalicé paso a paso 2 tablas de mi propio modelo (`planilla_asistencia_bruta` con llave compuesta y `ficha_programa_sede_bruta` con dependencias transitivas), explicando dependencias funcionales y `tarde_minutos`. |
| **B4.** Diccionario de datos | [04-diccionario-datos.md](04-diccionario-datos.md) | Nuevo | Documenté estándar de nombrado (`snake_case`, singular) y el 100 % de las 10 tablas y columnas con tipo, tamaño, restricciones y dominio. |
| **B5.** Script SQL y evidencia de ejecución | [05-script-creacion.sql](05-script-creacion.sql) · [05-evidencia-ejecucion-sql.md](05-evidencia-ejecucion-sql.md) · [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt) | Nuevo (rediseñado y ampliado desde `G1` + esquema base) | Construí script DDL para MariaDB 10.11 (`10` tablas, `11` FK con `ON DELETE`/`ON UPDATE`, `22` `CHECK` nombrados) y lo validé en Día 2 (`2026-11-24`) en motor real `SQLite 3.53.1` (`PRAGMA foreign_keys = ON`, `10/10` tablas y `4/4` pruebas negativas rechazadas). |
| **B6.** Políticas de seguridad y matriz de roles | [06-politicas-seguridad-datos.md](06-politicas-seguridad-datos.md) | Nuevo | Definí **9 políticas** (3 por principio: integridad, confidencialidad con `BCrypt`/TLS/Ley 1581, disponibilidad con respaldo y prueba mensual) y matriz de **4 roles × 10 tablas**. |
| **B7.** Lista de chequeo y hallazgos (`P1` + `P2`) | [07-lista-chequeo-verificacion.md](07-lista-chequeo-verificacion.md) | Nuevo | Estructuré **24 criterios medibles** con severidad y evidencia sobre `G2-P1` y `G2-P2`, más **5 hallazgos (`H-01`–`H-05`)**. |

**Qué reutilicé (resumen):**
Tomé como base el Modelo Entidad-Relación de 9 entidades creado en `G1-P2-asistencia-sena`, manteniendo la entidad débil `NOVEDAD_CONTINGENCIA` y las entidades asociativas de asignación y registro de asistencia.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**
Adapté el modelo conceptual hacia el motor relacional MariaDB (`USUARIO_SISTEMA` con roles y credenciales hash+sal, atributo multivaluado de teléfonos de aprendices, restricciones de dominio en geocerca y trazabilidad directa contra `RF-01`–`RF-12`).

**Qué hice completamente nuevo (resumen):**
Elaboré desde cero el modelo lógico de 10 tablas con cuadro de transformación, la normalización formal `0FN → 3FN`, el diccionario de datos completo, el script DDL con `CHECK` y `ON DELETE`, las 9 políticas de seguridad con matriz de 4 roles y la lista de verificación de 24 criterios.

---

## 4. Autoverificación de mínimos (`B1`–`B7`)

- [x] **B1** Modelo conceptual ([01-modelo-conceptual.md](01-modelo-conceptual.md)): `9` entidades (`≥ 6`), cardinalidades mín/máx y verbos, `2` N:M y `7` 1:N, justificación de BD relacional.
- [x] **B2** Modelo lógico ([02-modelo-logico-y-transformacion.md](02-modelo-logico-y-transformacion.md)): `10` tablas (`≥ 8`) con PK/FK, diagrama editable/exportado y cuadro de reglas de transformación.
- [x] **B3** Normalización ([03-normalizacion.md](03-normalizacion.md)): `2` tablas llevadas de `0FN` a `3FN` con DF explícitas (una con llave compuesta y otra con dependencia transitiva).
- [x] **B4** Diccionario de datos ([04-diccionario-datos.md](04-diccionario-datos.md)): `100 %` de las `10` tablas y columnas coincidiendo exactamente con el modelo lógico y el script SQL.
- [x] **B5** Script SQL ejecutado sin errores ([05-script-creacion.sql](05-script-creacion.sql) · [05-evidencia-ejecucion-sql.md](05-evidencia-ejecucion-sql.md) · [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt)): DDL completo (`10` tablas, `11` FK con `ON DELETE`, `22` `CHECK`) ejecutado y verificado sin errores en `SQLite 3.53.1` (`ExitCode = 0`, `4/4` pruebas negativas de integridad aprobadas en Día 2).
- [x] **B6** Políticas de seguridad y roles ([06-politicas-seguridad-datos.md](06-politicas-seguridad-datos.md)): `9` políticas (`3` por principio), hash+sal `BCrypt`/`Argon2id`, TLS 1.3, Ley 1581, respaldo/prueba de restauración y matriz de `4` roles.
- [x] **B7** Lista de chequeo ([07-lista-chequeo-verificacion.md](07-lista-chequeo-verificacion.md)): `24` criterios medibles (`≥ 20`) aplicados a `G2-P1` y `G2-P2` con severidad, evidencia y `5` hallazgos registrados (`24/24` cumplidos tras cierre de `LC-21` y `H-05` en Día 2).

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-23` (Día 1) | [`0b9bd7e`](https://github.com/andressalinasvargas/ADSO-3413974/commit/0b9bd7e) — `feat(g2-p2): agregar modelo conceptual, logico, normalizacion 3FN, diccionario, DDL SQL y seguridad` |
| `2026-11-24` (Día 2) | `feat(g2-p2): adjuntar evidencia real de ejecucion SQL y cerrar LC-21/H-05 en Dia 2` — Ejecución real en `SQLite 3.53.1` ([05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt)), actualización de [05-evidencia-ejecucion-sql.md](05-evidencia-ejecucion-sql.md), cierre `24/24` en [07-lista-chequeo-verificacion.md](07-lista-chequeo-verificacion.md) y actualización de `README.md` |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en redacción de tablas de normalización 3FN, diccionario de datos, sintaxis DDL para MariaDB 10.11 y generación de diagramas `.drawio`/`.svg`. | Verifiqué manualmente que los 10 nombres de tabla y todas sus columnas coincidan entre modelo lógico, diccionario y DDL, moví las restricciones `CHECK` multi-columna a nivel de tabla para compatibilidad real con MariaDB y revisé que no existan datos personales reales. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) · [`G1-P2-asistencia-sena/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/10-informe-analisis.md)
- Carpeta de esta entrega en GitHub: [`G2-P2-asistencia-sena`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-asistencia-sena)
- Carpeta par Producto 1: [`G2-P1-asistencia-sena`](../G2-P1-asistencia-sena/README.md)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@andressalinasvargas`  Fecha: `2026-11-24`

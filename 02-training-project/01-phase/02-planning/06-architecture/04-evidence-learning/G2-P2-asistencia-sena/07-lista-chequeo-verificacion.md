# B7 · Lista de Chequeo de Diseño y Registro de Hallazgos (`G2-P1` y `G2-P2`)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Verificación de los entregables de diseño (`RAP 593102`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-24` *(Segunda verificación — Día 2)*

---

## 1. Lista de Chequeo Aplicada a P1 y P2 (`24` Criterios Verificables)

| ID | Artefacto | Criterio de aceptación (medible) | Severidad | ¿Cumple? | Evidencia exacta en el repositorio |
| :- | :--- | :--- | :---: | :---: | :--- |
| **LC-01** | Ficha (`A1`) | Incluye `≥ 8` RF y `≥ 3` RNF con ID exacto y plataforma (lenguaje OO + tipo BD) justificada con `≥ 3` condiciones del caso | Mayor | Sí | [`G2-P1/01-ficha-interpretacion-y-plataforma.md`](../G2-P1-asistencia-sena/01-ficha-interpretacion-y-plataforma.md): `12` RF, `6` RNF y 4 condiciones por tecnología. |
| **LC-02** | Clases (`A2`) | Incluye `≥ 8` clases con visibilidad, atributos tipados y métodos con parámetros y retorno | Crítico | Sí | [`G2-P1/02-diagrama-clases-y-patrones.md`](../G2-P1-asistencia-sena/02-diagrama-clases-y-patrones.md) y `.drawio`/`.svg`: `19` elementos (`17` clases + `2` interfaces). |
| **LC-03** | Clases (`A2`) | Aplica `≥ 1` herencia/interfaz (con `≥ 2` implementaciones) y `≥ 1` composición o agregación con multiplicidades completas | Crítico | Sí | Herencia `Persona` ⇐ `UsuarioSistema`/`Aprendiz`; interfaz `IEstrategiaRegistro` con `3` impl.; agregación `FichaFormacion o-- Aprendiz`; 2 composiciones (`*--`). |
| **LC-04** | Clases (`A2`) | Ninguna clase mezcla responsabilidades de UI, lógica de negocio, persistencia y reportes (alta cohesión) | Mayor | Sí | [`G2-P1/02-diagrama-clases-y-patrones.md`](../G2-P1-asistencia-sena/02-diagrama-clases-y-patrones.md): UI solo en `WebApp*`, persistencia detrás de `IRepositorioAsistencia`, reportes en `ServicioReportes`. |
| **LC-05** | Clases (`A2`/`A7`) | El `100 %` de clases/interfaces traza hacia al menos un requisito funcional o no funcional | Mayor | Sí | [`G2-P1/06-matriz-trazabilidad-diseno.md`](../G2-P1-asistencia-sena/06-matriz-trazabilidad-diseno.md) §2: `19/19` clases trazadas (`0` huérfanas). |
| **LC-06** | Patrones (`A3`) | Incorpora `≥ 2` patrones GoF distintos (al menos uno distinto de Singleton) reflejados en el diagrama con problema y mejora documentada | Crítico | Sí | [`G2-P1/02-diagrama-clases-y-patrones.md`](../G2-P1-asistencia-sena/02-diagrama-clases-y-patrones.md) §3: **Estrategia** (`IEstrategiaRegistro`) y **Fachada** (`FachadaControlAsistencia`). |
| **LC-07** | Arquitectura (`A4`) | Define estilo arquitectónico con diagrama editable/exportado, comunicación entre capas y `0` saltos de capa | Crítico | Sí | [`G2-P1/03-arquitectura-software.md`](../G2-P1-asistencia-sena/03-arquitectura-software.md) + `.drawio`/`.svg`: 3 capas estrictas; UI no accede directo a Capa 3. |
| **LC-08** | Arquitectura (`A4`) | Documenta tabla con `≥ 3` RNF atendidos por decisiones concretas y alternativa descartada justificada | Mayor | Sí | [`G2-P1/03-arquitectura-software.md`](../G2-P1-asistencia-sena/03-arquitectura-software.md) §2: cubre los `6` RNF (`RNF-01`–`RNF-06`) + estilo. |
| **LC-09** | Componentes (`A5`) | Incluye `≥ 5` componentes con interfaces provistas y requeridas nombradas y mapeo a clases y requisitos | Mayor | Sí | [`G2-P1/04-vista-componentes.md`](../G2-P1-asistencia-sena/04-vista-componentes.md) + `.drawio`/`.svg`: `8` componentes mapeando las `19` clases/interfaces. |
| **LC-10** | Despliegue (`A6`) | Modela `≥ 3` nodos con artefactos alojados, protocolo/puerto en cada conexión y relación con RNF | Mayor | Sí | [`G2-P1/05-vista-despliegue.md`](../G2-P1-asistencia-sena/05-vista-despliegue.md) + `.drawio`/`.svg`: `4` nodos con `HTTPS 443 (TLS 1.3)` y `TCP 3306` privado. |
| **LC-11** | Trazabilidad (`A7`) | Cubre `100 %` de los RF del SRS desde requisito hacia clase, tabla, componente y decisión | Crítico | Sí | [`G2-P1/06-matriz-trazabilidad-diseno.md`](../G2-P1-asistencia-sena/06-matriz-trazabilidad-diseno.md) §1: `12/12` RF y `6/6` RNF cubiertos. |
| **LC-12** | Diagramas (`P1`/`P2`) | Todos los diagramas cuentan con fuente editable (`.drawio`) e imagen exportada (`.svg`) legible | Menor | Sí | Archivos `.drawio` y `.svg` presentes en `02`, `03`, `04`, `05` de P1 y `01`, `02` de P2. |
| **LC-13** | Conceptual (`B1`) | Contiene `≥ 6` entidades con identificador, atributos, cardinalidad mín/máx, verbo, `≥ 1` N:M y `≥ 1` 1:N | Crítico | Sí | [01-modelo-conceptual.md](01-modelo-conceptual.md) + `.drawio`/`.svg`: `9` entidades, `2` N:M y `7` 1:N en notación Pata de gallo. |
| **LC-14** | Conceptual (`B1`) | Documenta qué evolucionó respecto al MER de Guía 1 y vincula cada entidad con su requisito del SRS | Menor | Sí | [01-modelo-conceptual.md](01-modelo-conceptual.md) §1 y §2: 5 ajustes listados y tabla `Entidad → RF`. |
| **LC-15** | Lógico (`B2`) | Transforma todas las entidades en `≥ 8` tablas con PK/FK y cuadro completo de reglas de transformación aplicadas | Crítico | Sí | [02-modelo-logico-y-transformacion.md](02-modelo-logico-y-transformacion.md) + `.drawio`/`.svg`: `10` tablas y 7 reglas explícitas (N:M, 1:N, multivaluado, débil, generalización). |
| **LC-16** | Normalización (`B3`) | Lleva `≥ 2` tablas propias paso a paso de `0FN` a `3FN` con DF escritas (una con llave compuesta y otra con transitiva) | Crítico | Sí | [03-normalizacion.md](03-normalizacion.md): `planilla_asistencia_bruta` (compuesta) y `ficha_programa_sede_bruta` (transitiva), con DF explícitas y justificación de `tarde_minutos`. |
| **LC-17** | Diccionario (`B4`) | Declara estándar de nombrado e incluye el `100 %` de tablas y columnas con tipo, tamaño, restricciones y dominio | Crítico | Sí | [04-diccionario-datos.md](04-diccionario-datos.md): `10/10` tablas y todas sus columnas en estándar `snake_case`. |
| **LC-18** | Consistencia (`B2`/`B4`/`B5`) | Nombres de tablas, columnas, tipos y tamaños coinciden `100 %` entre modelo lógico, diccionario y script SQL | Crítico | Sí | Revisión cruzada entre `02-modelo-logico*`, `04-diccionario-datos.md` y `05-script-creacion.sql`: coincidencia exacta de las `10` tablas. |
| **LC-19** | Script SQL (`B5`) | Crea el `100 %` de las tablas con PK, FK, `NOT NULL`, `UNIQUE` y `≥ 3` restricciones `CHECK` | Crítico | Sí | [05-script-creacion.sql](05-script-creacion.sql): `10` tablas, `10` PK, `11` FK, `12` UNIQUE y `22` `CHECK` nombrados a nivel de tabla. |
| **LC-20** | Script SQL (`B5`) | Declara acción referencial explícita (`ON DELETE` / `ON UPDATE`) en `≥ 3` llaves foráneas | Mayor | Sí | [05-script-creacion.sql](05-script-creacion.sql): las `11` FK declaran `ON DELETE RESTRICT / SET NULL / CASCADE` y `ON UPDATE CASCADE`. |
| **LC-21** | Ejecución SQL (`B5`) | Adjunta evidencia real (log o captura) de ejecución sin errores del script SQL sobre motor relacional | Crítico | **Sí** | [05-evidencia-ejecucion-sql.md](05-evidencia-ejecucion-sql.md) · [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt): ejecución real en `SQLite 3.53.1` (`PRAGMA foreign_keys = ON`, `10/10` tablas, `11/11` FK, `22` `CHECK`, `4/4` pruebas negativas rechazadas, `ExitCode = 0`). |
| **LC-22** | Seguridad (`B6`) | Define `≥ 6` políticas (`≥ 2` por integridad, confidencialidad y disponibilidad) vinculadas a tablas y columnas reales | Crítico | Sí | [06-politicas-seguridad-datos.md](06-politicas-seguridad-datos.md) §1: `9` políticas (`3` por principio) con medida concreta sobre tablas del caso. |
| **LC-23** | Seguridad (`B6`) | Exige contraseñas con hash y sal (`BCrypt`/`Argon2id`, nunca «cifradas»), tránsito TLS, Ley 1581 y matriz de `≥ 3` roles | Crítico | Sí | [06-politicas-seguridad-datos.md](06-politicas-seguridad-datos.md) §1–§2: `POL-CON-01/02/03`, respaldo + prueba de restauración y matriz de `4` roles × `10` tablas. |
| **LC-24** | Privacidad (`P1`/`P2`) | Los archivos públicos no exponen nombres completos reales, documentos, teléfonos ni correos personales | Crítico | Sí | Autoría con `@andressalinasvargas`; datos de prueba en DDL estrictamente sintéticos (`900000001`, `example.invalid`, `192.0.2.10`). |

---

## 2. Registro de Hallazgos y Correcciones Aplicadas (`H-01` a `H-05`)

| ID | Artefacto | Descripción del hallazgo detectado | Requisito afectado | Severidad | Corrección aplicada en el diseño |
| :- | :--- | :--- | :--- | :---: | :--- |
| **H-01** | Clases (`A2`/`A3`) | El diseño heredado de análisis mezclaba lógica de 3 canales dentro de un mismo flujo y carecía de desacoplamiento para reportes y persistencia. | `RF-05`, `RF-08`, `RF-09`, `RF-12` | Crítico | Se introdujo **Estrategia** (`IEstrategiaRegistro`) con 3 implementaciones, **Fachada** (`FachadaControlAsistencia`), interfaz `IRepositorioAsistencia` y `ServicioReportes` separado. |
| **H-02** | Arquitectura (`A4`) | Existía acoplamiento directo entre controladores HTTP y consultas PDO en algunas rutas heredadas, además de verificación DDL en tiempo de ejecución. | `RNF-01`, `RNF-03` | Crítico | Se formalizó arquitectura estricta en **3 capas** eliminando saltos hacia Capa 3 desde la UI y moviendo el esquema exclusivamente a `05-script-creacion.sql`. |
| **H-03** | Conceptual / Lógico (`B1`/`B2`) | `APRENDIZ` requería almacenar más de un teléfono de contacto/emergencia sin romper la Primera Forma Normal (`1FN`), y el MER previo no modelaba roles de usuario. | `RF-01`, `RF-02` | Mayor | Se incorporó `telefonos{}` multivaluado en `APRENDIZ` → tabla hija `telefono_aprendiz` con `ON DELETE CASCADE`, y se generalizó `INSTRUCTOR` en `usuario_sistema` con discriminador `rol_sistema`. |
| **H-04** | Script SQL (`B5`) | Las restricciones `CHECK` que comparan dos columnas de la misma fila (`vence_en > inicia_en`, `fecha_fin >= fecha_inicio`) fallan si se declaran a nivel de columna en MariaDB. | `RF-03`, `RNF-06` | Mayor | Se declararon todas las `22` restricciones `CHECK` como restricciones nombradas **a nivel de tabla** (`CONSTRAINT ck_* CHECK (...)`) compatibles con MariaDB 10.11 y MySQL 8.0+. |
| **H-05** | Ejecución SQL (`B5` / `LC-21`) | Faltaba adjuntar el log real de ejecución del script `05-script-creacion.sql` sobre motor relacional. | `B5` (`Rubricas_G2.md`) | Crítico | **Resuelto en Día 2 (`2026-11-24`):** ejecutado el esquema traducido fielmente sobre motor real `SQLite 3.53.1` con `PRAGMA foreign_keys = ON`; adjuntado log [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt) (`ExitCode = 0`, `10/10` tablas, `11/11` FK, `4/4` pruebas negativas rechazadas). |

---

## 3. Resumen de Segunda Verificación (Día 2 · `2026-11-24`)

- **Criterios cumplidos tras cierre de `H-05`:** **`24 / 24` (`100 %`)** en `G2-P1` y `G2-P2`.
- **Consistencia cruzada `P1 ↔ P2`:** verificada en [`G2-P1/06-matriz-trazabilidad-diseno.md`](../G2-P1-asistencia-sena/06-matriz-trazabilidad-diseno.md) §3 (`8` componentes, `19` clases/interfaces, `10` tablas y `9` políticas `POL-*` alineadas al `100 %`).
- **Privacidad en repositorio público (`LC-24`):** cero nombres completos reales de terceros, documentos reales, teléfonos ni correos personales; únicamente `@andressalinasvargas` y datos sintéticos ficticios.

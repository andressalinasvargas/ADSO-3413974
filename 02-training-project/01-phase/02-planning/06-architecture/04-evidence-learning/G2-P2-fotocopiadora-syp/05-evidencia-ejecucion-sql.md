# B5 · Evidencia de Ejecución SQL sobre Motor Relacional (SQLite 3) — Fotocopiadora SyP

> **Propósito:** Documentar la ejecución real, reproducible y sin errores del script DDL [`05-script-creacion.sql`](./05-script-creacion.sql) de **Fotocopiadora SyP** sobre el motor relacional **SQLite 3**, verificando la creación de las `12` tablas, el cumplimiento estricto de integridad referencial (`PRAGMA foreign_keys = ON`), la carga de los `13` registros sintéticos sin PII y el rechazo efectivo de violaciones de dominio, unicidad e integridad referencial.

---

## 1. Entorno de ejecución y procedimiento reproducido

| Parámetro | Valor observado en la ejecución |
|---|---|
| **Fecha y hora de ejecución** | `2026-11-27 10:45:55` |
| **Motor relacional ejecutado** | `SQLite 3.53.1` (con `PRAGMA foreign_keys = ON`) |
| **Script fuente evaluado** | [`05-script-creacion.sql`](./05-script-creacion.sql) |
| **Log íntegro de salida** | [`05-log-ejecucion-sqlite.txt`](./05-log-ejecucion-sqlite.txt) |
| **Resultado global** | **`12/12` tablas \| `12/12` FKs \| `4/4` pruebas negativas rechazadas \| `ExitCode: 0`** |

La validación ejecutó el script completo sobre una base de datos limpia en memoria/aislada mediante el módulo estándar `sqlite3` de Python, habilitando explícitamente `PRAGMA foreign_keys = ON` antes de procesar las sentencias `CREATE TABLE` e `INSERT INTO`, y posteriormente ejecutó cuatro transacciones negativas diseñadas para comprobar que el motor rechaza datos inválidos mediante `IntegrityError`.

---

## 2. Auditoría estructural del script DDL (`05-script-creacion.sql`)

Conteo verificado automáticamente sobre el archivo fuente:

| Elemento DDL / DML | Cantidad verificada |
|---|---:|
| Sentencias `CREATE TABLE` | `12` |
| Restricciones `PRIMARY KEY` | `12` |
| Restricciones `FOREIGN KEY` | `12` |
| Cláusulas `ON DELETE` | `12` |
| Cláusulas `ON UPDATE` | `12` |
| Restricciones `UNIQUE` | `7` |
| Restricciones `CHECK` | `33` |
| Sentencias `INSERT INTO` (datos sintéticos sin PII) | `13` |

---

## 3. Verificación de tablas creadas, filas cargadas y llaves foráneas activas

La consulta de catálogo (`sqlite_master` y `PRAGMA foreign_key_list`) confirmó la creación efectiva de las `12` tablas del modelo lógico [`02-modelo-logico-y-transformacion.md`](./02-modelo-logico-y-transformacion.md):

| # | Tabla creada | Filas sintéticas cargadas | FKs activas | Estado |
|---:|---|---:|---:|---|
| 1 | `categoria` | `1` | `0` | Verificada |
| 2 | `compatibilidad_producto` | `1` | `2` | Verificada |
| 3 | `cotizacion` | `1` | `1` | Verificada |
| 4 | `detalle_cotizacion` | `1` | `2` | Verificada |
| 5 | `detalle_pedido` | `1` | `2` | Verificada |
| 6 | `mensaje_contacto` | `1` | `0` | Verificada |
| 7 | `notificacion` | `1` | `1` | Verificada |
| 8 | `pedido` | `1` | `1` | Verificada |
| 9 | `producto` | `2` | `1` | Verificada |
| 10 | `reporte_contador` | `1` | `1` | Verificada |
| 11 | `solicitud_servicio` | `1` | `1` | Verificada |
| 12 | `usuario` | `1` | `0` | Verificada |
| **Total** | **`12` tablas** | **`13` filas sintéticas** | **`12` llaves foráneas** | **OK (`ExitCode = 0`)** |

> **Nota sobre los datos de prueba:** La tabla `producto` contiene `2` registros sintéticos (`id_producto = 1` equipo multifuncional e `id_producto = 2` tóner compatible) para poder validar la relación binaria M:N `compatibilidad_producto` (`id_equipo <> id_insumo`). Todos los correos usan el dominio reservado `.invalid` (`cliente.prueba@syp-demo.invalid`) y los teléfonos usan numeración ficticia `300000000x`, sin exposición de datos personales reales.

---

## 4. Pruebas negativas de rechazo de restricciones (`IntegrityError`)

Las cuatro pruebas negativas forzaron violaciones intencionales sobre las restricciones del esquema y fueron rechazadas por el motor SQLite 3.53.1:

| Prueba | Restricción evaluada | Caso negativo intentado | Respuesta exacta del motor | Resultado |
|---|---|---|---|---|
| **Prueba 1** | `CHECK ck_comp_distintos` | Registrar compatibilidad de un producto consigo mismo (`id_equipo = id_insumo`) | `IntegrityError: CHECK constraint failed: ck_comp_distintos` | **Rechazada (`OK`)** |
| **Prueba 2** | `UNIQUE uk_rep_usuario_eq_mes` | Insertar doble reporte de contador para el mismo `id_usuario`, `modelo_equipo` y `mes_reportado` | `IntegrityError: UNIQUE constraint failed: reporte_contador.id_usuario, reporte_contador.modelo_equipo, reporte_contador.mes_reportado` | **Rechazada (`OK`)** |
| **Prueba 3** | `FK ON DELETE RESTRICT` | Eliminar una categoría referenciada por productos activos | `IntegrityError: FOREIGN KEY constraint failed` | **Rechazada (`OK`)** |
| **Prueba 4** | `CHECK ck_ped_tot` | Insertar un `pedido` cuyo `total` es menor que `subtotal` | `IntegrityError: CHECK constraint failed: ck_ped_tot` | **Rechazada (`OK`)** |

---

## 5. Trazabilidad y enlace al registro completo

- **Registro completo en texto plano:** [`05-log-ejecucion-sqlite.txt`](./05-log-ejecucion-sqlite.txt)
- **Script DDL evaluado:** [`05-script-creacion.sql`](./05-script-creacion.sql)
- **Diccionario de datos asociado:** [`04-diccionario-datos.md`](./04-diccionario-datos.md)
- **Políticas de seguridad y control de acceso:** [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md)
- **Origen de diseño (G2-P1 y G1-P2):** [Arquitectura hexagonal G2-P1](../G2-P1-fotocopiadora-syp/03-arquitectura-software.md) y [MER conceptual G1-P2](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/05-mer-descripcion.md).

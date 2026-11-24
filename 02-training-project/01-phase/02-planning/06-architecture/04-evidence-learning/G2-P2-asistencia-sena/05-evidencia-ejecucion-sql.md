# B5 · Evidencia de Ejecución del Script SQL en Motor Real

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Script evaluado:** [05-script-creacion.sql](05-script-creacion.sql) · **Log real:** [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt)

---

## 1. Estado Actual de Ejecución (Día 2 · `2026-11-24`)

- **Estado:** **Ejecutado y verificado sin errores (`ExitCode: 0`)** en motor relacional real **SQLite `3.53.1`** (`PRAGMA foreign_keys = ON`).
- **Transparencia metodológica (`Rubricas_G2.md` §4):** Al intentar levantar el contenedor `mariadb:10.11` en esta estación Windows, el daemon de Docker Desktop Linux Engine no respondió de forma desatendida (`dockerDesktopLinuxEngine` no disponible sin sesión GUI). Por ello, en lugar de fabricar un log simulado, se realizó una **ejecución real sobre SQLite `3.53.1`** (motor relacional explícitamente admitido en la rúbrica) traduciendo fielmente el DDL de [05-script-creacion.sql](05-script-creacion.sql) y conservando intactas las `10` tablas, `10` llaves primarias, `11` llaves foráneas con `ON DELETE`/`ON UPDATE`, `12` restricciones `UNIQUE`, `22` restricciones `CHECK` nombradas e inserción de carga sintética controlada, además de `4` pruebas negativas de rechazo de integridad.
- **Evidencia adjunta:** [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt).

---

## 2. Resumen de Resultados Verificados en el Log Real (`2026-11-24`)

| Verificación ejecutada | Resultado real en [05-log-ejecucion-sqlite.txt](05-log-ejecucion-sqlite.txt) | Coincidencia con script fuente |
| :--- | :--- | :---: |
| Auditoría estructural de `05-script-creacion.sql` | `10` `CREATE TABLE`, `10` `PK`, `11` `FK`, `11` `ON DELETE` / `ON UPDATE`, `12` `UNIQUE`, `22` `CHECK`, `10` `INSERT INTO` | `100 %` |
| Ejecución completa DDL + índice + carga sintética | `ExitCode = 0` (`PRAGMA foreign_keys = 1` activo) | `100 %` |
| Tablas creadas y filas insertadas | `10 / 10` tablas (`aprendiz`, `asignacion_instructor_ficha`, `ficha`, `novedad_contingencia`, `programa_formacion`, `registro_asistencia`, `sede`, `sesion_asistencia`, `telefono_aprendiz`, `usuario_sistema`), `1` fila sintética c/u | `100 %` |
| Llaves foráneas verificadas (`PRAGMA foreign_key_list`) | `11 / 11` llaves foráneas activas sobre las tablas dependientes | `100 %` |
| Prueba negativa 1 (`CHECK ck_sesion_fechas`) | Rechazada (`IntegrityError: CHECK constraint failed: ck_sesion_fechas`) | Cumple |
| Prueba negativa 2 (`UNIQUE uk_reg_aprendiz_sesion`) | Rechazada (`IntegrityError: UNIQUE constraint failed`) | Cumple |
| Prueba negativa 3 (`FK ON DELETE RESTRICT` en `ficha`) | Rechazada (`IntegrityError: FOREIGN KEY constraint failed`) | Cumple |
| Prueba negativa 4 (`CHECK ck_reg_canal`) | Rechazada (`IntegrityError: CHECK constraint failed: ck_reg_canal`) | Cumple |

---

## 3. Procedimiento de Ejecución Complementaria en MariaDB 10.11 / Docker (Producción)

Cuando se ejecute en el entorno productivo con el servicio `db` (`mariadb:10.11`) activo, el script fuente [05-script-creacion.sql](05-script-creacion.sql) corre directamente mediante:

```powershell
# 1. Levantar únicamente el contenedor de base de datos en Sistema_Asistencia
docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" up -d db --wait

# 2. Ejecutar el script DDL completo en MariaDB 10.11 y guardar la salida en un log
$sqlPath = "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\ADSO-3413974\02-training-project\01-phase\02-planning\06-architecture\04-evidence-learning\G2-P2-asistencia-sena\05-script-creacion.sql"
$logPath = "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\ADSO-3413974\02-training-project\01-phase\02-planning\06-architecture\04-evidence-learning\G2-P2-asistencia-sena\05-log-ejecucion-mariadb.txt"

Get-Content -Raw -Encoding UTF8 $sqlPath |
  docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" exec -T db mariadb -uroot -p<MARIADB_ROOT_PASSWORD> -vvv |
  Tee-Object -FilePath $logPath

# 3. Detener el contenedor temporal al finalizar
docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" stop db
```

# B5 · Evidencia de Ejecución del Script SQL en Motor Real

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Script evaluado:** [05-script-creacion.sql](05-script-creacion.sql)

---

## 1. Estado Actual de Ejecución (Día 1 · `2026-11-23`)

- **Estado:** **Pendiente de ejecución local y captura en el motor MariaDB (`Día 2 · 2026-11-24`).**
- Por transparencia académica (`Rubricas_G2.md` §3.1 B5 y C7), no se adjuntan logs simulados: la ejecución real sobre el contenedor `MariaDB 10.11` debe realizarse localmente antes del segundo push.

---

## 2. Procedimiento Exacto de Ejecución en MariaDB / Docker

### Opción A · Usando el servicio `db` (`mariadb:10.11`) de `Sistema_Asistencia/docker-compose.yml`

```powershell
# 1. Levantar únicamente el contenedor de base de datos en Sistema_Asistencia
docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" up -d db --wait

# 2. Ejecutar el script DDL completo en MariaDB 10.11 y guardar la salida en un log
$sqlPath = "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\ADSO-3413974\02-training-project\01-phase\02-planning\06-architecture\04-evidence-learning\G2-P2-asistencia-sena\05-script-creacion.sql"
$logPath = "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\ADSO-3413974\02-training-project\01-phase\02-planning\06-architecture\04-evidence-learning\G2-P2-asistencia-sena\05-log-ejecucion-mariadb.txt"

Get-Content -Raw -Encoding UTF8 $sqlPath |
  docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" exec -T db mariadb -uroot -p<MARIADB_ROOT_PASSWORD> -vvv |
  Tee-Object -FilePath $logPath

# 3. Detener el contenedor temporal al finalizar (si no se requiere activo)
docker compose -f "c:\Users\gamer\OneDrive\Documents\Sena\Proyectos\Sistema_Asistencia\docker-compose.yml" stop db
```

---

## 3. Verificaciones Esperadas en el Log Real (Día 2)

Al adjuntar `05-log-ejecucion-mariadb.txt` o captura de consola en el commit del Día 2 (`2026-11-24`), deberá comprobarse:
1. Código de salida `0` sin errores de sintaxis ni fallos en restricciones referenciales.
2. Presencia de las **`10` tablas** en `SHOW TABLES` (`aprendiz`, `asignacion_instructor_ficha`, `ficha`, `novedad_contingencia`, `programa_formacion`, `registro_asistencia`, `sede`, `sesion_asistencia`, `telefono_aprendiz`, `usuario_sistema`).
3. Listado de `information_schema.TABLE_CONSTRAINTS` verificando las `10` llaves primarias (`PRIMARY KEY`), `11` llaves foráneas (`FOREIGN KEY`), `12` restricciones únicas (`UNIQUE`) y `22` restricciones `CHECK`.
4. Inserción exitosa del conjunto sintético de prueba en todas las tablas.

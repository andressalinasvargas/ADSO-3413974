# B6 · Políticas de Seguridad de Datos y Matriz de Roles

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`

---

## 1. Políticas de Seguridad Aplicadas al Modelo (`9` Políticas: `3` por Principio)

| Principio | ID | Política y medida técnica concreta sobre las tablas de `asistencia-sena` | Control de verificación |
| :--- | :--- | :--- | :--- |
| **Integridad** | **POL-INT-01** | Garantizar la integridad referencial y de dominio directamente en el motor `InnoDB` mediante `11` llaves foráneas con acción explícita (`ON DELETE RESTRICT` en `ficha`, `usuario_sistema`, `sesion_asistencia` y `registro_asistencia`; `ON DELETE CASCADE` solo en hijas dependientes `telefono_aprendiz` y `novedad_contingencia`) y `22` restricciones `CHECK` nombradas (coordenadas GPS, radio `≤ 5000 m`, `vence_en > inicia_en`, `tarde_minutos >= 0`). | Ejecución controlada del script DDL y validación de `SQLSTATE 23000`. |
| **Integridad** | **POL-INT-02** | Impedir registros duplicados de asistencia con la restricción compuesta `uk_reg_aprendiz_sesion` en `registro_asistencia(id_aprendiz, id_sesion)` y aplicar **borrado lógico obligatorio** (`activo = 0`) en `ficha`, `usuario_sistema` y `aprendiz`, prohibiendo `DELETE` físico sobre registros históricos. | Pruebas de doble envío concurrente entre canales (solo persiste 1 fila). |
| **Integridad** | **POL-INT-03** | Inmutabilidad de auditoría operativa: `registro_asistencia.tarde_minutos`, `ip_origen`, `estado_red` y `fecha_hora` se calculan exclusivamente en el servidor y `novedad_contingencia` conserva el motivo y fecha de cada contingencia reportada por el instructor propietario. | Comparación de `creada_por` / `id_usuario` y verificación de cabeceras de servidor. |
| **Confidencialidad** | **POL-CON-01** | **Almacenamiento seguro de credenciales:** la columna `usuario_sistema.password_hash` almacena **exclusivamente un hash criptográfico unidireccional con sal única por usuario (`BCrypt` o `Argon2id`)** mediante `password_hash()` de PHP 8.3; nunca se guardan contraseñas en texto plano ni "cifradas" de forma reversible, y ninguna consulta administrativa selecciona `password_hash` para listados. | Inspección de base de datos y migración automática de claves temporales. |
| **Confidencialidad** | **POL-CON-02** | **Protección de datos en tránsito y contra inyección:** todo tráfico entre `Cliente Escritorio`/`Cliente Móvil` y `Servidor Aplicación` en producción viaja cifrado por **TLS 1.2/1.3 (`HTTPS 443`)**; las cookies de sesión utilizan `HttpOnly` + `SameSite=Lax` + `Secure` y la capa de datos usa exclusivamente sentencias preparadas PDO nativas (`ATTR_EMULATE_PREPARES => false`). | Auditoría de cabeceras TLS/cookies y pruebas de inyección en E2E. |
| **Confidencialidad** | **POL-CON-03** | **Tratamiento de datos personales (Ley 1581 de 2012 y Decreto 1377 de 2013):** los datos de contacto (`aprendiz.documento`, `email`, `telefono_aprendiz.numero_telefono`) y ubicación GPS (`latitud`, `longitud`) se recolectan únicamente con la **finalidad académica de control de asistencia** y exigen **autorización previa expresa** del aprendiz (`registro_asistencia.consentimiento_datos = 1`), visible en `politica_datos.php` con canales para ejercer derechos ARCO. En la interfaz pública del aprendiz no se exponen listas ni documentos de otros compañeros. | Validación obligatoria en `EstrategiaMovilQr` y vista pública sin fuga de datos. |
| **Disponibilidad** | **POL-DIS-01** | **Respaldo automático diario:** ejecución programada diaria de `mysqldump --single-transaction --routines sena_asistencias` en ventana nocturna, cifrado en reposo en almacenamiento externo al contenedor `sena-asistencias-db`, con retención mínima de 30 días y persistencia desacoplada en el volumen `sena_db_data`. | Registro diario de ejecución exitosa del cron y verificación de checksums. |
| **Disponibilidad** | **POL-DIS-02** | **Prueba mensual de restauración:** el primer viernes de cada mes se restaura la copia más reciente en una instancia MariaDB aislada para verificar integridad de las 10 tablas, levantando acta de recuperación con objetivos `RPO ≤ 24 h` y `RTO ≤ 2 h`. | Acta mensual firmada por el administrador de infraestructura / BD. |
| **Disponibilidad** | **POL-DIS-03** | **Continuidad operativa multi-canal y monitoreo:** ante pérdida de cámara, GPS o fallos en el navegador móvil del aprendiz, el sistema garantiza los canales alternos de **código de 6 dígitos** (`sesion_asistencia.codigo`) y **registro manual con novedad** (`novedad_contingencia`), apoyado por *healthcheck* automático en los contenedores `web` y `db`. | Pruebas E2E de contingencia manual y verificación `healthy` en Docker Compose. |

---

## 2. Matriz de Permisos por Rol frente a las `10` Tablas

| Tabla del modelo (`B2`/`B5`) | Rol 1: **Aprendiz** *(autorregistro móvil)* | Rol 2: **Instructor** *(gestión de clase)* | Rol 3: **Coordinador Académico** *(auditoría)* | Rol 4: **Administrador BD** *(operación técnica)* |
| :--- | :--- | :--- | :--- | :--- |
| **`programa_formacion`** | Sin acceso | `SELECT` | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE` *(sin `DELETE` si hay fichas)* |
| **`sede`** | `SELECT` *(solo parámetros geocerca de su sesión)* | `SELECT` | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE` |
| **`ficha`** | Sin acceso | `SELECT` *(fichas asignadas)* | `SELECT`, `INSERT`, `UPDATE` *(inactivación lógica)* | `SELECT`, `INSERT`, `UPDATE` |
| **`usuario_sistema`** | Sin acceso | `SELECT` *(solo su fila, excluyendo `password_hash`)*, `UPDATE` *(propia clave vía BCrypt)* | `SELECT` *(sin `password_hash`)*, `INSERT`, `UPDATE` *(desactivar cuentas)* | `SELECT` *(sin `password_hash` en consola)*, `INSERT`, `UPDATE` |
| **`asignacion_instructor_ficha`** | Sin acceso | `SELECT` *(solo sus asignaciones)* | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE` |
| **`aprendiz`** | `SELECT` *(validación interna de su propio documento/ficha durante el registro; no lista terceros)* | `SELECT`, `INSERT`, `UPDATE` *(alta e inactivación lógica `activo`)* | `SELECT`, `UPDATE` *(inactivación / rectificación ARCO)* | `SELECT`, `INSERT`, `UPDATE` *(supresión restringida por auditoría)* |
| **`telefono_aprendiz`** | `SELECT`, `INSERT`, `UPDATE` *(solo sus propios teléfonos vía perfil autorizado)* | `SELECT`, `INSERT`, `UPDATE` *(contacto de aprendices de sus fichas)* | `SELECT` *(solo soporte de contacto / ARCO)* | `SELECT`, `INSERT`, `UPDATE`, `DELETE` *(rectificación solicitada)* |
| **`sesion_asistencia`** | `SELECT` *(solo validar vigencia de sesión por token/código activo)* | `SELECT`, `INSERT`, `UPDATE` *(solo abrir y cerrar sesiones propias `id_usuario`)* | `SELECT` *(auditoría de sesiones)* | `SELECT`, `UPDATE` *(cierre de emergencia)* |
| **`registro_asistencia`** | `INSERT` *(exclusivamente propio autorregistro en sesión activa con `consentimiento_datos = 1`)* | `SELECT`, `INSERT` *(escáner/manual en sesiones propias)* | `SELECT` *(reportes e auditoría completa)* | `SELECT` *(solo lectura; registros inmutables para preservar auditoría)* |
| **`novedad_contingencia`** | Sin acceso directo | `SELECT`, `INSERT` *(en registros manuales de sesiones propias)* | `SELECT` *(auditoría de novedades)* | `SELECT` *(solo lectura; evidencia auditable)* |

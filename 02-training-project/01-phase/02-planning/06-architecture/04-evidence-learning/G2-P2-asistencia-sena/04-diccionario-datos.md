# B4 · Diccionario de Datos

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Motor destino:** MariaDB 10.11 / MySQL 8.0+ (`InnoDB`, juego de caracteres `utf8mb4_unicode_ci`)

---

## 1. Estándar de Nombrado Declarado

- **Tablas:** sustantivos en **singular** y `snake_case` (ejemplo: `programa_formacion`, `registro_asistencia`).
- **Columnas:** `snake_case` descriptivo en español; llaves primarias `id_<tabla>` (salvo llaves compuestas de entidades débiles o asociativas).
- **Restricciones nombradas:** `pk_*` (primaria), `fk_*` (foránea), `uk_*` (única), `ck_*` (validación `CHECK`).
- **Correspondencia:** `100 %` idéntico al modelo lógico ([02-modelo-logico-y-transformacion.md](02-modelo-logico-y-transformacion.md)) y al script DDL ([05-script-creacion.sql](05-script-creacion.sql)).

---

## 2. Especificación Completa de Tablas y Columnas (`10` Tablas)

### 2.1 Tabla `programa_formacion`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_programa` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo secuencial identificador del programa. |
| `codigo_programa` | `VARCHAR` | `20` | `NOT NULL`, `UNIQUE (uk_programa_codigo)` | Código oficial SENA del diseño curricular (ej. `228118`). |
| `nombre_programa` | `VARCHAR` | `150` | `NOT NULL` | Nombre oficial del programa de formación. |
| `nivel_formacion` | `VARCHAR` | `40` | `NOT NULL`, `DEFAULT 'Tecnólogo'`, `CHECK (ck_programa_nivel)` | Valores permitidos: `'Operario'`, `'Auxiliar'`, `'Técnico'`, `'Tecnólogo'`, `'Especialización'`. |

### 2.2 Tabla `sede`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_sede` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador de sede. |
| `nombre_sede` | `VARCHAR` | `120` | `NOT NULL`, `UNIQUE (uk_sede_nombre)` | Nombre único de la sede SENA. |
| `latitud_sede` | `DECIMAL` | `10,7` | `NOT NULL`, `CHECK (ck_sede_lat)` | Latitud WGS84 en rango `-90.0000000` a `90.0000000`. |
| `longitud_sede` | `DECIMAL` | `10,7` | `NOT NULL`, `CHECK (ck_sede_lng)` | Longitud WGS84 en rango `-180.0000000` a `180.0000000`. |
| `radio_max_metros` | `INT` | n/a | `NOT NULL`, `DEFAULT 300`, `CHECK (ck_sede_radio)` | Radio de geocerca en metros (`> 0` y `<= 5000`). |

### 2.3 Tabla `ficha`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_ficha` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador de ficha. |
| `numero_ficha` | `VARCHAR` | `30` | `NOT NULL`, `UNIQUE (uk_ficha_numero)` | Código numérico único de la ficha (ej. `3413974`). |
| `jornada` | `VARCHAR` | `30` | `NOT NULL`, `DEFAULT 'Diurna'`, `CHECK (ck_ficha_jornada)` | Valores permitidos: `'Diurna'`, `'Nocturna'`, `'Mixta'`, `'Fin de semana'`. |
| `activa` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (ck_ficha_activa)` | Estado lógico: `1` (activa) o `0` (inactiva). |
| `id_programa` | `INT` | n/a | `NOT NULL`, `FK -> programa_formacion(id_programa) ON DELETE RESTRICT ON UPDATE CASCADE` | Programa curricular al que pertenece la ficha. |
| `id_sede` | `INT` | n/a | `NOT NULL`, `FK -> sede(id_sede) ON DELETE RESTRICT ON UPDATE CASCADE` | Sede física asociada a la geocerca de la ficha. |

### 2.4 Tabla `usuario_sistema`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador del usuario administrativo. |
| `documento` | `VARCHAR` | `30` | `NOT NULL`, `UNIQUE (uk_usuario_documento)` | Número de documento único (solo caracteres alfanuméricos/dígitos). |
| `nombre` | `VARCHAR` | `120` | `NOT NULL` | Nombre visible en sesiones e historial (`creada_por`). |
| `email` | `VARCHAR` | `120` | `NOT NULL`, `UNIQUE (uk_usuario_email)` | Correo institucional único del usuario. |
| `usuario` | `VARCHAR` | `60` | `NOT NULL`, `UNIQUE (uk_usuario_login)` | Identificador único para inicio de sesión. |
| `password_hash` | `VARCHAR` | `255` | `NOT NULL` | Exclusivamente hash con sal (`BCrypt`/`Argon2id`); nunca texto plano ni cifrado reversible. |
| `rol_sistema` | `VARCHAR` | `30` | `NOT NULL`, `DEFAULT 'Instructor'`, `CHECK (ck_usuario_rol)` | Valores permitidos: `'Instructor'`, `'Coordinador'`. |
| `especialidad` | `VARCHAR` | `120` | `NULL` | Área técnica del instructor (opcional para coordinador). |
| `activo` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (ck_usuario_activo)` | Estado lógico: `1` (habilitado) o `0` (deshabilitado). |
| `creado_en` | `DATETIME` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora de creación del registro de usuario. |

### 2.5 Tabla `asignacion_instructor_ficha`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_usuario` | `INT` | n/a | `PK (compuesta)`, `NOT NULL`, `FK -> usuario_sistema(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE` | Instructor asignado a la ficha. |
| `id_ficha` | `INT` | n/a | `PK (compuesta)`, `NOT NULL`, `FK -> ficha(id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE` | Ficha académica asignada. |
| `fecha_inicio` | `DATE` | n/a | `PK (compuesta)`, `NOT NULL` | Fecha de inicio de la asignación docente. |
| `fecha_fin` | `DATE` | n/a | `NULL`, `CHECK (ck_asig_fechas)` | Fecha de finalización (`NULL` si vigente; si existe, `>= fecha_inicio`). |
| `rol_en_ficha` | `VARCHAR` | `40` | `NOT NULL`, `DEFAULT 'Titular'` | Rol desempeñado en la ficha (`Titular`, `Apoyo`, `Técnico`). |

### 2.6 Tabla `aprendiz`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_aprendiz` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador del aprendiz. |
| `documento` | `VARCHAR` | `30` | `NOT NULL`, `UNIQUE (uk_aprendiz_documento)` | Documento único del aprendiz para validación en todos los canales. |
| `nombre` | `VARCHAR` | `150` | `NOT NULL` | Nombre completo del aprendiz en formación. |
| `email` | `VARCHAR` | `120` | `NULL` | Correo de contacto institucional (opcional). |
| `qr_token` | `VARCHAR` | `64` | `NOT NULL`, `UNIQUE (uk_aprendiz_qr_token)` | Token CSPRNG único de la credencial QR individual (`SENA-...`). |
| `activo` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (ck_aprendiz_activo)` | Estado lógico Ley 1581: `1` (activo) o `0` (inactivo, preserva historial). |
| `id_ficha` | `INT` | n/a | `NULL`, `FK -> ficha(id_ficha) ON DELETE SET NULL ON UPDATE CASCADE` | Ficha actual asignada (`NULL` si aún no asignado o desvinculado). |
| `creado_en` | `DATETIME` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora de matrícula/registro inicial. |

### 2.7 Tabla `telefono_aprendiz`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_telefono` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador del teléfono. |
| `id_aprendiz` | `INT` | n/a | `NOT NULL`, `FK -> aprendiz(id_aprendiz) ON DELETE CASCADE ON UPDATE CASCADE` | Aprendiz propietario del número telefónico. |
| `numero_telefono` | `VARCHAR` | `20` | `NOT NULL`, `UNIQUE (uk_tel_aprendiz_num)` con `id_aprendiz` | Número telefónico único por aprendiz (formato E.164 o nacional). |
| `tipo_telefono` | `VARCHAR` | `20` | `NOT NULL`, `DEFAULT 'Móvil'`, `CHECK (ck_telefono_tipo)` | Valores permitidos: `'Móvil'`, `'Alterno'`, `'Acudiente'`. |

### 2.8 Tabla `sesion_asistencia`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_sesion` | `INT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero positivo identificador de la sesión de llamado a lista. |
| `token` | `VARCHAR` | `64` | `NOT NULL`, `UNIQUE (uk_sesion_token)` | Token criptográfico aleatorio (40 hex) incrustado en el QR de sesión. |
| `codigo` | `VARCHAR` | `8` | `NOT NULL`, `UNIQUE (uk_sesion_codigo)` | Código numérico de respaldo de 6 dígitos para ingreso manual rápido. |
| `id_ficha` | `INT` | n/a | `NULL`, `FK -> ficha(id_ficha) ON DELETE SET NULL ON UPDATE CASCADE` | Ficha convocada a la sesión (opcional si es sesión general). |
| `id_usuario` | `INT` | n/a | `NOT NULL`, `FK -> usuario_sistema(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE` | Instructor propietario que abrió la sesión (`creada_por`). |
| `inicia_en` | `DATETIME` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora oficial de inicio de la jornada. |
| `vence_en` | `DATETIME` | n/a | `NOT NULL`, `CHECK (ck_sesion_fechas)` | Fecha y hora de expiración (`> inicia_en`). |
| `tolerancia_minutos` | `INT` | n/a | `NOT NULL`, `DEFAULT 10`, `CHECK (ck_sesion_tolerancia)` | Minutos de gracia antes de calcular tardanza (`0` a `120`). |
| `activa` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (ck_sesion_activa)` | Estado de la sesión: `1` (abierta) o `0` (cerrada). |

### 2.9 Tabla `registro_asistencia`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_registro` | `BIGINT` | n/a | `PK`, `AUTO_INCREMENT`, `NOT NULL` | Entero grande secuencial identificador de asistencia. |
| `id_aprendiz` | `INT` | n/a | `NOT NULL`, `FK -> aprendiz(id_aprendiz) ON DELETE RESTRICT ON UPDATE CASCADE`, `UNIQUE (uk_reg_aprendiz_sesion)` | Aprendiz registrado (unicidad por sesión junto a `id_sesion`). |
| `id_sesion` | `INT` | n/a | `NOT NULL`, `FK -> sesion_asistencia(id_sesion) ON DELETE RESTRICT ON UPDATE CASCADE`, `UNIQUE (uk_reg_aprendiz_sesion)` | Sesión de asistencia en la que ocurrió el registro. |
| `fecha_hora` | `DATETIME` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Marca temporal exacta del servidor al persistir el registro. |
| `canal_registro` | `VARCHAR` | `20` | `NOT NULL`, `CHECK (ck_reg_canal)` | Valores permitidos: `'movil_qr'`, `'codigo'`, `'escaner_qr'`, `'manual'`. |
| `tarde_minutos` | `INT` | n/a | `NOT NULL`, `DEFAULT 0`, `CHECK (ck_reg_tarde)` | Minutos de retraso congelados en auditoría (`>= 0`). |
| `latitud` | `DECIMAL` | `10,7` | `NULL` | Latitud reportada por `Geolocation API` (si aplica canal móvil). |
| `longitud` | `DECIMAL` | `10,7` | `NULL` | Longitud reportada por `Geolocation API` (si aplica canal móvil). |
| `precision_gps` | `DECIMAL` | `8,2` | `NULL`, `CHECK (ck_reg_precision)` | Precisión reportada en metros (`> 0` y `<= 100.00` cuando se registra). |
| `verificado_gps` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 0`, `CHECK (ck_reg_gps_verif)` | `1` si se validó ubicación dentro de la geocerca; `0` en otro caso. |
| `consentimiento_datos` | `TINYINT` | `1` | `NOT NULL`, `DEFAULT 0`, `CHECK (ck_reg_consentimiento)` | `1` cuando el aprendiz aceptó expresamente Ley 1581 de 2012. |
| `ip_origen` | `VARCHAR` | `45` | `NOT NULL` | Dirección IPv4/IPv6 observada en `REMOTE_ADDR` del servidor. |
| `estado_red` | `VARCHAR` | `20` | `NOT NULL`, `DEFAULT 'permitida'`, `CHECK (ck_reg_estado_red)` | Valores permitidos: `'permitida'`, `'sospechosa'`, `'bloqueada'`. |
| `detalle_red` | `VARCHAR` | `255` | `NULL` | Observación automática sobre canal, proxy o validación de red. |

### 2.10 Tabla `novedad_contingencia`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :--- | :--- | :--- |
| `id_registro` | `BIGINT` | n/a | `PK (compuesta)`, `NOT NULL`, `FK -> registro_asistencia(id_registro) ON DELETE CASCADE ON UPDATE CASCADE` | Registro padre al que pertenece la novedad (entidad débil). |
| `numero_novedad` | `INT` | n/a | `PK (compuesta)`, `NOT NULL`, `CHECK (ck_nov_numero)` | Número correlativo por registro (`>= 1`). |
| `tipo_novedad` | `VARCHAR` | `40` | `NOT NULL`, `CHECK (ck_nov_tipo)` | Valores permitidos: `'sin_movil'`, `'falla_camara'`, `'falla_gps'`, `'falla_red'`, `'condicion_especial'`. |
| `observacion` | `VARCHAR` | `255` | `NOT NULL` | Descripción de la causa o soporte de contingencia documentada. |
| `fecha_reporte` | `DATETIME` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora de registro de la novedad. |

# B3 · Evidencia de Normalización Paso a Paso (`0FN → 1FN → 2FN → 3FN`)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`

Se normalizan paso a paso **2 tablas de partida** derivadas de las planillas operativas del caso `asistencia-sena`: una con **llave compuesta** (para demostrar dependencias parciales en 2FN) y otra con **dependencias transitivas** encadenadas (3FN).

---

## Caso 1 · Normalización con Llave Compuesta (`planilla_asistencia_bruta`)

### Estado Inicial (`0FN`)
Planilla consolidada de una toma de asistencia antes de normalizar:

> `planilla_asistencia_bruta(`**`id_sesion`**, **`id_aprendiz`**, `inicia_en, vence_en, tolerancia_minutos, id_ficha, numero_ficha, documento_aprendiz, nombre_aprendiz, telefonos_aprendiz, qr_token, canal_registro, fecha_hora, tarde_minutos, consentimiento_datos, ip_origen, estado_red, novedades_contingencia)`
>
> - **Llave primaria compuesta:** `(id_sesion, id_aprendiz)`.
> - **Grupos no atómicos / repetitivos:** `telefonos_aprendiz` almacena múltiples teléfonos separados por coma (`"3000000001, 3000000002"`) y `novedades_contingencia` agrupa varias observaciones en un solo campo.

### Paso `0FN → 1FN` (Eliminar grupos repetitivos y garantizar atomicidad)
- **Violación detectada:** `telefonos_aprendiz` y `novedades_contingencia` no son valores atómicos.
- **Solución:**
  1. Se extrae el atributo multivaluado a `telefono_aprendiz(id_telefono, id_aprendiz, numero_telefono, tipo_telefono)`.
  2. Se extrae el grupo repetitivo de incidencias a `novedad_contingencia(id_registro, numero_novedad, tipo_novedad, observacion, fecha_reporte)`.
- **Resultado en 1FN:**
  - `planilla_1fn(`**`id_sesion, id_aprendiz`**`, inicia_en, vence_en, tolerancia_minutos, id_ficha, numero_ficha, documento_aprendiz, nombre_aprendiz, qr_token, canal_registro, fecha_hora, tarde_minutos, consentimiento_datos, ip_origen, estado_red)`
  - `telefono_aprendiz(`**`id_telefono`**`, id_aprendiz, numero_telefono, tipo_telefono)`
  - `novedad_contingencia(`**`id_registro, numero_novedad`**`, tipo_novedad, observacion, fecha_reporte)`

### Paso `1FN → 2FN` (Eliminar dependencias funcionales parciales de la llave compuesta)
- **Dependencias funcionales (DF) escritas sobre `(id_sesion, id_aprendiz)`:**
  - **DF1 (parcial de `id_sesion`):** `id_sesion → inicia_en, vence_en, tolerancia_minutos, id_ficha, numero_ficha`
  - **DF2 (parcial de `id_aprendiz`):** `id_aprendiz → documento_aprendiz, nombre_aprendiz, qr_token`
  - **DF3 (completa de `(id_sesion, id_aprendiz)`):** `(id_sesion, id_aprendiz) → id_registro, canal_registro, fecha_hora, tarde_minutos, consentimiento_datos, ip_origen, estado_red`
- **Violación detectada:** Los datos de la sesión (DF1) y del aprendiz (DF2) dependen solo de una parte de la llave compuesta `(id_sesion, id_aprendiz)`, causando redundancia y anomalías de actualización.
- **Solución (descomposición por DF):**
  - `sesion_asistencia(`**`id_sesion`**`, id_ficha, id_usuario, token, codigo, inicia_en, vence_en, tolerancia_minutos, activa)`
  - `aprendiz(`**`id_aprendiz`**`, documento, nombre, email, qr_token, activo, id_ficha, creado_en)`
  - `registro_asistencia(`**`id_registro`**`, id_aprendiz, id_sesion, fecha_hora, canal_registro, tarde_minutos, latitud, longitud, precision_gps, verificado_gps, consentimiento_datos, ip_origen, estado_red, detalle_red)` con `UNIQUE(id_aprendiz, id_sesion)`.

### Paso `2FN → 3FN` (Eliminar dependencias funcionales transitivas)
- **Dependencia transitiva detectada en `sesion_asistencia`:**
  - `id_sesion → id_ficha` y `id_ficha → numero_ficha` *(entonces `id_sesion → numero_ficha` transitivamente)*.
  - También `id_aprendiz → id_ficha → numero_ficha`.
- **Solución:** se elimina `numero_ficha` de `sesion_asistencia` y de `aprendiz`, dejándolo únicamente en la tabla **`ficha(id_ficha, numero_ficha, jornada, activa, id_programa, id_sede)`**.
- **Resultado final del Caso 1 en 3FN:** todas las columnas no clave dependen únicamente de la llave primaria, de toda la llave y nada más que de la llave (`sesion_asistencia`, `aprendiz`, `ficha`, `telefono_aprendiz`, `registro_asistencia`, `novedad_contingencia`).

---

## Caso 2 · Normalización con Dependencia Transitiva (`ficha_programa_sede_bruta`)

### Estado Inicial (`0FN`)
Tabla administrativa plana usada para listar fichas y su configuración:

> `ficha_programa_sede_bruta(`**`id_ficha`**`, numero_ficha, jornada, activa, id_programa, codigo_programa, nombre_programa, nivel_formacion, id_sede, nombre_sede, latitud_sede, longitud_sede, radio_max_metros, instructores_asignados)`
>
> - **Llave primaria simple:** `id_ficha`.
> - **Grupo repetitivo:** `instructores_asignados` contiene lista de instructores y fechas de asignación.

### Paso `0FN → 1FN` (Atomicidad)
- **Violación:** `instructores_asignados` es multivaluado/repetitivo.
- **Solución:** se extrae la relación N:M a `asignacion_instructor_ficha(`**`id_usuario, id_ficha, fecha_inicio`**`, fecha_fin, rol_en_ficha)` referenciando a `usuario_sistema(id_usuario)`.
- **Resultado 1FN:** `ficha_1fn(`**`id_ficha`**`, numero_ficha, jornada, activa, id_programa, codigo_programa, nombre_programa, nivel_formacion, id_sede, nombre_sede, latitud_sede, longitud_sede, radio_max_metros)`.

### Paso `1FN → 2FN` (Dependencias parciales)
- Como la clave primaria de `ficha_1fn` es un atributo simple (`id_ficha`), no existen dependencias parciales: `ficha_1fn` ya está en **2FN**.
- En `asignacion_instructor_ficha`, todos los atributos no clave (`fecha_fin`, `rol_en_ficha`) dependen de la clave completa `(id_usuario, id_ficha, fecha_inicio)`, cumpliendo también **2FN**.

### Paso `2FN → 3FN` (Eliminar dependencias transitivas)
- **Dependencias transitivas escritas:**
  1. `id_ficha → id_programa → codigo_programa, nombre_programa, nivel_formacion`
  2. `id_ficha → id_sede → nombre_sede, latitud_sede, longitud_sede, radio_max_metros`
- **Violación detectada:** Cambiar el radio de geocerca de una sede (`radio_max_metros`) o el nombre de un programa obligaría a actualizar múltiples filas de `ficha`, generando inconsistencias.
- **Solución:**
  - Extraer `programa_formacion(`**`id_programa`**`, codigo_programa, nombre_programa, nivel_formacion)`.
  - Extraer `sede(`**`id_sede`**`, nombre_sede, latitud_sede, longitud_sede, radio_max_metros)`.
  - Mantener `ficha(`**`id_ficha`**`, numero_ficha, jornada, activa, id_programa FK, id_sede FK)`.
- **Resultado final del Caso 2 en 3FN:** `programa_formacion`, `sede`, `ficha`, `usuario_sistema` y `asignacion_instructor_ficha` quedan libres de dependencias parciales y transitivas.

---

## Nota Justificada sobre Almacenamiento de `tarde_minutos`

El atributo `tarde_minutos` en `registro_asistencia` **se almacena congelado al momento de registrar la asistencia** (pese a derivarse de `fecha_hora`, `sesion_asistencia.inicia_en` y `sesion_asistencia.tolerancia_minutos`) por exigencia de **integridad histórica de auditoría (`RNF-06`)**: si posteriormente se ajustara la tolerancia de una sesión o se consultaran reportes históricos, los minutos de retraso oficialmente sancionados en el instante del llamado a lista no deben alterarse retroactivamente.

# B2 · Modelo Lógico Relacional y Reglas de Transformación

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Fuente editable:** [02-modelo-logico.drawio](02-modelo-logico.drawio) · **Imagen exportada:** [02-modelo-logico.svg](02-modelo-logico.svg)

---

## 1. Esquema Lógico Relacional (`10` Tablas Normalizadas en 3FN)

Estándar de nombrado aplicado: tablas en **singular** y `snake_case`, llaves primarias `id_<tabla>` (o compuesta donde corresponda), restricciones `pk_*`, `fk_*`, `uk_*`, `ck_*`.

1. **`programa_formacion`**(`id_programa` PK, `codigo_programa` UK, `nombre_programa`, `nivel_formacion`)
2. **`sede`**(`id_sede` PK, `nombre_sede` UK, `latitud_sede`, `longitud_sede`, `radio_max_metros`)
3. **`ficha`**(`id_ficha` PK, `numero_ficha` UK, `jornada`, `activa`, `id_programa` FK, `id_sede` FK)
4. **`usuario_sistema`**(`id_usuario` PK, `documento` UK, `nombre`, `email` UK, `usuario` UK, `password_hash`, `rol_sistema`, `especialidad`, `activo`, `creado_en`)
5. **`asignacion_instructor_ficha`**(`id_usuario` PK/FK, `id_ficha` PK/FK, `fecha_inicio` PK, `fecha_fin`, `rol_en_ficha`)
6. **`aprendiz`**(`id_aprendiz` PK, `documento` UK, `nombre`, `email`, `qr_token` UK, `activo`, `id_ficha` FK NULL, `creado_en`)
7. **`telefono_aprendiz`**(`id_telefono` PK, `id_aprendiz` FK, `numero_telefono`, `tipo_telefono`) *(UK compuesto `id_aprendiz, numero_telefono`)*
8. **`sesion_asistencia`**(`id_sesion` PK, `token` UK, `codigo` UK, `id_ficha` FK NULL, `id_usuario` FK, `inicia_en`, `vence_en`, `tolerancia_minutos`, `activa`)
9. **`registro_asistencia`**(`id_registro` PK, `id_aprendiz` FK, `id_sesion` FK, `fecha_hora`, `canal_registro`, `tarde_minutos`, `latitud`, `longitud`, `precision_gps`, `verificado_gps`, `consentimiento_datos`, `ip_origen`, `estado_red`, `detalle_red`) *(UK compuesto `id_aprendiz, id_sesion`)*
10. **`novedad_contingencia`**(`id_registro` PK/FK, `numero_novedad` PK, `tipo_novedad`, `observacion`, `fecha_reporte`)

---

## 2. Cuadro de Reglas de Transformación Aplicadas (`B1 → B2`)

| Regla de transformación relacional | Caso específico en `asistencia-sena` | Resultado exacto en el modelo lógico (`10` tablas) |
| :--- | :--- | :--- |
| **1. Entidad fuerte → Tabla base con PK** | Entidades independientes (`PROGRAMA_FORMACION`, `SEDE`, `USUARIO_SISTEMA`, `APRENDIZ`, `FICHA`, `SESION_ASISTENCIA`) | Tablas `programa_formacion`, `sede`, `usuario_sistema`, `aprendiz`, `ficha`, `sesion_asistencia` con PK autoincremental e índices `UNIQUE` en códigos de negocio. |
| **2. Relación `1:N` → FK en el lado «muchos»** | `PROGRAMA_FORMACION` `1:N` `FICHA`; `SEDE` `1:N` `FICHA`; `FICHA` `0..1:N` `APRENDIZ`; `USUARIO_SISTEMA` `1:N` `SESION_ASISTENCIA`; `FICHA` `0..1:N` `SESION_ASISTENCIA` | Columnas `ficha.id_programa`, `ficha.id_sede` (`ON DELETE RESTRICT`); `aprendiz.id_ficha`, `sesion_asistencia.id_ficha` (`ON DELETE SET NULL`); `sesion_asistencia.id_usuario` (`ON DELETE RESTRICT`). |
| **3. Relación `N:M` → Tabla intermedia** | `USUARIO_SISTEMA`–`FICHA` (vigencia de asignación) y `APRENDIZ`–`SESION_ASISTENCIA` (asistencia única por sesión) | Tabla `asignacion_instructor_ficha(id_usuario FK, id_ficha FK, fecha_inicio)` con PK compuesta; tabla `registro_asistencia` con `id_aprendiz FK`, `id_sesion FK` y restricción `UNIQUE(id_aprendiz, id_sesion)`. |
| **4. Atributo multivaluado → Tabla hija aparte** | `APRENDIZ.telefonos{}` (un aprendiz puede registrar uno o más teléfonos de contacto/emergencia) | Tabla `telefono_aprendiz(id_telefono PK, id_aprendiz FK, numero_telefono, tipo_telefono)` con `ON DELETE CASCADE` y `UNIQUE(id_aprendiz, numero_telefono)`. |
| **5. Entidad débil → PK compuesta con FK del padre** | `NOVEDAD_CONTINGENCIA` depende existencialmente de `REGISTRO_ASISTENCIA` | Tabla `novedad_contingencia(id_registro PK/FK, numero_novedad PK, ...)` con `ON DELETE CASCADE`. |
| **6. Generalización (`Persona / Instructor / Coordinador`) → Tabla única con discriminador** | En análisis `G1-P2` `Instructor` y `CoordinadorAcademico` comparten credenciales de acceso al panel y difieren únicamente en `rol_sistema` y `especialidad`. | Tabla unificada `usuario_sistema` con discriminador `rol_sistema IN ('Instructor','Coordinador')`, evitando JOINs redundantes en autenticación (`RF-01`) mientras `aprendiz` mantiene tabla propia por tener `qr_token` y flujo separado. |
| **7. Unicidad `1:1` de identificadores operativos** | Cada sesión genera un `token` y un `codigo` de 6 dígitos irrepetibles activos; cada aprendiz posee un `qr_token` único. | Restricciones `UNIQUE` en `aprendiz.qr_token`, `sesion_asistencia.token` y `sesion_asistencia.codigo`. |

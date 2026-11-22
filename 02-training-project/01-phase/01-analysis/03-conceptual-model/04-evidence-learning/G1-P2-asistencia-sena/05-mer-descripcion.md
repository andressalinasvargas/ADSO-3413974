# Modelo Entidad-Relación (MER) — Notación Pata de Gallo (*Crow's Foot*)

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Diagrama asociado:** [05-modelo-entidad-relacion.drawio](05-modelo-entidad-relacion.drawio) · [05-modelo-entidad-relacion.png](05-modelo-entidad-relacion.png) · [05-modelo-entidad-relacion.svg](05-modelo-entidad-relacion.svg)  
**Notación declarada:** **Pata de gallo (*Crow's Foot*)** para cardinalidad mínima/máxima y participación, con doble rectángulo para **entidad débil**.

---

## 1. Catálogo de Entidades (9 Entidades)

| # | Entidad | Tipo | Identificador (PK) | Atributos principales |
| :- | :--- | :--- | :--- | :--- |
| 1 | **`PROGRAMA_FORMACION`** | Fuerte | `id_programa` | `codigo_programa` (único), `nombre_programa`, `nivel_formacion` |
| 2 | **`SEDE`** | Fuerte | `id_sede` | `nombre_sede` (único), `latitud_sede`, `longitud_sede`, `radio_max_metros` |
| 3 | **`FICHA`** | Fuerte | `id_ficha` | `numero_ficha` (único), `jornada`, `activa`, `id_programa` (ref), `id_sede` (ref) |
| 4 | **`INSTRUCTOR`** | Fuerte | `id_instructor` | `documento` (único), `nombre`, `usuario` (único), `rol_sistema`, `activo` |
| 5 | **`ASIGNACION_INSTRUCTOR_FICHA`** | Asociativa (resuelve N:M `INSTRUCTOR`–`FICHA`) | `(id_instructor, id_ficha, fecha_inicio)` | `fecha_fin`, `rol_en_ficha` |
| 6 | **`APRENDIZ`** | Fuerte | `id_aprendiz` | `documento` (único), `nombre`, `email`, `qr_token` (único), `activo`, `id_ficha` (ref opcional) |
| 7 | **`SESION_ASISTENCIA`** | Fuerte | `id_sesion` | `token` (único), `codigo` (único), `inicia_en`, `vence_en`, `tolerancia_minutos`, `activa`, `id_ficha` (ref), `id_instructor` (ref) |
| 8 | **`REGISTRO_ASISTENCIA`** | Asociativa (resuelve N:M `APRENDIZ`–`SESION_ASISTENCIA`) | `id_registro` (unicidad compuesta `(id_aprendiz, id_sesion)`) | `fecha_hora`, `canal_registro`, `tarde_minutos`, `latitud`, `longitud`, `precision_gps`, `verificado_gps`, `consentimiento_datos`, `ip_origen`, `estado_red`, `detalle_red` |
| 9 | **`NOVEDAD_CONTINGENCIA`** | **Débil** (dependiente de existencia de `REGISTRO_ASISTENCIA`) | `(id_registro, numero_novedad)` | `tipo_novedad`, `observacion`, `fecha_reporte` |

---

## 2. Detalle de Relaciones, Cardinalidades y Participación

| Entidad A | Verbo de relación | Entidad B | Cardinalidad y participación (Pata de gallo) | Regla de negocio soportada |
| :--- | :--- | :--- | :--- | :--- |
| `PROGRAMA_FORMACION` | ofrece | `FICHA` | `1` (`\|`) obligatorio a `0..*` (`○<`) opcional | Toda ficha pertenece a 1 programa; un programa puede tener 0 o muchas fichas. |
| `SEDE` | aloja | `FICHA` | `1` (`\|`) obligatorio a `0..*` (`○<`) opcional | Toda ficha se vincula a 1 sede donde aplica la geocerca; una sede aloja muchas fichas. |
| `INSTRUCTOR` | participa en | `ASIGNACION_INSTRUCTOR_FICHA` | `1` (`\|`) a `0..*` (`○<`) | Descompone la relación **N:M** entre `INSTRUCTOR` y `FICHA`, conservando atributos propios de periodo (`fecha_inicio`, `fecha_fin`) y `rol_en_ficha`. |
| `FICHA` | recibe | `ASIGNACION_INSTRUCTOR_FICHA` | `1` (`\|`) a `1..*` (`\|<`) participación total de ficha | Toda ficha activa cuenta con al menos una asignación de instructor responsable. |
| `FICHA` | agrupa | `APRENDIZ` | `0..1` (`○\|`) opcional a `0..*` (`○<`) | Un aprendiz puede pertenecer a una ficha o encontrarse temporalmente sin asignar. |
| `INSTRUCTOR` | abre | `SESION_ASISTENCIA` | `1` (`\|`) obligatorio a `0..*` (`○<`) | Cada sesión es creada por un único instructor propietario (`RF-03`, `RF-11`). |
| `FICHA` | convoca | `SESION_ASISTENCIA` | `0..1` (`○\|`) a `0..*` (`○<`) | Permite sesiones enfocadas en una ficha específica o sesiones abiertas generales. |
| `APRENDIZ` | registra | `REGISTRO_ASISTENCIA` | `1` (`\|`) a `0..*` (`○<`) | Descompone la relación **N:M** entre `APRENDIZ` y `SESION_ASISTENCIA` con atributos propios (GPS, tardanza, red, consentimiento). |
| `SESION_ASISTENCIA` | consolida | `REGISTRO_ASISTENCIA` | `1` (`\|`) a `0..*` (`○<`) | La restricción única `(id_aprendiz, id_sesion)` impide duplicados por sesión (`RF-07`). |
| `REGISTRO_ASISTENCIA` | documenta | `NOVEDAD_CONTINGENCIA` | `1` (`\|`) identificador obligatorio a `0..*` (`○<`) | **Entidad débil:** su identificador `numero_novedad` solo tiene sentido dentro de su `REGISTRO_ASISTENCIA` padre; si no existe el registro, la novedad no existe (`RF-09`). |

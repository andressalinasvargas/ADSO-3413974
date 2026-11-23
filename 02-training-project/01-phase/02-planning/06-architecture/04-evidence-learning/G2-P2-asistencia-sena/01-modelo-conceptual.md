# B1 · Modelo Conceptual de Datos (Ajustado para Diseño Relacional)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Fuente editable:** [01-modelo-conceptual.drawio](01-modelo-conceptual.drawio) · **Imagen exportada:** [01-modelo-conceptual.svg](01-modelo-conceptual.svg)  
**Origen reutilizado:** [`G1-P2/05-modelo-entidad-relacion.drawio`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/05-modelo-entidad-relacion.drawio)

---

## 1. Qué Cambió Respecto al MER de Guía 1

Partiendo de las `9` entidades conceptuales del MER elaborado en Guía 1, se realizaron **5 ajustes de evolución** para prepararlo hacia el modelo lógico relacional en **MariaDB 10.11 (`InnoDB`)**:

1. **Generalización de usuarios administrativos (`INSTRUCTOR` → `USUARIO_SISTEMA`):** se amplió la entidad `INSTRUCTOR` hacia `USUARIO_SISTEMA` incorporando `rol_sistema` (`Instructor` / `Coordinador`), `password_hash` y `creado_en` para soportar la política de acceso por roles (`RF-01`, `RNF-01`) sin duplicar cuentas.
2. **Atributo multivaluado explícito (`APRENDIZ.telefonos{}`):** se incorporó el atributo multivaluado de teléfonos de contacto en `APRENDIZ`, que en transformación lógica (`B2`) y normalización `1FN` (`B3`) da origen a tabla hija propia.
3. **Reglas de geocerca en `SEDE`:** se explicitaron los dominios geográficos de `latitud_sede`, `longitud_sede` y `radio_max_metros` para el cálculo Haversine en servidor (`RF-06`).
4. **Identificación de cardinalidades mínimas/máximas y verbos:** se revisó la participación exacta de cada relación en notación **Pata de gallo (*Crow's Foot*)**, dejando claras **2 relaciones N:M** (`USUARIO_SISTEMA`–`FICHA` y `APRENDIZ`–`SESION_ASISTENCIA`) y **7 relaciones 1:N / dependientes**.
5. **Trazabilidad directa entidad → requisito:** cada entidad se vinculó explícitamente a uno o más requisitos del SRS de `G1-P1`.

---

## 2. Entidades Conceptuales (`9` Entidades), Atributos e Identificadores

> **Justificación del tipo de base de datos:** Se confirma base de datos **Relacional (MariaDB / MySQL InnoDB)** porque las entidades poseen estructura estable, reglas estrictas de unicidad compuesta `(aprendiz, sesión)` para prevenir duplicados (`RF-07`), integridad referencial obligatoria para auditoría SENA (`RNF-06`) y necesidades transaccionales ACID en el inicio simultáneo de clases (`RNF-03`).

| # | Entidad conceptual | Tipo | Identificador | Atributos conceptuales clave | Requisito(s) que soporta |
| :- | :--- | :--- | :--- | :--- | :--- |
| 1 | **`PROGRAMA_FORMACION`** | Fuerte | `id_programa` | `codigo_programa`, `nombre_programa`, `nivel_formacion` | `RF-02`, `RF-12` |
| 2 | **`SEDE`** | Fuerte | `id_sede` | `nombre_sede`, `latitud_sede`, `longitud_sede`, `radio_max_metros` | `RF-02`, `RF-06`, `RNF-06` |
| 3 | **`FICHA`** | Fuerte | `id_ficha` | `numero_ficha`, `jornada`, `activa` | `RF-02`, `RF-03`, `RF-04`, `RNF-02` |
| 4 | **`USUARIO_SISTEMA`** | Fuerte | `id_usuario` | `documento`, `nombre`, `email`, `usuario`, `password_hash`, `rol_sistema`, `especialidad`, `activo`, `creado_en` | `RF-01`, `RF-03`, `RF-09`, `RF-11`, `RNF-01` |
| 5 | **`ASIGNACION_INSTRUCTOR_FICHA`** | Asociativa (N:M) | `(id_usuario, id_ficha, fecha_inicio)` | `fecha_fin`, `rol_en_ficha` | `RF-02`, `RF-03`, `RNF-01` |
| 6 | **`APRENDIZ`** | Fuerte | `id_aprendiz` | `documento`, `nombre`, `email`, `telefonos{}` *(multivaluado)*, `qr_token`, `activo`, `creado_en` | `RF-02`, `RF-04`, `RF-05`, `RF-08`, `RNF-02` |
| 7 | **`SESION_ASISTENCIA`** | Fuerte | `id_sesion` | `token`, `codigo`, `inicia_en`, `vence_en`, `tolerancia_minutos`, `activa` | `RF-03`, `RF-04`, `RF-07`, `RF-10`, `RF-11` |
| 8 | **`REGISTRO_ASISTENCIA`** | Asociativa (N:M) | `id_registro` | `fecha_hora`, `canal_registro`, `tarde_minutos`, `latitud`, `longitud`, `precision_gps`, `verificado_gps`, `consentimiento_datos`, `ip_origen`, `estado_red`, `detalle_red` | `RF-05`, `RF-06`, `RF-07`, `RF-08`, `RF-09`, `RF-10`, `RF-12`, `RNF-02`, `RNF-06` |
| 9 | **`NOVEDAD_CONTINGENCIA`** | **Débil** | `(id_registro, numero_novedad)` | `tipo_novedad`, `observacion`, `fecha_reporte` | `RF-09`, `RF-12`, `RNF-05`, `RNF-06` |

---

## 3. Relaciones Conceptuales (Cardinalidades Mín/Máx y Verbos)

- `PROGRAMA_FORMACION` `(1,1)` **ofrece** `(0,N)` `FICHA` *(1:N)*.
- `SEDE` `(1,1)` **alberga** `(0,N)` `FICHA` *(1:N)*.
- `USUARIO_SISTEMA` `(1,N)` **orienta / se asigna a** `(0,N)` `FICHA` *(N:M resuelta mediante entidad asociativa `ASIGNACION_INSTRUCTOR_FICHA`)*.
- `FICHA` `(0,1)` **agrupa** `(0,N)` `APRENDIZ` *(1:N opcional)*.
- `USUARIO_SISTEMA` `(1,1)` **abre** `(0,N)` `SESION_ASISTENCIA` *(1:N obligatorio en origen)*.
- `FICHA` `(0,1)` **convoca** `(0,N)` `SESION_ASISTENCIA` *(1:N opcional)*.
- `APRENDIZ` `(0,N)` **registra asistencia en** `(0,N)` `SESION_ASISTENCIA` *(N:M resuelta mediante entidad asociativa `REGISTRO_ASISTENCIA` con restricción única por par)*.
- `REGISTRO_ASISTENCIA` `(1,1)` **documenta** `(0,N)` `NOVEDAD_CONTINGENCIA` *(1:N identificadora hacia entidad débil)*.

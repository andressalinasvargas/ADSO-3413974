# Modelo de Dominio — Descripción Conceptual

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Diagrama asociado:** [04-modelo-dominio.drawio](04-modelo-dominio.drawio) · [04-modelo-dominio.png](04-modelo-dominio.png) · [04-modelo-dominio.svg](04-modelo-dominio.svg)  
**Origen reutilizado:** Evolucionado desde la página *Diagrama de Clases* de `03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio`

---

## 1. Convenciones Aplicadas (C3 de `Rubricas_G1.md`)

- Representa exclusivamente **conceptos del negocio**, sus **atributos de negocio** y sus **relaciones con multiplicidades**.
- **Sin métodos, sin claves foráneas ni identificadores técnicos de base de datos**, manteniendo estricta independencia de la tecnología de persistencia.
- Incluye una **generalización conceptual (`Persona`)** y **dos clases de asociación (`AsignacionInstructor`, `RegistroAsistencia`)**.

---

## 2. Catálogo de Clases Conceptuales (11 Clases)

| # | Clase conceptual | Tipo / Estereotipo | Atributos de negocio | Responsabilidad conceptual en el dominio |
| :- | :--- | :--- | :--- | :--- |
| 1 | **`Persona`** | Superclase abstracta (Generalización) | `documento`, `nombreCompleto`, `correoInstitucional` | Reúne la identidad común de las personas que participan en el proceso formativo y de control de asistencia. |
| 2 | **`Instructor`** | Subclase de `Persona` | `nombreUsuario`, `especialidad`, `estado` | Dirige sesiones de formación, gestiona aprendices de sus fichas y abre/cierra sesiones de asistencia. |
| 3 | **`Aprendiz`** | Subclase de `Persona` | `tokenCredencial`, `estadoActivo`, `fechaIngreso` | Participante en formación cuya asistencia es verificada y registrada en cada sesión de clase. |
| 4 | **`CoordinadorAcademico`** | Subclase de `Persona` | `areaAcademica`, `estado` | Audita el cumplimiento de asistencia, las tardanzas y las novedades de contingencia en el centro. |
| 5 | **`ProgramaFormacion`** | Clase conceptual | `codigoPrograma`, `nombrePrograma`, `nivelFormacion` | Define el currículo académico al que pertenece una o más fichas de formación. |
| 6 | **`FichaFormacion`** | Clase conceptual | `numeroFicha`, `jornada`, `estadoActiva` | Cohorte o grupo académico de aprendices que cursa un programa en una sede. |
| 7 | **`SedeFormacion`** | Clase conceptual | `nombreSede`, `latitudCentro`, `longitudCentro`, `radioPermitidoMetros` | Centro físico de formación cuyo perímetro geográfico delimita las validaciones de presencia. |
| 8 | **`AsignacionInstructor`** | Clase de asociación (`Instructor` — `FichaFormacion`) | `fechaInicio`, `fechaFin`, `rolEnFicha` | Formaliza en el tiempo qué instructor orienta formación en cada ficha y con qué rol. |
| 9 | **`SesionAsistencia`** | Clase conceptual | `codigoAcceso`, `tokenSesion`, `horaInicioOficial`, `horaVencimiento`, `toleranciaMinutos`, `estadoActiva` | Ventana temporal de llamado a lista abierta por un instructor para una ficha determinada. |
| 10 | **`RegistroAsistencia`** | Clase de asociación (`Aprendiz` — `SesionAsistencia`) | `fechaHora`, `canalRegistro`, `tardeMinutos`, `latitud`, `longitud`, `precisionMetros`, `estadoRed`, `consentimientoDatos` | Evidencia única de asistencia de un aprendiz en una sesión específica, incluyendo auditoría de ubicación y puntualidad. |
| 11 | **`NovedadContingencia`** | Clase conceptual | `numeroNovedad`, `tipoNovedad`, `observacion`, `fechaReporte` | Justificación o incidencia asociada a un registro realizado bajo contingencia operativa. |

---

## 3. Resumen de Relaciones y Multiplicidades Clave

- **`Persona` ⇐ `Instructor`, `Aprendiz`, `CoordinadorAcademico`:** Generalización (*es un*). Evita duplicar `documento`, `nombreCompleto` y `correoInstitucional`.
- **`ProgramaFormacion` `1` — contiene — `0..*` `FichaFormacion`:** Un programa agrupa cero o muchas fichas; cada ficha pertenece exactamente a un programa.
- **`SedeFormacion` `1` — alberga — `0..*` `FichaFormacion`:** Una sede alberga muchas fichas activas o históricas; cada ficha se adscribe a una sede.
- **`Instructor` `1..*` — asignado a — `0..*` `FichaFormacion` (Clase de asociación: `AsignacionInstructor`):** Modela la relación muchos a muchos entre instructores y fichas con sus fechas de vigencia.
- **`FichaFormacion` `0..1` — agrupa — `0..*` `Aprendiz`:** Un aprendiz puede estar asociado a una ficha o pendiente de asignación inicial.
- **`Instructor` `1` — abre — `0..*` `SesionAsistencia`:** Un instructor abre múltiples sesiones a lo largo de su labor docente.
- **`FichaFormacion` `0..1` — convoca — `0..*` `SesionAsistencia`:** Una sesión se convoca normalmente para una ficha específica.
- **`Aprendiz` `0..*` — asiste a — `0..*` `SesionAsistencia` (Clase de asociación: `RegistroAsistencia`):** Cada par `(Aprendiz, SesionAsistencia)` origina a lo sumo un `RegistroAsistencia`.
- **`RegistroAsistencia` `1` — documenta — `0..*` `NovedadContingencia`:** Un registro manual o excepcional puede detallar cero o más novedades de contingencia.

# Justificación de Casos de Uso y Relaciones UML (`«include»` y `«extend»`)

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Diagrama asociado:** [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio) · [03-diagrama-casos-uso.png](03-diagrama-casos-uso.png) · [03-diagrama-casos-uso.svg](03-diagrama-casos-uso.svg)  
**Origen reutilizado:** `03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio`

---

## 1. Catálogo de Actores y Casos de Uso (12 CU)

### Actores fuera de la frontera del sistema
- **Instructor (primario):** Administra aprendices/credenciales, abre y cierra sesiones, registra asistencia por escáner o contingencia manual y consulta historial/reportes.
- **Aprendiz (primario):** Registra su propia asistencia mediante QR rotativo o código numérico de 6 dígitos autorizando ubicación y tratamiento de datos.
- **Coordinador Académico (primario):** Se autentica para auditar historial de asistencias y generar reportes consolidados de formación.
- **Servicio de Geolocalización (GPS) (secundario):** Provee coordenadas geográficas y precisión métrica cuando `CU-05` valida la ubicación del aprendiz.
- **Temporizador del Sistema (secundario):** Dispara automáticamente el cierre de la sesión (`CU-11`) al cumplirse la ventana de vigencia configurada.

### Casos de uso (verbo + objeto, sin CRUD fragmentado)
| ID | Caso de uso | Actor(es) asociado(s) | Objetivo resumido |
| :--- | :--- | :--- | :--- |
| **CU-01** | Autenticar usuario | Instructor, Coordinador Académico | Validar identidad y habilitar acceso seguro a las funciones administrativas del sistema. |
| **CU-02** | Gestionar aprendices y credenciales QR | Instructor | Registrar aprendices, asignar ficha, activar/inactivar estado lógico y emitir su credencial QR individual. |
| **CU-03** | Abrir sesión de asistencia | Instructor | Iniciar una sesión para una ficha con tolerancia de tardanza, emitiendo QR rotativo y código de respaldo. |
| **CU-04** | Registrar asistencia por QR o código | Aprendiz | Permitir al aprendiz autogestionar su registro de asistencia en una sesión activa desde su dispositivo. |
| **CU-05** | Validar ubicación y consentimiento de datos | *(Incluido)* · Servicio de Geolocalización (GPS) | Exigir aceptación de la política de datos personales (Ley 1581) y verificar coordenadas/precisión GPS en el autorregistro. |
| **CU-06** | Verificar vigencia de sesión y pertenencia a ficha | *(Incluido)* | Comprobar en todo registro que la sesión siga abierta/vigente, el aprendiz esté activo, pertenezca a la ficha y no tenga duplicado. |
| **CU-07** | Registrar asistencia mediante escáner QR | Instructor | Capturar el código de la credencial QR individual del aprendiz desde el dispositivo del instructor. |
| **CU-08** | Registrar asistencia por contingencia manual | Instructor | Anotar manualmente por documento al aprendiz en la sesión cuando no pueda usar los canales QR. |
| **CU-09** | Calcular y registrar tardanza | *(Extiende)* | Computar e incorporar los minutos de retraso cuando la hora de registro supera la tolerancia oficial de la sesión. |
| **CU-10** | Documentar novedad de contingencia | *(Extiende)* | Adjuntar motivo o soporte de contingencia (sin celular, discapacidad, falla técnica) al registro manual. |
| **CU-11** | Cerrar sesión de asistencia | Instructor, Temporizador del Sistema | Finalizar la sesión manual o automáticamente al vencer el plazo, bloqueando nuevos registros. |
| **CU-12** | Consultar historial y generar reportes | Instructor, Coordinador Académico | Visualizar registros en vivo e históricos con tardanza, estado de red y exportar consolidados por fecha o ficha. |

---

## 2. Justificación de Cada Relación `«include»` y `«extend»`

| # | Tipo | Origen → Destino (sentido de flecha UML) | Punto de extensión (solo `«extend»`) | Justificación en una línea |
| :- | :--- | :--- | :--- | :--- |
| 1 | `«include»` | `CU-04` → `CU-05` | N/A (obligatorio) | Todo autorregistro móvil del aprendiz exige obligatoriamente aceptar el tratamiento de datos y validar su ubicación GPS antes de guardar la asistencia. |
| 2 | `«include»` | `CU-04` → `CU-06` | N/A (obligatorio) | El autorregistro móvil siempre debe verificar primero que la sesión esté vigente, que el aprendiz esté activo en la ficha y que no exista registro previo. |
| 3 | `«include»` | `CU-07` → `CU-06` | N/A (obligatorio) | El escaneo de credencial QR por el instructor siempre requiere verificar vigencia de la sesión, pertenencia a la ficha y unicidad del registro. |
| 4 | `«include»` | `CU-08` → `CU-06` | N/A (obligatorio) | El registro por contingencia manual siempre valida vigencia de sesión, propiedad del instructor, pertenencia a ficha y ausencia de duplicado. |
| 5 | `«extend»` | `CU-09` → `CU-04` | *Al evaluar hora del registro* | Si la hora del autorregistro supera el inicio oficial más la tolerancia, se añade el cálculo y marcación de minutos de tardanza. |
| 6 | `«extend»` | `CU-09` → `CU-07` | *Al evaluar hora del registro* | Si el escaneo de credencial ocurre después del margen de tolerancia, se extiende el caso calculando y registrando la tardanza. |
| 7 | `«extend»` | `CU-09` → `CU-08` | *Al evaluar hora del registro* | Si el registro manual se realiza tras superar la tolerancia de la sesión, se añade de forma condicional el cálculo de minutos tarde. |
| 8 | `«extend»` | `CU-10` → `CU-08` | *Ante impedimento o falla reportada* | Cuando la contingencia manual obedece a falla técnica, falta de dispositivo o condición especial del aprendiz, se añade el detalle de novedad de contingencia. |

---

## 3. Evolución Respecto al Diagrama de Semana 16

En `03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio` existían solo `5` casos de uso planos con un único actor (`Instructor`) y `3` relaciones `«include»` hacia pasos de interfaz (*Mostrar lista*, *Registrar estado*, *Guardar registro*) sin ningún `«extend»`. En la versión actual se corrigió la granularidad (un objetivo de negocio por caso, eliminando subpasos de UI como casos de uso), se incorporaron los actores `Aprendiz`, `Coordinador Académico`, `Servicio GPS` y `Temporizador`, y se añadieron relaciones `«include»` y `«extend»` con semántica y dirección UML estrictas.

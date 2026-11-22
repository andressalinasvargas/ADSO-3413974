# Plantillas Extendidas de Casos de Uso Críticos

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Caso de estudio:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha 3413974  
**Nota metodológica:** Redactadas estrictamente en lenguaje de dominio e intención actor-sistema, sin detalles de implementación técnica.

---

## 1. Caso de Uso `CU-03` · Abrir sesión de asistencia

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-03` · Abrir sesión de asistencia |
| **Requisitos que atiende** | `RF-03`, `RF-11` |
| **Actor primario / secundarios** | Primario: Instructor · Secundario: Ninguno |
| **Objetivo del actor** | Habilitar una sesión temporal de registro de asistencia para una ficha de formación, definiendo su tolerancia de tardanza y generando los mecanismos de acceso para los aprendices. |
| **Precondiciones** | 1. El instructor se encuentra autenticado en el sistema (`CU-01`).<br>2. Existe al menos una ficha de formación en estado activo con aprendices asociados. |
| **Disparador** | El instructor selecciona la opción *Iniciar toma de asistencia* desde el panel principal. |
| **Flujo principal** | 1. El instructor elige la ficha de formación correspondiente a la jornada.<br>2. El sistema carga la fecha y hora actual del centro de formación como hora oficial de inicio sugerida.<br>3. El instructor confirma o ajusta la hora oficial de inicio y define los minutos de tolerancia permitidos.<br>4. El instructor confirma la apertura de la sesión.<br>5. El sistema crea la sesión activa con una vigencia limitada de veinte minutos y genera un enlace dinámico para código QR y un código numérico único de seis dígitos.<br>6. El sistema presenta en pantalla el código QR rotativo cada treinta segundos, el código numérico de respaldo, el acceso al escáner del instructor y la lista en tiempo real de aprendices registrados (inicialmente vacía). |
| **Flujos alternos** | **3a.** Si el instructor requiere iniciar con tolerancia cero para control estricto de puntualidad, ingresa `0` minutos de tolerancia y el sistema acepta el parámetro aplicando tardanza desde el primer minuto posterior al inicio oficial.<br>**6a.** Si en el ambiente de formación hay aprendices sin cámara funcional, el instructor proyecta el código numérico de seis dígitos mostrado en la misma vista para que accedan mediante `CU-04` (flujo alterno `1a`). |
| **Excepciones** | **1b.** Si no existen fichas activas disponibles para el instructor, el sistema informa que debe existir al menos una ficha activa antes de abrir una sesión y detiene la apertura.<br>**3b.** Si el instructor ingresa una tolerancia fuera del rango permitido (menor a 0 o superior a 120 minutos), el sistema rechaza el envío, señala el campo inválido y solicita un valor dentro del rango. |
| **Postcondiciones** | Queda registrada una sesión de asistencia en estado abierto con ficha, instructor responsable, hora de inicio, tolerancia, vigencia de veinte minutos y código único de seis dígitos disponibles para captura en todos los canales. |
| **Reglas de negocio** | - Toda sesión tiene una duración de vigencia finita (20 minutos por defecto salvo cierre previo).<br>- El código numérico de 6 dígitos no puede repetirse entre sesiones activas simultáneas.<br>- Solo el instructor creador adquiere propiedad sobre la sesión para cierres y contingencias manuales. |
| **Pantalla del prototipo** | [pantalla-01-cu03-abrir-sesion.png](06-prototipo-inicial/pantalla-01-cu03-abrir-sesion.png) |

---

## 2. Caso de Uso `CU-04` · Registrar asistencia por QR o código

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-04` · Registrar asistencia por QR o código |
| **Requisitos que atiende** | `RF-04`, `RF-05`, `RF-06`, `RF-07`, `RF-10` |
| **Actor primario / secundarios** | Primario: Aprendiz · Secundario: Servicio de Geolocalización (GPS) |
| **Objetivo del actor** | Registrar de manera autónoma la propia asistencia a la sesión activa de su ficha utilizando su dispositivo móvil. |
| **Precondiciones** | 1. El aprendiz dispone de su número de documento de identidad y acceso al enlace del sistema o código dictado en clase.<br>2. Existe una sesión abierta previamente por el instructor (`CU-03`). |
| **Disparador** | El aprendiz apunta la cámara de su teléfono al código QR dinámico proyectado por el instructor o ingresa la dirección pública del módulo de código. |
| **Flujo principal** | 1. El aprendiz abre el enlace del código QR dinámico de la sesión activa.<br>2. El sistema verifica (`«include» CU-06`) que la ventana temporal del QR y la sesión sigan abiertas y vigentes.<br>3. El sistema muestra la ficha convocada, el formulario de documento de identidad y el aviso de autorización del tratamiento de datos personales.<br>4. El aprendiz ingresa su número de documento, marca la casilla de autorización expresa de tratamiento de datos personales y envía su registro (`«include» CU-05`).<br>5. El sistema solicita al Servicio de Geolocalización (GPS) la ubicación y precisión actual del dispositivo y verifica que el margen de error no supere los 100 metros ni salga del perímetro de la sede cuando la geocerca está habilitada (`«include» CU-05`).<br>6. El sistema verifica (`«include» CU-06`) que el aprendiz se encuentre activo, pertenezca a la ficha de la sesión y no cuente con un registro previo en esa misma sesión.<br>7. El sistema evalúa la hora de registro frente a la hora oficial de inicio más la tolerancia y almacena la asistencia con el consentimiento y las coordenadas geográficas.<br>8. El sistema presenta al aprendiz un comprobante en pantalla confirmando su nombre completo y el estado de puntualidad (*A tiempo*). |
| **Flujos alternos** | **1a.** Si el aprendiz no logra enfocar el código QR dinámico con su cámara, ingresa al acceso por código numérico, digita los 6 dígitos proyectados por el instructor y el sistema valida la vigencia de la sesión redirigiéndolo al paso 3.<br>**7a.** Si la hora del registro supera la hora oficial de inicio más los minutos de tolerancia, se activa la extensión `«extend» CU-09` (*Calcular y registrar tardanza*), almacenando los minutos de retraso y mostrando en el paso 8 la confirmación con el detalle de llegada tarde. |
| **Excepciones** | **2a.** Si el QR rotó fuera de su ventana vigente o la sesión ya cerró/venció, el sistema bloquea el formulario y muestra el aviso de código vencido o sesión no válida.<br>**4a.** Si el aprendiz intenta enviar sin marcar la autorización de tratamiento de datos personales, el sistema impide el registro y solicita la aceptación obligatoria.<br>**5a.** Si el aprendiz niega el permiso GPS o la precisión reportada supera los 100 metros, el sistema detiene el registro y solicita habilitar ubicación o acercarse a una zona con mejor señal.<br>**5b.** Si la geocerca de la sede está activa y la posición excede el radio autorizado, el sistema rechaza el registro por encontrarse fuera del perímetro.<br>**6a.** Si el documento no existe o el aprendiz está inactivo, el sistema informa que no fue encontrado y sugiere solicitar apoyo al instructor.<br>**6b.** Si el aprendiz pertenece a una ficha diferente o ya registró asistencia en la sesión, el sistema rechaza el envío informando el motivo específico. |
| **Postcondiciones** | Queda guardado un único registro de asistencia para el aprendiz en la sesión con fecha, hora, ubicación validada, consentimiento de datos y estado de puntualidad, visible inmediatamente en la lista del instructor. |
| **Reglas de negocio** | - No se permite más de una asistencia por aprendiz en una misma sesión.<br>- El consentimiento expreso (Ley 1581 de 2012) es requisito previo indispensable en el flujo móvil.<br>- La precisión geográfica aceptable es como máximo de 100 metros. |
| **Pantalla del prototipo** | [pantalla-02-cu04-registro-aprendiz.png](06-prototipo-inicial/pantalla-02-cu04-registro-aprendiz.png) |

---

## 3. Caso de Uso `CU-08` · Registrar asistencia por contingencia manual

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-08` · Registrar asistencia por contingencia manual |
| **Requisitos que atiende** | `RF-04`, `RF-07`, `RF-09`, `RF-10` |
| **Actor primario / secundarios** | Primario: Instructor · Secundario: Ninguno |
| **Objetivo del actor** | Anotar manualmente la asistencia de un aprendiz presente en el ambiente cuando este no puede completar el autorregistro por QR ni presentar su credencial para escaneo. |
| **Precondiciones** | 1. El instructor se encuentra autenticado (`CU-01`) y visualizando el detalle de una sesión de asistencia abierta (`CU-03`). |
| **Disparador** | Un aprendiz reporta imposibilidad de usar su celular o el instructor requiere registrar una contingencia desde el panel de la sesión. |
| **Flujo principal** | 1. El instructor digita el número de documento del aprendiz en el apartado de registro manual de la sesión activa.<br>2. El instructor confirma el registro manual.<br>3. El sistema verifica (`«include» CU-06`) que la sesión permanezca activa, vigente y pertenezca al instructor autenticado.<br>4. El sistema verifica (`«include» CU-06`) que el documento corresponda a un aprendiz activo de la ficha de la sesión y que no esté registrado previamente en esa sesión.<br>5. El sistema calcula si existe tardanza respecto a la hora oficial de inicio y tolerancia de la sesión, y registra la asistencia marcando su origen como registro manual del instructor.<br>6. El sistema recarga la vista de la sesión mostrando el aviso de confirmación y actualizando el contador y la lista de aprendices registrados. |
| **Flujos alternos** | **5a.** Si el registro manual ocurre después de vencida la tolerancia oficial de la sesión, el flujo se extiende mediante `«extend» CU-09` registrando los minutos de tardanza y mostrando la etiqueta correspondiente en la lista de asistentes.<br>**5b.** Si el registro responde a una causal especial (aprendiz sin teléfono, falla de conectividad o necesidad de accesibilidad), se activa opcionalmente `«extend» CU-10` (*Documentar novedad de contingencia*) para asociar la observación y tipo de novedad al registro. |
| **Excepciones** | **3a.** Si otro instructor diferente al creador intenta registrar manualmente sobre la sesión, o si la sesión ya venció o fue cerrada, el sistema rechaza la operación e informa falta de permisos o sesión expirada.<br>**4a.** Si el documento no corresponde a un aprendiz activo de la ficha convocada, el sistema rechaza el registro e informa que el aprendiz no existe o pertenece a otra ficha.<br>**4b.** Si el aprendiz ya cuenta con asistencia previa (por QR, código o escáner) en esa sesión, el sistema impide el duplicado y muestra una advertencia controlada. |
| **Postcondiciones** | La asistencia queda registrada de manera auditable como contingencia manual (sin datos GPS pero con puntualidad calculada y novedad opcional), incrementando el listado de asistentes de la sesión. |
| **Reglas de negocio** | - Solo el instructor propietario de la sesión puede efectuar registros manuales en ella.<br>- El registro manual respeta la misma unicidad por sesión y el mismo cálculo de tardanza que los canales automáticos. |
| **Pantalla del prototipo** | [pantalla-03-cu08-contingencia-manual.png](06-prototipo-inicial/pantalla-03-cu08-contingencia-manual.png) |

---

## 4. Caso de Uso `CU-12` · Consultar historial y generar reportes

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-12` · Consultar historial y generar reportes |
| **Requisitos que atiende** | `RF-12` |
| **Actor primario / secundarios** | Primario: Instructor, Coordinador Académico · Secundario: Ninguno |
| **Objetivo del actor** | Consultar los indicadores del día, revisar el historial detallado de asistencias con su estado de puntualidad, ubicación y auditoría de red, y consolidar reportes por ficha o fecha. |
| **Precondiciones** | 1. El instructor o coordinador académico ha iniciado sesión en el sistema (`CU-01`). |
| **Disparador** | El usuario selecciona la sección *Inicio* o *Asistencias* en la barra de navegación principal. |
| **Flujo principal** | 1. El usuario accede a la vista de historial y métricas operativas.<br>2. El sistema recupera los indicadores del día (aprendices activos, registros de hoy, fichas activas y alertas de red) junto con los registros ordenados cronológicamente.<br>3. El usuario revisa para cada asistencia la fecha y hora exacta, nombre y documento del aprendiz, ficha, estado de tardanza (*A tiempo* o minutos de retraso), estado de red y coordenadas geográficas cuando existan.<br>4. El usuario filtra o selecciona un registro con ubicación verificada o solicita la consolidación del resumen de asistencia de la jornada.<br>5. El sistema presenta el detalle geográfico de verificación en mapa externo o genera el resumen consolidado de asistentes, tardanzas y novedades.<br>6. El usuario valida la información académica y finaliza la consulta o exportación del reporte. |
| **Flujos alternos** | **3a.** Cuando una asistencia fue tomada mediante escáner o contingencia manual sin captura GPS, el sistema muestra explícitamente *No registrada* en la columna de ubicación sin impedir el análisis de puntualidad ni de red.<br>**4a.** Si el usuario requiere soporte institucional para archivo académico, solicita la vista consolidada de reporte por ficha/fecha para impresión o exportación. |
| **Excepciones** | **2a.** Si aún no existen registros de asistencia almacenados en el sistema, el sistema muestra contadores en cero y un mensaje informativo indicando que no hay asistencias registradas todavía, manteniendo disponibles las opciones de navegación.<br>**4b.** Si un registro presenta indicadores de anomalía en la red de origen, el sistema destaca visualmente el estado de alerta en el listado para revisión del instructor o coordinador. |
| **Postcondiciones** | El instructor o coordinador obtiene visibilidad trazable de la asistencia histórica, puntualidad y alertas de auditoría sin alterar la integridad de los registros almacenados. |
| **Reglas de negocio** | - Los registros históricos mostrados son inmutables desde la vista de consulta.<br>- Los aprendices inactivos conservan su historial previo visible para auditoría académica. |
| **Pantalla del prototipo** | [pantalla-04-cu12-historial-reportes.png](06-prototipo-inicial/pantalla-04-cu12-historial-reportes.png) |

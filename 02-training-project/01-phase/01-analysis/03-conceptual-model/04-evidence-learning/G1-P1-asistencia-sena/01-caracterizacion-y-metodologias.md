# Caracterización de la Solución y Selección de Metodología

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Caso de estudio:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha 3413974  
**Autor:** `@andressalinasvargas`

---

## 1. Caracterización de la Solución (4 Aspectos Obligatorios)

| Aspecto | Valor en el proyecto `asistencia-sena` | Evidencia / Implicación en el análisis |
| :--- | :--- | :--- |
| **1. Tipo de proyecto** | Aplicación web de gestión operativa y auditoría en tiempo real para entorno educativo (SENA), con flujo multi-actor (escritorio para instructor/coordinador y móvil para aprendiz) y restricciones legales de tratamiento de datos (Ley 1581 de 2012). | Requiere modelar claramente fronteras del sistema, reglas de validación en tiempo real (vigencia, ficha, GPS, tardanza) y trazabilidad de principio a fin. |
| **2. Tamaño del equipo** | Equipo pequeño / trabajo individual en la fase de refinamiento de análisis y diseño (`1` aprendiz responsable por entrega sobre base modular trabajada en semanas 16–19). | No soporta burocracia documental pesada ni ceremonias extensas; necesita artefactos concisos, altamente trazables y con ciclos cortos de revisión. |
| **3. Estabilidad de requisitos** | Media-baja durante el descubrimiento inicial: el alcance evolucionó desde toma manual simple (semana 16) hacia QR rotativo + código de 6 dígitos (semana 17), plan de contingencia y política de datos (semana 18–19) y validación geoespacial. | La metodología debe absorber cambios frecuentes en reglas de validación y nuevos canales sin rehacer toda la documentación desde cero. |
| **4. Disponibilidad del cliente / usuario** | Alta en hitos semanales: el instructor (representante del cliente y usuario principal) realiza revisiones periódicas en sesiones de formación y socializaciones semanales, pero no participa de tiempo completo en la programación diaria. | Exige entregas incrementales revisables cada semana con prototipos visuales y listas de chequeo verificables antes de pasar a construcción. |

---

## 2. Comparación de Metodologías de Desarrollo (4 Metodologías vs. 5 Criterios de la Caracterización)

Se evalúan **RUP**, **Scrum**, **XP (Programación Extrema)** y **RAD (Desarrollo Rápido de Aplicaciones)** frente a criterios derivados directamente de la caracterización de la Sección 1:

| Criterio (derivado de la caracterización) | RUP (Rational Unified Process) | Scrum | XP (Extreme Programming) | RAD (Rapid Application Development) |
| :--- | :--- | :--- | :--- | :--- |
| **C1. Adaptación a tamaño de equipo pequeño (1–3 personas)** | **Baja:** requiere múltiples roles especializados (arquitecto, analista, gestor de configuración) y extensa documentación por fase. | **Alta:** adaptable con roles ligeros (*Product Owner* asumido por instructor/cliente en revisiones y desarrollo autónomo en sprints cortos). | **Media-alta:** orientada a equipos pequeños, aunque prácticas como *pair programming* estricto asumen al menos 2 desarrolladores en pareja continua. | **Media-alta:** funciona bien en grupos reducidos enfocados en prototipado rápido. |
| **C2. Manejo de estabilidad media-baja de requisitos** | **Media:** iterativo, pero los cambios de alcance en fase de elaboración demandan actualización formal de múltiples artefactos de control. | **Muy alta:** mediante el *Product Backlog* priorizado (MoSCoW) permite reordenar o refinar requisitos entre iteraciones sin romper el flujo. | **Muy alta:** abraza el cambio continuo mediante historias cortas y ciclos muy breves. | **Media:** prioriza velocidad de prototipo sobre estabilidad arquitectónica y trazabilidad formal de reglas. |
| **C3. Acoplamiento con disponibilidad semanal del cliente** | **Media:** las revisiones se concentran al cierre de cada fase (Inicio, Elaboración, Construcción, Transición). | **Muy alta:** la *Sprint Review* semanal coincide exactamente con la disponibilidad del instructor en sesiones presenciales para validar avances y prototipos. | **Baja-media:** asume un *cliente en sitio* (*on-site customer*) disponible de forma permanente para resolver dudas al instante. | **Media:** requiere talleres JAD intensivos de usuario al inicio para congelar pantallas rápidamente. |
| **C4. Rigor para requisitos legales, trazabilidad y modelos UML** | **Muy alta:** fuerte en modelado UML y matrices de trazabilidad. | **Alta (con definición de *Done*):** permite incluir dentro de cada iteración criterios de aceptación, trazabilidad UML y verificación legal sin sobre-documentar. | **Baja:** prioriza código sobre diagramas conceptuales y matrices formales de requisitos. | **Baja:** tiende a descuidar documentación formal de reglas de negocio y trazabilidad. |
| **C5. Control de riesgos críticos (seguridad y contingencia)** | **Alta:** evalúa riesgos por iteración desde la fase de elaboración. | **Alta:** el backlog prioriza primero los riesgos críticos (duplicados, suplantación, contingencia) desde el primer sprint. | **Media:** fuerte en pruebas automatizadas, menos explícita en modelado de seguridad de datos y auditoría previa. | **Baja:** suele posponer seguridad y manejo de excepciones para el final. |

---

## 3. Selección y Justificación Metodológica

### Metodología seleccionada: **Scrum (adaptado a sprints cortos semanales con prácticas de modelado UML y MoSCoW)**

**Justificación basada en la caracterización:**
1. **Alineación con la disponibilidad semanal del cliente (C3):** La revisión periódica del instructor en clase encaja directamente con la ceremonia de **Sprint Review**, permitiendo validar prototipos y flujos de asistencia al cierre de cada iteración sin requerir un cliente sentado tiempo completo (desventaja de **XP**).
2. **Respuesta a requisitos evolutivos en un equipo pequeño (C1, C2):** La evolución vivida entre semana 16 (registro manual) y semana 19 (QR rotativo, contingencia y Ley 1581) demuestra que el sistema requiere un **Product Backlog priorizado** (técnica MoSCoW aplicada en semana 18) propio de **Scrum**, evitando la carga documental excesiva de **RUP** para un equipo individual/pequeño.
3. **Equilibrio entre agilidad y trazabilidad formal (C4, C5):** A diferencia de **RAD** (que sacrifica trazabilidad y rigor en excepciones) y **XP puro** (que minimiza los artefactos de análisis), **Scrum** permite definir como *Definition of Done* de la fase de análisis la entrega de casos de uso UML, dominio, MER, prototipos y lista de chequeo verificada.

### Por qué se descartan las otras metodologías
- **RUP:** Descartada por sobrecarga de roles y ceremonial pesado para un equipo de 1 aprendiz en ventana de entrega corta.
- **XP:** Descartada como marco único porque exige cliente disponible permanentemente (*on-site customer*) y programación en parejas continua, además de no cubrir la documentación formal de análisis UML/MER exigida en el proyecto SENA.
- **RAD:** Descartada porque sacrifica el rigor de verificación de reglas de negocio críticas (prevención de duplicados, geocerca, cumplimiento de Habeas Data) en favor de prototipos desechables.

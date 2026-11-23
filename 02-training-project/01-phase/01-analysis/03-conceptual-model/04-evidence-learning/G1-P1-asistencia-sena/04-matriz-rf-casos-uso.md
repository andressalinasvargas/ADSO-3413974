# Matriz de Cobertura: Requisitos Funcionales → Casos de Uso

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Caso de estudio:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha 3413974

---

## 1. Matriz de Trazabilidad `RF → Caso de Uso` (100 % de Cobertura)

| ID Requisito | Título del Requisito Funcional | Caso(s) de Uso que lo atiende(n) | Estado de cobertura | Observación de trazabilidad |
| :--- | :--- | :--- | :---: | :--- |
| **RF-01** | Autenticación de usuarios administrativos | `CU-01` Autenticar usuario | ✅ Cubierto | Cubre acceso de Instructor y Coordinador Académico antes de operar funciones protegidas. |
| **RF-02** | Gestión de fichas y aprendices | `CU-02` Gestionar aprendices y credenciales QR | ✅ Cubierto | Agrupa alta, asignación de ficha, activación/inactivación lógica y emisión de credencial QR sin fragmentar CRUD. |
| **RF-03** | Apertura de sesión de asistencia | `CU-03` Abrir sesión de asistencia | ✅ Cubierto | Genera la sesión activa con tolerancia, enlace QR dinámico y código numérico de respaldo. |
| **RF-04** | Validación de vigencia y pertenencia a ficha | `CU-06` Verificar vigencia de sesión y pertenencia a ficha | ✅ Cubierto | Incluido obligatoriamente (`«include»`) por los tres canales de captura (`CU-04`, `CU-07`, `CU-08`). |
| **RF-05** | Autorregistro móvil del aprendiz | `CU-04` Registrar asistencia por QR o código | ✅ Cubierto | Flujo principal del aprendiz desde dispositivo móvil. |
| **RF-06** | Validación de ubicación y consentimiento de datos | `CU-05` Validar ubicación y consentimiento de datos | ✅ Cubierto | Caso incluido obligatoriamente (`«include»`) dentro de `CU-04` con apoyo del actor secundario `Servicio GPS`. |
| **RF-07** | Prevención de registros duplicados | `CU-06` Verificar vigencia de sesión y pertenencia a ficha | ✅ Cubierto | La verificación previa al almacenamiento impide duplicados por aprendiz y sesión en cualquier canal. |
| **RF-08** | Registro mediante escáner de credencial QR | `CU-07` Registrar asistencia mediante escáner QR | ✅ Cubierto | Canal presencial operado por el instructor cuando el aprendiz presenta su credencial individual. |
| **RF-09** | Registro manual y novedades de contingencia | `CU-08` Registrar asistencia por contingencia manual · `CU-10` Documentar novedad de contingencia | ✅ Cubierto | El flujo base registra por documento (`CU-08`) y la extensión opcional (`CU-10`) documenta la causal de contingencia. |
| **RF-10** | Cálculo automático de tardanza | `CU-09` Calcular y registrar tardanza | ✅ Cubierto | Extiende (`«extend»`) los tres canales de captura (`CU-04`, `CU-07`, `CU-08`) cuando se excede la tolerancia. |
| **RF-11** | Cierre manual y automático de sesión | `CU-11` Cerrar sesión de asistencia | ✅ Cubierto | Atiende cierre manual del instructor y cierre automático al vencimiento por `Temporizador del Sistema`. |
| **RF-12** | Consulta de historial y generación de reportes | `CU-12` Consultar historial y generar reportes | ✅ Cubierto | Atiende monitoreo en vivo, consulta histórica por fecha/ficha y exportación de reportes. |

**Porcentaje de cobertura de Requisitos Funcionales:** **12 / 12 = 100 %**.

---

## 2. Distinción Explícita Frente a Requisitos No Funcionales (RNF)

Los requisitos no funcionales (`RNF-01` a `RNF-06`) **no se modelan como casos de uso**, ya que no representan objetivos funcionales discretos de un actor, sino **restricciones de calidad, seguridad, desempeño y marco legal** transversales al sistema:

| ID RNF | Categoría | Casos de Uso sobre los que actúa como restricción |
| :--- | :--- | :--- |
| **RNF-01** | Seguridad y Control de Acceso | Aplica sobre `CU-01` a `CU-12` (autenticación, verificación de autoría del instructor en `CU-03`, `CU-08`, `CU-11` y protección contra suplantación). |
| **RNF-02** | Cumplimiento Legal (Habeas Data) | Aplica directamente sobre `CU-02` (borrado lógico sin pérdida histórica) y `CU-05` (autorización expresa Ley 1581 de 2012). |
| **RNF-03** | Rendimiento y Respuesta | Aplica sobre `CU-04`, `CU-07`, `CU-08` y `CU-12` (tiempos de validación y carga rápida durante la jornada). |
| **RNF-04** | Usabilidad y Accesibilidad Móvil | Aplica sobre `CU-04` y `CU-05` (operación móvil en ≤ 3 pasos y mensajes claros en español). |
| **RNF-05** | Disponibilidad y Contingencia | Aplica sobre `CU-04` (código de respaldo), `CU-08` y `CU-10` (garantía de registro ante fallas de red o accesibilidad). |
| **RNF-06** | Integridad y Trazabilidad de Auditoría | Aplica sobre `CU-06`, `CU-09`, `CU-10` y `CU-12` (registro inmutable de marca de tiempo, canal, tardanza y estado de red). |

---

## 3. Verificación Inversa (`Caso de Uso → RF`) — Auditoría Día 2 (`2026-11-23`)

Para confirmar que no existen casos de uso huérfanos ni objetivos fuera del alcance antes de pasar a diseño (Guía 2), se valida la trazabilidad en sentido inverso sobre los **12 casos de uso**:

| ID CU | Caso de Uso | Actor(es) | Requisito(s) Funcional(es) que atiende | RNF transversales asociados | Estado |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **CU-01** | Autenticar usuario | Instructor, Coordinador Académico | `RF-01` | `RNF-01` | ✅ Trazado |
| **CU-02** | Gestionar aprendices y credenciales QR | Instructor | `RF-02` | `RNF-02` | ✅ Trazado |
| **CU-03** | Abrir sesión de asistencia | Instructor | `RF-03` | `RNF-01` | ✅ Trazado |
| **CU-04** | Registrar asistencia por QR o código | Aprendiz | `RF-05` | `RNF-03`, `RNF-04`, `RNF-05` | ✅ Trazado |
| **CU-05** | Validar ubicación y consentimiento de datos | *(Incluido en CU-04)* · Servicio GPS | `RF-06` | `RNF-02`, `RNF-04` | ✅ Trazado |
| **CU-06** | Verificar vigencia de sesión y pertenencia a ficha | *(Incluido en CU-04, CU-07, CU-08)* | `RF-04`, `RF-07` | `RNF-06` | ✅ Trazado |
| **CU-07** | Registrar asistencia mediante escáner QR | Instructor | `RF-08` | `RNF-03` | ✅ Trazado |
| **CU-08** | Registrar asistencia por contingencia manual | Instructor | `RF-09` | `RNF-01`, `RNF-05` | ✅ Trazado |
| **CU-09** | Calcular y registrar tardanza | *(Extiende a CU-04, CU-07, CU-08)* | `RF-10` | `RNF-06` | ✅ Trazado |
| **CU-10** | Documentar novedad de contingencia | *(Extiende a CU-08)* | `RF-09` | `RNF-05`, `RNF-06` | ✅ Trazado |
| **CU-11** | Cerrar sesión de asistencia | Instructor, Temporizador del Sistema | `RF-11` | `RNF-01` | ✅ Trazado |
| **CU-12** | Consultar historial y generar reportes | Instructor, Coordinador Académico | `RF-12` | `RNF-03`, `RNF-06` | ✅ Trazado |

**Resultado de verificación bidireccional (`2026-11-23`):** `12 / 12` requisitos funcionales cubiertos y `12 / 12` casos de uso justificados (`0` casos huérfanos), validando la coherencia de entrada para los artefactos de diseño de la Guía 2.

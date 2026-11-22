# Insumo Base de Requisitos (SRS Consolidado) — Sistema Web de Control de Asistencia SENA

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Ficha:** 3413974 · Análisis y Desarrollo de Software (ADSO)  
**Origen reutilizado:** `03-execute/16-week/02-optional-activity/Tema Tomar asistencia_0.1.txt`, `03-execute/17-week/02-optional-activity/Sistema_Asistencia_1.1.txt` y `03-execute/19-week/02-optional-activity/Resumen_Socializacion_MVP.md`

---

## 1. Propósito y Alcance del Sistema

Optimizar y auditar la toma de asistencia en jornadas de formación del SENA (Ficha 3413974 y futuras fichas de formación), sustituyendo el registro manual disperso por una plataforma web multi-canal que opera con:

- **Sesiones temporales de asistencia** abiertas por el instructor con hora oficial de inicio y tolerancia configurable.
- **Autorregistro del aprendiz** mediante código QR dinámico o código numérico de verificación, con validación de pertenencia a la ficha, geolocalización y consentimiento expreso de tratamiento de datos.
- **Lectura por escáner QR del instructor** sobre la credencial del aprendiz.
- **Registro manual de contingencia** con justificación auditable para aprendices sin dispositivo móvil, con impedimentos físicos o ante fallas de conectividad.

---

## 2. Requisitos Funcionales (`RF-01` a `RF-12`)

| ID | Nombre del Requisito | Descripción funcional (libre de implementación) | Prioridad (MoSCoW) |
| :--- | :--- | :--- | :--- |
| **RF-01** | Autenticación de usuarios administrativos | El sistema debe permitir el ingreso autenticado de instructores y coordinadores académicos con credenciales personales válidas, habilitando el acceso únicamente a las funciones de su rol. | Must |
| **RF-02** | Gestión de fichas y aprendices | El sistema debe permitir registrar aprendices con documento único, nombre, correo institucional y ficha asignada, emitir su credencial QR individual y activar o inactivar lógicamente tanto fichas como aprendices sin perder su historial. | Must |
| **RF-03** | Apertura de sesión de asistencia | El sistema debe permitir al instructor abrir una sesión vinculada a una ficha de formación, indicando hora oficial de inicio, minutos de tolerancia y vigencia temporal, generando un enlace QR dinámico y un código numérico de respaldo. | Must |
| **RF-04** | Validación de vigencia y pertenencia a ficha | Al intentar registrar una asistencia por cualquier canal, el sistema debe verificar que la sesión esté abierta y vigente, que el aprendiz esté activo y que pertenezca a la ficha convocada. | Must |
| **RF-05** | Autorregistro móvil del aprendiz | El sistema debe permitir al aprendiz ingresar mediante el QR rotativo o el código numérico de 6 dígitos, registrar su número de documento y confirmar su asistencia en la sesión activa. | Must |
| **RF-06** | Validación de ubicación y consentimiento de datos | Antes de aceptar el autorregistro móvil, el sistema debe solicitar la autorización expresa del aprendiz para el tratamiento de sus datos personales y validar la ubicación geográfica con precisión aceptable y dentro del perímetro de la sede (cuando esté habilitado). | Must |
| **RF-07** | Prevención de registros duplicados | El sistema debe impedir que un mismo aprendiz quede registrado más de una vez dentro de una misma sesión de asistencia, sin importar qué canal de captura se utilice. | Must |
| **RF-08** | Registro mediante escáner de credencial QR | El sistema debe permitir al instructor escanear la credencial QR individual del aprendiz (o ingresar su código de credencial) dentro de la sesión activa para registrar su asistencia. | Should |
| **RF-09** | Registro manual y novedades de contingencia | El sistema debe permitir al instructor propietario de la sesión registrar manualmente a un aprendiz por documento y documentar una novedad o motivo de contingencia cuando existan fallas técnicas o impedimentos de acceso. | Must |
| **RF-10** | Cálculo automático de tardanza | El sistema debe determinar si el registro ocurrió dentro del margen de tolerancia o fuera de él, calculando y almacenando los minutos de retraso respecto a la hora oficial de inicio. | Should |
| **RF-11** | Cierre manual y automático de sesión | El sistema debe permitir al instructor propietario cerrar anticipadamente la sesión activa y cerrarla automáticamente cuando venza su tiempo límite, bloqueando nuevos registros en todos los canales. | Must |
| **RF-12** | Consulta de historial y generación de reportes | El sistema debe permitir a instructores y coordinadores consultar la lista en vivo, el historial por fecha/ficha/aprendiz, el resumen de puntualidad y exportar reportes consolidados de asistencia. | Should |

---

## 3. Requisitos No Funcionales (`RNF-01` a `RNF-06`)

> **Distinción explícita frente a los RF:** Los requisitos no funcionales describen atributos de calidad, restricciones operativas y marco normativo transversal; por lo tanto **no constituyen casos de uso independientes**, sino restricciones verificables sobre los casos de uso del sistema.

| ID | Categoría | Descripción del Requisito No Funcional | Criterio verificable |
| :--- | :--- | :--- | :--- |
| **RNF-01** | Seguridad y Control de Acceso | Protección contra suplantación de sesiones, acceso anónimo a módulos privados, falsificación de solicitudes e inyección de código. | 100 % de rutas protegidas requieren sesión válida y verificación de autoría del propietario de la sesión. |
| **RNF-02** | Cumplimiento Legal (Habeas Data) | Cumplimiento de la Ley Estatutaria 1581 de 2012 y Decreto 1377 de 2013 mediante consentimiento previo, política visible y derechos de rectificación/supresión (borrado lógico). | Todo autorregistro móvil exige aceptación explícita previa; ningún aprendiz ni ficha se elimina físicamente si posee historial. |
| **RNF-03** | Rendimiento y Respuesta | Tiempo de carga de vistas operativas y validación del registro en un margen ágil acorde con el ritmo de inicio de clase. | Consulta de listado y validación de asistencia respondidas en menos de 2 segundos en red local/institucional. |
| **RNF-04** | Usabilidad y Accesibilidad Móvil | Interfaz clara, mensajes de error descriptivos en español y diseño adaptable a teléfonos inteligentes sin desplazamiento horizontal. | Flujo del aprendiz operable en máximo 3 pasos en pantallas desde 390 px de ancho. |
| **RNF-05** | Disponibilidad y Contingencia | Continuidad operativa del registro de asistencia ante ausencia de dispositivos móviles, fallos de cámara o restricciones de GPS. | Siempre existen canales alternos (código de 6 dígitos y registro manual con novedad). |
| **RNF-06** | Integridad y Trazabilidad de Auditoría | Conservación inmutable de fecha/hora, canal de captura, estado de red y novedades de contingencia para fines académicos. | Cada registro conserva marca temporal, origen y datos de auditoría verificables por el coordinador. |

# Resumen de Socialización del MVP — Week 19

**Programa:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Aprendiz:** Andrés Fernando Salinas Vargas  
**Semana:** Week 19  

---

## 1. Contexto de la sesión

En la semana 19 se realizó la socialización de los **Productos Mínimos Viables (MVP)** desarrollados por los grupos, presentando la evolución del sistema construido entre las semanas 16, 17 y 18: **Sistema Web de Toma de Asistencia SENA** (`Sistema_Asistencia_V2.zip`). Algunos equipos quedaron con pendientes de sustentación o ajustes técnicos derivados de las observaciones del instructor.

---

## 2. MVP Socializado: Sistema Web de Toma de Asistencia SENA (V2)

El MVP presentado resuelve la lentitud y dependencia de la toma de asistencia tradicional mediante una aplicación web en PHP + MySQL orientada a la gestión rápida por ficha de formación:

### Funcionalidades principales demostradas
- **Gestión de fichas (`index.php`, `panel_ficha.php`):** creación, visualización, archivado y reactivación de fichas de formación (evitando pérdida de historial).
- **Gestión de aprendices (`aprendices.php`, `aprendiz_accion.php`):** listado único, validaciones de tipo de documento (`CC`, `TI`, `CE`, `PA`) y unicidad del número de documento.
- **Toma de asistencia con QR rotativo y checkpoint (`abrir_checkpoint.php`, `api_codigo.php`, `rotar_codigo.php`, `qr.php`, `registro_qr.php`, `cerrar_checkpoint.php`):** apertura de ventana de registro por sesión, código dinámico rotativo y cierre automático que marca ausentes a quienes no registraron.
- **Toma manual e historial (`tomar_asistencia.php`, `guardar.php`, `editar.php`, `historial.php`, `auditoria.php`):** registro directo en pantalla única (`Asistió`, `Tarde`, `Ausente`), consulta histórica y trazabilidad de modificaciones manuales.
- **Módulo de contingencia integrado (`contingencia.php`):** soporte operativo para aprendices sin teléfono móvil, con discapacidad visual, auditiva o motriz, fallas de QR, caída de red o aprendiz no registrado.
- **Política de datos y retención (`politica_datos.php`):** lineamientos bajo Ley 1581 de 2012 y Decreto 1377 de 2013 (Colombia) e identificación de registros con antigüedad superior a 2 años.

---

## 3. Hallazgos de ingeniería inversa y pendientes de la socialización

A partir de la revisión realizada sobre el MVP (documentada en [`Ingeniería inversa apuntes.txt`](../../18-week/02-optional-activity/Ingenier%C3%ADa%20inversa%20apuntes.txt)), quedaron cubiertos y en seguimiento los siguientes puntos:

| Hallazgo / Compromiso | Estado en MVP V2 | Acción / Seguimiento |
| :--- | :--- | :--- |
| Plan de contingencia para casos especiales y discapacidad | Implementado en `contingencia.php` | Validado en socialización |
| Control de repetición en nombres y asistencias duplicadas | Controlado por checkpoint y documento único | Verificar pruebas con múltiples fichas |
| Política de retención y borrado de datos del aprendiz | Implementado en `politica_datos.php` | Definir flujo de depuración programada |
| Manejo de fichas creadas (no permitir pérdida de datos) | Implementado archivado/reactivación de fichas | Documentar regla de negocio |
| Restricciones en `tipo_doc` del aprendiz | Restringido a `ENUM('CC','TI','CE','PA')` | Mantener validación en frontend y backend |
| Equipos pendientes de socializar / validar E2E | Pendiente de cierre en siguientes sesiones | Completar validación extrema a extremo (ver Week 27) |

---

## 4. Referencias a artefactos del MVP en el repositorio

- **Week 16 (Modelado UML):** [`Tema Tomar asistencia_0.1.txt`](../../16-week/02-optional-activity/Tema%20Tomar%20asistencia_0.1.txt) · [`Diagramas_UML_Asistencia_SENA.drawio`](../../16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio)
- **Week 17 (Mockups y MVP V1):** [`Sistema_Asistencia_1.1.txt`](../../17-week/02-optional-activity/Sistema_Asistencia_1.1.txt) · [`Sistema_Asistencia.zip`](../../17-week/02-optional-activity/Sistema_Asistencia.zip)
- **Week 18 (MVP V2 e Ingeniería Inversa):** [`Sistema_Asistencia_V2.zip`](../../18-week/02-optional-activity/Sistema_Asistencia_V2.zip) · [`Plan de contingencia.png`](../../18-week/02-optional-activity/Plan%20de%20contingencia.png)
- **Week 27 (Validación E2E):** [`Presentacion_E2E_SENA_Foco_E2E.pptx`](../../27-week/02-optional-activity/Presentacion_E2E_SENA_Foco_E2E.pptx) · [`Validación_y_Despliegue_Sistema_de_Asistencia_SENA.pptx`](../../27-week/02-optional-activity/Validaci%C3%B3n_y_Despliegue_Sistema_de_Asistencia_SENA.pptx)

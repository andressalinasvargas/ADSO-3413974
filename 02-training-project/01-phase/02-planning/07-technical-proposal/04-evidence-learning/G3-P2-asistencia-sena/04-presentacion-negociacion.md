# B4 · Presentación de Negociación a la Contraparte y Guion de `10` Minutos (`G3-P2`)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Documento vinculado:** [`03-propuesta-tecnica-v1.0.md`](03-propuesta-tecnica-v1.0.md) (`PROP-ASIS-SENA-2026-v1.0`) · Ficha `3413974`  
**Autor / Expositor:** `@andressalinasvargas` · **Fecha:** `2026-11-24`  
**Duración objetivo:** `10` minutos de exposición + sesión de preguntas/observaciones para diligenciar el Acta de Validación (`B5`).

---

## 1. Preparación Estratégica de la Negociación (Declaración Previa)

| Elemento estratégico | Definición concreta para la reunión con la contraparte (`Variante B Provisional`) |
| :--- | :--- |
| **Propósito de la reunión** | Presentar la propuesta `v1.0` enfocada en resolver los retrasos, suplantaciones y riesgos legales del control de asistencia, validar supuestos técnicos/operativos en `2` sedes y recolectar observaciones formales para emitir el acta `B5` y la versión ajustada `v1.1`. |
| **Objetivo concreto** | Obtener visto bueno técnico sobre arquitectura/ANS y preacuerdo económico dentro del tope institucional (`$70.000.000 COP`), pactando forma de pago `30 / 40 / 30 %` contra hitos verificables (`H1`, `H2`, `H4`). |
| **Posición ideal** | Contrato completo por **`$65.268.598 COP` (IVA `19 %` incluido)** —costo base `$53.520.250` + margen `18 %` sobre precio—, plazo de `8` semanas (`40` días hábiles), `2` lectores Zebra DS2208-SR, reserva de contingencia de `$3.000.000 sin IVA`, `12` meses de nube/soporte ANS y pagos `30 / 40 / 30 %`. |
| **Posición mínima aceptable (Línea de reserva)** | Precio piso de **`$59.466.944 COP` (IVA incluido)** reduciendo el margen comercial al `10 %` sobre precio (`$53.520.250 / (1 - 0,10)`) **sin sacrificar pruebas E2E ni respaldos S3**, o ajuste pactado de bolsa de soporte de `12` a `6` meses manteniendo invariables el alcance funcional `RF-01`–`RF-12` y la garantía de defectos de `6` meses. |
| **MAAN (BATNA — Mejor Alternativa a un Acuerdo Negociado)** | Si el presupuesto disponible queda por debajo del costo mínimo de ejecución segura (`$53.520.250` con IVA en Variante B a la medida), ofrecer un **despliegue simplificado de alcance acotado** reutilizando la base funcional sin desarrollos nuevos a medida ni hardware adicional, o cerrar respetuosamente sin comprometer el cumplimiento de `ANS-01` (`99,5 %`) ni `Ley 1581`. |

---

## 2. Guion Gráfico de Presentación (`10` Diapositivas — Ordenado por el Interés del Cliente)

### Diapositiva 1 · Portada Ejecutiva (`0:00 – 0:45`)
- **Título:** *Control de Asistencia Institucional en Tiempo Real, Sin Filas y Conforme a Ley 1581*
- **Contenido visual:** Propuesta `asistencia-sena` `v1.0` · Variante B (`120` usuarios, `30` concurrentes, `2` sedes) · Plazo `8` semanas · Inversión dentro del tope (`$65,27 M` IVA incl. vs `$70,00 M`).
- **Guion oral (`0:45`):** *"Buenos días. El objetivo de estos diez minutos no es hablar solo de servidores, sino mostrar cómo eliminamos la pérdida de tiempo en el llamado de lista y los riesgos de suplantación o datos personales en nuestras 2 sedes, entregando una solución lista en 8 semanas y por debajo del techo presupuestal."*

### Diapositiva 2 · El Problema Actual y Su Costo Oculto (`0:45 – 1:45`)
- **Título:** *Por qué las planillas físicas y hojas sueltas cuestan tiempo y confiabilidad*
- **Contenido visual (3 dolores del cliente):**
  1. `8–15 min` perdidos por sesión llamando lista al inicio de jornada.
  2. Suplantación de firmas y demora de días para detectar tardanzas o ausencias reiteradas.
  3. Riesgo normativo al recolectar datos sin registro verificable de autorización (`Ley 1581`).
- **Guion oral (`1:00`):** *"Hoy cada jornada pierde minutos valiosos de formación y deja brechas entre lo que ocurre en el aula y lo que llega a coordinación. Además, recolectar registros sin autorización auditable expone a la institución ante la Ley 1581."*

### Diapositiva 3 · Impacto y Beneficios Medibles para la Institución (`1:45 – 2:45`)
- **Título:** *Qué gana la coordinación académica desde la semana 8*
- **Contenido visual (KPIs antes vs. después):**
  - Registro de asistencia por aprendiz: de `~10 min` en grupo -> **`≤ 2,0 s` (`p95`)** por transacción simultánea (`30` concurrentes).
  - Consolidado de inasistencias/tardanzas y exportación CSV UTF-8: **`1` clic en tiempo real**.
  - Registros duplicados aceptados por sesión: **`0 %`** (bloqueo directo en motor transaccional `MariaDB`).
- **Guion oral (`1:00`):** *"El beneficio concreto para instructores y coordinadores es recuperar el tiempo efectivo de clase, contar con reportes instantáneos para prevenir deserción y asegurar un registro único por aprendiz y sesión sin reprocesos en Excel."*

### Diapositiva 4 · Cómo Funciona en el Aula: `4` Canales Sin Fricción (`2:45 – 3:55`)
- **Título:** *Ningún aprendiz queda por fuera si falla la cámara o la señal celular*
- **Contenido visual (flujo simple de 4 rutas):**
  1. **Autorregistro móvil (`BYOD`)** con código QR rotativo + código de `6` dígitos + consentimiento Ley 1581.
  2. **Validación de sede (`geocerca Haversine ≤ 100 m`)** y auditoría de red.
  3. **Lector óptico USB `Zebra DS2208-SR`** en recepción de cada sede (lectura instantánea sobre pantalla o carné).
  4. **Contingencia manual con novedad auditada** operada por el instructor cuando hay falla eléctrica o de datos.
- **Guion oral (`1:10`):** *"No imponemos instalar aplicaciones en los celulares ni bloqueamos el ingreso si alguien no tiene datos: si falla el QR, existe código numérico, lector físico USB en cada sede y contingencia trazable del instructor."*

### Diapositiva 5 · Privacidad, Continuidad y Cero Gasto en Teléfonos o PCs (`3:55 – 4:55`)
- **Título:** *Infraestructura aislada, respaldos externos y aprovechamiento del hardware existente*
- **Contenido visual:** Esquema simplificado [`[N1]`–`[N7]`](03-diagrama-arquitectura-despliegue-g3.svg) resaltando en verde qué está **incluido** (`VPS DigitalOcean`, `TLS`, `S3 diario cifrado`, `Monitor 24/7`, `2 lectores QR`) y en gris qué queda **reutilizado/excluido** (`PCs actuales del SENA [N1]` y `celulares propios [N2]`).
- **Guion oral (`1:00`):** *"No cobramos licencias comerciales ni obligamos a comprar computadores nuevos: aprovechamos los equipos de instructores y celulares existentes, blindamos la base de datos en red privada y guardamos copias diarias cifradas fuera del servidor."*

### Diapositiva 6 · Plan de Trabajo en `8` Semanas e Hitos Verificables (`4:55 – 5:55`)
- **Título:** *Entrega gradual en `40` días hábiles sin sorpresas de última hora*
- **Contenido visual (Línea de tiempo `H1`–`H4` + Ruta Crítica):**
  - **Sem. 1–2 (`H1`):** BD 3FN + entorno `HTTPS` + gestión sedes/aprendices.
  - **Sem. 3–6 (`H2`):** Módulos QR/geocerca/reportes + respaldos S3 + **entrega física `2` lectores QR**.
  - **Sem. 7–8 (`H3`/`H4`):** Suite automatizada `Playwright`, capacitación `16 h` (`2` sedes), piloto real y salida a producción.
- **Guion oral (`1:00`):** *"En ocho semanas pasamos a producción con cuatro hitos visibles. Ustedes prueban avances desde la segunda semana y reciben los lectores físicos antes del piloto."*

### Diapositiva 7 · Niveles de Servicio (`ANS`) y Propiedad del Código (`5:55 – 6:55`)
- **Título:** *Garantías medibles por contrato y entrega total de derechos patrimoniales*
- **Contenido visual (4 compromisos `ANS` + Legal):**
  - Disponibilidad mensual **`≥ 99,5 %`** (medición independiente cada `60 s`) · Latencia **`p95 ≤ 2,0 s`**.
  - Respaldo diario **`RPO ≤ 24 h`** · Respuesta crítica **`P1 ≤ 30 min`** y **`RTO ≤ 2 h`**.
  - **Garantía código `6` meses** + **soporte `12` meses** + **cesión escrita de derechos patrimoniales (`Ley 23/1982`)**.
- **Guion oral (`1:00`):** *"Todo queda por escrito con indicadores medibles y penalizaciones claras en el ANS. Además, la institución recibe el código fuente completo con cesión escrita de derechos patrimoniales y sin ataduras de licencia por usuario."*

### Diapositiva 8 · Propuesta Económica Transparente vs. Tope Presupuestal (`6:55 – 8:05`)
- **Título:** *Solución integral con `$4,73 M` de margen por debajo del tope Variante B*
- **Contenido visual (Resumen gráfico desde `02-presupuesto-proyecto.xlsx`):**
  - Subtotal técnico (`Talento 390 h + Nube + 2 Lectores QR + Capacitación 16 h + Soporte 12m + Auditoría`): `$41.975.000` sin IVA
  - Reserva de contingencia (`R1`–`R6`, `7,15 %`): `$3.000.000` sin IVA
  - Costo Total Año 1 (con IVA `19 %`): `$53.520.250`
  - **Precio Total del Contrato (Margen `18 %` + IVA `19 %`):** **`$65.268.598 COP`** *(Tope: `$70.000.000` · Holgura: **`$4.731.402`**)*
  - Renovación operativa Año `2` y Año `3` (`TCO 36 meses` base con IVA): `$7,09 M` y `$7,28 M/año` (`TCO total $67.883.550`).
- **Guion oral (`1:10`):** *"La oferta llave en mano por el primer año —incluyendo software a la medida, los dos lectores Zebra, infraestructura nube, capacitación y doce meses de soporte— es de $65.268.598 IVA incluido, dejando más de cuatro millones setecientos mil pesos de margen bajo el techo de $70 millones."*

### Diapositiva 9 · Esquema de Pagos Contra Entregables y Riesgos Cubiertos (`8:05 – 9:05`)
- **Título:** *El cliente paga conforme verifica resultados reales*
- **Contenido visual:**
  - **Pago 1 (`30 %` = `$19.580.579`):** Firma e Hito `H1` (BD + entorno base).
  - **Pago 2 (`40 %` = `$26.107.439`):** Hito `H2` (software completo en pruebas + `2` lectores QR entregados).
  - **Pago 3 (`30 %` = `$19.580.580`):** Hito `H4` (piloto aprobado, capacitación `16 h`, producción y código fuente).
  - Cobertura explicita de `6` riesgos principales (`R1`–`R6`) y mitigación de conectividad en aula (`R7`).
- **Guion oral (`1:00`):** *"Protegemos la inversión vinculando cada desembolso a entregables auditables: el último treinta por ciento solo se factura cuando el sistema esté en producción, el personal capacitado y las actas firmadas."*

### Diapositiva 10 · Cierre y Preguntas para Validación Formal (`B5`) (`9:05 – 10:00`)
- **Título:** *Validemos juntos los ajustes antes de emitir la versión definitiva `v1.1`*
- **Contenido visual (`Checklist de 4 decisiones para la mesa`):**
  1. Confirmación de sedes (`2` en Variante B o ajuste si cambia a `A`/`C`/`D`).
  2. Validación de la tolerancia de tardanza (`15 min`) y radio de geocerca (`300 m`).
  3. Viabilidad de gestión de subdominio institucional para `TLS`.
  4. Revisión del esquema de pagos `30 / 40 / 30 %` y fecha de arranque del piloto.
- **Guion oral (`0:55`):** *"Con esto abrimos el espacio para escuchar sus observaciones técnicas, operativas o financieras. Cada ajuste que acuerdemos quedará documentado en el acta de validación y reflejado con números actualizados en la versión 1.1 de la propuesta."*

---

## 3. Banco de `4` Objeciones Anticipadas y Respuestas Preparadas

| # | Objeción probable de la contraparte | Causa / Preocupación real del cliente | Respuesta argumentada y evidencia de respaldo |
| :- | :--- | :--- | :--- |
| **1** | *"El monto de `$65,27 M` está cerca del tope; ¿podemos bajar el costo si ya existe un avance del sistema?"* | Optimizar presupuesto o validar si el cobro duplica trabajo previo. | Explicamos que el desglose ascendente (`A6` / `B2`) incluye `390 h` con endurecimiento de seguridad (`qrcode.min.js` local, `.htaccess`, `PDO`), suite automatizada `Playwright`, infraestructura gestionada, `2` lectores físicos Zebra (`FT-HW-02`), capacitación `16 h` en `2` sedes y `12` meses de soporte ANS. Si se requiere bajar hacia nuestra **posición mínima (`$59,47 M` IVA incl.)**, podemos ajustar el margen comercial del `18 %` al `10 %` o acotar la bolsa de soporte a `6` meses manteniendo intactos código, QA y seguridad. |
| **2** | *"¿Qué pasa si en algunos ambientes de formación no hay buena señal celular para que los aprendices escaneen el QR?"* | Temor a cuellos de botella operativos al inicio de clase (Riesgo `R7`). | Precisamente por eso `asistencia-sena` implementa **cuatro canales equivalentes**: el aprendiz sin cámara o señal pasa su carné/QR ante el **lector USB Zebra en recepción** (`< 0,5 s`), o el instructor proyecta el **código numérico de 6 dígitos**, o aplica **registro manual con novedad** (`RF-09`) desde su estación de aula `[N1]` sin frenar la clase. |
| **3** | *"¿El sistema puede invadir la privacidad de los aprendices al capturar su ubicación GPS?"* | Cumplimiento estricto de la Ley 1581 de 2012 y aceptación estudiantil. | El aplicativo **no rastrea en segundo plano ni almacena recorridos**. Solo solicita un único punto en el instante exacto del autorregistro tras marcar una casilla expresa de consentimiento informado (`consentimiento_datos = 1`), amparado por contrato escrito de **transmisión de datos** donde la institución sigue siendo Responsable única (`06-contrato-tdr-ans.md`). |
| **4** | *"¿Quedamos atados a un proveedor externo o a pagos de licencias crecientes si aumenta el número de aprendices?"* | Temor al *vendor lock-in* y costos ocultos a 3 años. | **Cero ataduras:** se entrega el código fuente completo con **cesión escrita de derechos patrimoniales (`Ley 23/1982`)**, todo el stack de producción es **Open Source (`$0` licencias por usuario)** y en `DigitalOcean` un cambio de `120` a `250` aprendices no exige reescribir software sino únicamente escalar el servidor por la diferencia de cuota mensual documentada en `05-condiciones-tecnicas.md`. |

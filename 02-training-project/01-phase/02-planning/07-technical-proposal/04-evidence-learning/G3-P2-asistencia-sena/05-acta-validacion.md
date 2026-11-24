# B5 · Acta de Validación de la Propuesta Técnica con la Contraparte (`asistencia-sena`)

**Código de acta:** `ACTA-VAL-G3-2026-01`  
**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P2 · Propuesta técnica y validación (`RAP 593061`)  
**Fecha del acta:** `2026-11-24` *(anterior a la fecha límite de entrega del `2026-12-05`)*  
**Escenario evaluado:** **Variante B (Provisional)** — `120` usuarios totales, `30` concurrentes pico, `2` sedes físicas, disponibilidad `≥ 99,5 %`, tope presupuestal Año 1 `$70.000.000 COP`.  
**Medio de validación:** Sesión de revisión técnica sobre [`03-propuesta-tecnica-v1.0.md`](03-propuesta-tecnica-v1.0.md) y [`04-presentacion-negociacion.md`](04-presentacion-negociacion.md), con trazabilidad en este repositorio público *(sin datos personales reales ni de terceros)*.

---

## 1. Participantes y Roles

| Usuario de GitHub | Rol en la validación | Distinción de autoría | Estado |
| :--- | :--- | :--- | :---: |
| **`@andressalinasvargas`** | **Proponente / Líder Técnico** *(Autor de la propuesta `v1.0`)* | Autor principal | Emitida |
| **`@Kevin81A`** | **Contraparte / Representante del Cliente SENA** *(Evaluador funcional y comercial)* | Usuario distinto al autor | **Sujeto a confirmación escrita previa al `2026-12-05 06:00 a. m.`** |

---

## 2. Sugerencias y Objeciones Convertidas en Requisitos Verificables (`5` Ítems Clasificados)

Durante la revisión guiada por las `10` diapositivas de `B4`, la contraparte formuló cinco observaciones concretas frente a los intereses de continuidad académica, desempeño al ingreso de jornada, ajuste presupuestal y alcance móvil:

| ID | Sugerencia u objeción de la contraparte | Requisito verificable resultante | Clasificación | Prioridad | Justificación técnica / de negocio | Efecto en costo (sin IVA) | Efecto en plazo |
| :- | :--- | :--- | :---: | :---: | :--- | :---: | :---: |
| **`SUG-01`** | *"Un respaldo diario cada 24 horas deja descubierto el turno de la mañana frente a una falla por la tarde; necesitamos menor ventana de pérdida."* | Configurar doble volcado diario `mysqldump --single-transaction` cifrado `AES-256` hacia S3 `[N6]` a las **`02:00 a. m.` y `02:00 p. m.` (`14:00`)**, reduciendo `ANS-03` (`RPO`) a **`≤ 12 horas`** con retención rotativa de `30` días (`60` snapshots). | **Aceptada** | **Alta** | La capacidad contratada en `DigitalOcean Spaces` (`250 GB`) soporta holgadamente `60` respaldos comprimidos (`~1,2 GB` acumulados); mejora sustancialmente la resiliencia y baja la probabilidad de `R5` (`15 % → 10 %`). | **`+$360.000`** (`+4 h` en `M10` a `$90.000/h`; `$0` adicional en S3) / **Contingencia `R5`: `-$200.000`** | `T08`: `4 d → 5 d` (`0 d` en ruta crítica por holgura de `13 d`) |
| **`SUG-02`** | *"En hora pico de 07:00 a. m. piden latencia inferior a 0,5 s y permitir que cada ficha ajuste si la tardanza cuenta desde los 10 o 20 minutos."* | Negociar meta contractual de latencia `p95` (`ANS-02`) de `≤ 2,0 s` a **`≤ 1,5 segundos`** bajo `30` concurrentes (`PHP OPcache` + tuning `InnoDB`) e incorporar parámetro **configurable de tolerancia por ficha (`5–30 min`, defecto `15 min`)** en `M07`. Se descarta garantizar `0,5 s` globales por variabilidad externa de redes móviles. | **Negociada** | **Alta** | Reducir `p95` a `1,5 s` es medible de extremo a extremo desde Colombia (`~60 ms` RTT VPS); parametrizar tardanza en UI evita futuros cambios de alcance (`R1` baja `25 % → 20 %`). | **`+$510.000`** (`+6 h` en `M07` a `$85.000/h`) / **Contingencia `R1`: `-$160.000`** | `T07`: `5 d → 6 d` (**`+1 d` en ruta crítica: `40 d → 41 d`**) |
| **`SUG-03`** | *"El precio `v1.0` (`$65,27 M`) absorbe los incrementos técnicos si ajustan margen y reducen anticipo inicial al `25 %`."* | Ajustar margen comercial sobre precio (`1_Parametros!H3`) del `18,0 %` al **`15,0 %`** (`=Costo/(1-0,15)` — manteniendo un margen sano por encima del mínimo `10 %` declarado en `B4`) y modificar cuotas a **`25 %` (`H1`) / `45 %` (`H2`) / `30 %` (`H4`)**. | **Negociada** | **Media** | Absorbe completamente el mayor costo de `SUG-01` + `SUG-02` y reduce el valor final del contrato a **`$63.679.000 COP` IVA incluido**, ampliando holgura bajo el tope `$70M` a **`$6.321.000`**. | **Ahorro neto en precio final con IVA: `-$1.589.598`** (`$65.268.598 → $63.679.000`) | `0 d` *(solo reajuste financiero de hitos de cobro)* |
| **`SUG-04`** | *"Los instructores de jornada nocturna requieren material rápido en video para consulta sin esperar mesa de soporte."* | Producir **`3` videocápsulas breves (`≤ 5 min` c/u)** cubriendo apertura de sesión QR/6d, contingencia manual y exportación CSV dentro de los entregables de `TdR-08` (`T11`). | **Aceptada** | **Media** | Mejora la adopción autónoma en `2` sedes sin ampliar el presupuesto de capacitación ni requerir soporte presencial adicional nocturno. | **`$0`** *(absorbido dentro de `P13` capacitación `$1.280.000`)* | `0 d` *(ejecutado en paralelo en `T11`)* |
| **`SUG-05`** | *"¿Se puede incluir una aplicación móvil nativa Android/iOS con reconocimiento facial obligatorio para registrar asistencia?"* | Mantener solución **100 % web responsiva + lector QR USB** sin desarrollo de app nativa ni captura biométrica facial. | **Rechazada** | **Baja** | **Argumento técnico-legal:** (1) Contradice **`TdR-01`** (operación vía navegador sin instalar apps en teléfonos BYOD); (2) Capturar rostro biométrico constituye **dato sensible** (`Ley 1581 de 2012, Art. 5–6`) e involucra aprendices menores de edad (`Art. 7` + Decreto 1074/2015); (3) Desborda el alcance duplicando inversión en `~+$24.000.000` y `+6` semanas, violando el **tope Variante B (`$70.000.000`)**. | **`$0` ejecutado** *(evita sobrecosto `~+$24.000.000`)* | `0 d` *(evita `+30 d` hábiles)* |

---

## 3. Cuadro de Ajustes Cuantificados de Parámetros (`3` Ajustes Propagados en `P1`, `B2`, `B6` y `v1.1`)

| ID Ajuste | Sugerencia asociada | Parámetro modificado | Valor ANTES (`v1.0`) | Valor DESPUÉS (`v1.1`) | Motivo objetivo | Impacto cuantificado (`Costo`, `Plazo`, `Riesgo`) | Propagación obligatoria en repositorio |
| :- | :---: | :--- | :--- | :--- | :--- | :--- | :--- |
| **`AJ-01`** | `SUG-01` | Frecuencia de respaldo S3 y `RPO` (`ANS-03` / `CAP-06` / `FT-SW-02`) | `1` copia/día (`02:00 a. m.`), `RPO ≤ 24 h`, `M10 = 40 h` | **`2` copias/día (`02:00` y `14:00`), `RPO ≤ 12 h`, `M10 = 44 h`** | Evitar pérdida superior a media jornada académica entre turnos mañana y tarde/noche. | **Costo:** `+$360.000` dir. (`M10`), `-$200.000` en VE de `R5` (`15 % → 10 %`). **Plazo:** `T08` `4 → 5 d` (`+0 d` en ruta crítica). **Riesgo:** Baja exposición `R5` de `$600k` a `$400k`. | `G3-P1/A2`, `A5`, `A6` (`.xlsx` y `.md`); `G3-P2/B2` (`.xlsx`), `B6`, `B7` (`v1.1`) |
| **`AJ-02`** | `SUG-02` | Latencia `p95` (`ANS-02` / `CAP-05` / `FT-SW-01`) y parámetro tolerancia tardanza | `p95 ≤ 2,0 s`; tolerancia fija `15 min`, `M07 = 32 h` | **`p95 ≤ 1,5 s`; tolerancia configurable `5–30 min/ficha`, `M07 = 38 h`** | Garantizar fluidez de registro bajo `30` concurrentes (`OPcache`/`InnoDB`) y flexibilidad por ficha sin tocar código. | **Costo:** `+$510.000` dir. (`M07`), `-$160.000` en VE de `R1` (`25 % → 20 %`). **Plazo:** `T07` `5 → 6 d` (**`+1 d` en ruta crítica: `40 → 41 d`**). **Riesgo:** Baja `R1` de `$800k` a `$640k`. | `G3-P1/A2`, `A5`, `A6` (`.xlsx` y `.md`); `G3-P2/B2` (`.xlsx`), `B6`, `B7` (`v1.1`) |
| **`AJ-03`** | `SUG-03` | Margen comercial s/ precio (`B2!H3`) y esquema de pagos (`B3` §11 / `B6` #5) | Margen `18,0 %` (`$65.268.598` IVA incl.); pagos `30 % / 40 % / 30 %` | **Margen `15,0 %` (`$63.679.000` IVA incl.); pagos `25 % / 45 % / 30 %`** | Compensar el alza técnica (`+$870.000` base), bajar anticipo de arranque e incrementar holgura bajo tope `$70M`. | **Costo:** Precio contrato **`-$1.589.598`** (`$65.268.598 → $63.679.000`, holgura `$6.321.000`; pagos `$15.919.750 / $28.655.550 / $19.103.700`). **Plazo:** `0 d`. **Riesgo:** Mejora viabilidad financiera sin sacrificar contingencia ni QA. | `G3-P2/B2` (`02-presupuesto-proyecto.xlsx`), `B6` (§1 #5), `B7` (`07-propuesta-tecnica-v1.1.md`) |

### Balance Financiero Consolidado `v1.0 → v1.1` (Anexo D, TRM `$4.000`, IVA `19 %`)

| Indicador (`02-presupuesto-proyecto.xlsx`) | `v1.0` (Pre-validación) | `v1.1` (Post-validación `B5`) | Variación |
| :--- | :---: | :---: | :---: |
| Horas totales de talento (`A6`) | `390 h` (`$33.260.000`) | **`400 h` (`$34.130.000`)** | `+10 h` (`+$870.000`) |
| Subtotal Categorías 1–5 Año 1 (sin IVA) | `$41.975.000` | **`$42.845.000`** | `+$870.000` |
| Reserva de Contingencia (`SUMIF` `R1`–`R6`) | `$3.000.000` (`7,1 %`) | **`$2.640.000` (`6,2 %`)** | `-$360.000` |
| Base Gravable con Contingencia | `$44.975.000` | **`$45.485.000`** | `+$510.000` |
| IVA (`19 %`) | `$8.545.250` | **`$8.642.150`** | `+$96.900` |
| Costo Total Año 1 (con IVA) | `$53.520.250` | **`$54.127.150`** | `+$606.900` |
| Margen aplicado sobre el precio | `18,0 %` | **`15,0 %`** | `-3,0 pp` |
| **Precio de Venta Total Contrato (con IVA)** | **`$65.268.598`** | **`$63.679.000`** | **`-$1.589.598`** |
| TCO proyectado a `36` meses (Costo base con IVA) | `$67.883.550` | **`$68.490.450`** | `+$606.900` |
| Duración Ruta Crítica (EDT `T01`–`T12`) | `40` días hábiles | **`41` días hábiles** | `+1` día hábil |

---

## 4. Compromisos y Confirmación Escrita de la Contraparte

1. **Propagación inmediata:** El proponente `@andressalinasvargas` actualiza en esta misma fecha (`2026-11-24`) los libros [`06-estimacion-economica.xlsx`](../G3-P1-asistencia-sena/06-estimacion-economica.xlsx) y [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx), las fichas `G3-P1`, los TdR/ANS en [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md) y emite [`07-propuesta-tecnica-v1.1.md`](07-propuesta-tecnica-v1.1.md).
2. **Confirmación de variante oficial:** Si el instructor asigna una variante distinta de **B** antes del `2026-12-05`, la actualización numérica se aplicará cambiando la celda `B3` en ambos archivos `.xlsx`.

### Constancia de Revisión y Confirmación Escrita (`@Kevin81A`)

> **Estado actual:** `- [ ]` **Pendiente de revisión y confirmación escrita de `@Kevin81A` antes del `2026-12-05 06:00 a. m.`**  
> *Para completar la constancia sin exponer datos personales ni firmas escaneadas en repositorio público, `@Kevin81A` debe revisar las secciones 2 y 3 de esta acta (junto con `07-propuesta-tecnica-v1.1.md`) y dejar su aprobación escrita (mediante comentario en PR/Issue de GitHub o cambiando el estado inferior a `[x]` con la fecha de revisión) antes del cierre de entregas.*

| Participante | Rol | Estado de confirmación escrita | Observación / Fecha |
| :--- | :--- | :---: | :--- |
| `@andressalinasvargas` | Proponente (`asistencia-sena`) | `[x]` Confirmado y propagado a `v1.1` | Emitida el `2026-11-24` |
| **`@Kevin81A`** | Contraparte Cliente (`B5`) | **`[ ]` Pendiente de revisión y visto bueno escrito** | *Confirmar antes del `2026-12-05 06:00 a. m.` (sin datos personales reales)* |

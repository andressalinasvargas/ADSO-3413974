# B7 · Propuesta Técnica y Económica Ajustada — Versión `1.1` (`asistencia-sena`)

**Código de documento:** `PROP-ASIS-SENA-2026-v1.1`  
**Versión y fecha:** **Versión `1.1` · `2026-11-24`** *(Reemplaza operativamente a [`03-propuesta-tecnica-v1.0.md`](03-propuesta-tecnica-v1.0.md) incorporando los acuerdos del Acta [`05-acta-validacion.md`](05-acta-validacion.md))*  
**Proponente / Autor:** `@andressalinasvargas` · **Contraparte de validación (`B5`):** `@Kevin81A` · **Ficha:** `3413974`  
**Vigencia de la oferta ajustada:** `30` días calendario (`hasta 2026-12-24`)  
**Escenario parametrizado:** **Variante B (Provisional)** — `120` usuarios totales, `30` concurrentes pico, `2` sedes físicas, disponibilidad `≥ 99,5 %`, tope presupuestal Año 1 con IVA `$70.000.000 COP`.

---

## 0. Control de Cambios (`v1.0 → v1.1` · Fecha `2026-11-24`)

| Cambio / ID | Origen (`B5`) | Descripción del cambio respecto a `v1.0` | Impacto en alcance, costo y plazo | Artefactos actualizados en conjunto |
| :- | :-: | :--- | :--- | :--- |
| **`AJ-01`** | `SUG-01` *(Aceptada)* | Mejora de **`RPO` (`ANS-03`) de `≤ 24 h` a `≤ 12 h`** mediante doble volcado diario `mysqldump` cifrado `AES-256` (`02:00 a. m.` y `14:00`) en S3 `[N6]` (`60` snapshots en `30` días). | `M10`: `40 → 44 h` (`+$360.000`); prob. `R5`: `15 % → 10 %` (`-$200.000` VE); `T08`: `4 → 5 d` (`+0 d` en ruta crítica). | `G3-P1/A2`, `A5`, `A6`; `G3-P2/B2`, `B5`, `B6`, `B7` |
| **`AJ-02`** | `SUG-02` *(Negociada)* | Mejora de **`p95` (`ANS-02`) de `≤ 2,0 s` a `≤ 1,5 s`** (`OPcache` + tuning `InnoDB`) y **tolerancia de tardanza configurable por ficha (`5–30 min`, defecto `15 min`)**. | `M07`: `32 → 38 h` (`+$510.000`); prob. `R1`: `25 % → 20 %` (`-$160.000` VE); `T07`: `5 → 6 d` (**`+1 d` en ruta crítica: `40 → 41 d`**). | `G3-P1/A2`, `A5`, `A6`; `G3-P2/B2`, `B5`, `B6`, `B7` |
| **`AJ-03`** | `SUG-03` *(Negociada)* | Reducción de margen comercial sobre precio (`B2!H3`) del **`18,0 %` al `15,0 %`** y reestructuración de pagos de `30/40/30 %` a **`25 % / 45 % / 30 %`** (`H1/H2/H4`). | Precio venta total IVA incl. baja **`-$1.589.598`** (`$65.268.598 → $63.679.000`); holgura frente al tope sube a **`$6.321.000`**. | `G3-P2/B2`, `B5`, `B6`, `B7` |
| **`CC-04`** | `SUG-04` *(Aceptada)* | Inclusión de **`3` videocápsulas breves (`≤ 5 min` c/u)** para instructores nocturnos dentro de la capacitación `TdR-08` (`T11`). | `$0` adicional (absorbido en `P13`); `0 d` de plazo. | `G3-P1/A2`, `A6`; `G3-P2/B5`, `B6`, `B7` |
| **`CC-05`** | `SUG-05` *(Rechazada)* | Rechazo formal de app nativa Android/iOS con biometría facial por violar `TdR-01` (web sin apps), implicar datos sensibles/menores (**Ley 1581 Arts. 5–7**) y exceder tope `$70M` (`~+$24M`). | Scope protegido; `$0` agregado, `0 d` agregados. | `G3-P2/B5`, `B7` |

---

## 1. Resumen Ejecutivo (`v1.1` Post-Validación)

Esta propuesta ajustada (`v1.1`) consolida los términos técnicos, operativos y financieros acordados en el Acta de Validación [`05-acta-validacion.md`](05-acta-validacion.md) para diseñar, endurecer, desplegar, dotar con lectores ópticos QR 2D y operar durante `12` meses (proyección TCO `36` meses) el **Sistema Web de Control de Asistencia Institucional (`asistencia-sena`)** bajo la **Variante B provisional** (`120` usuarios, `30` concurrentes, `2` sedes, disponibilidad `≥ 99,5 %`).

Frente a la línea base [`v1.0`](03-propuesta-tecnica-v1.0.md), la versión `1.1` **mejora los niveles de servicio clave** —latencia `p95 ≤ 1,5 s` y doble respaldo diario en nube externa con `RPO ≤ 12 h`—, agrega tolerancia de tardanza configurable por ficha (`5–30 min`) y `3` videocápsulas para jornada nocturna, **reduciendo al mismo tiempo el precio final del contrato en `$1.589.598 COP`**:

- **Plazo total de ejecución (`v1.1`):** **`41` días hábiles (`8,2` semanas calendario)**, con `12` actividades (`T01`–`T12`) y `4` hitos verificables (`H1`–`H4`).
- **Subtotal técnico (`Categorías 1–5`, sin IVA):** `$42.845.000 COP` (`400` horas de esfuerzo).
- **Reserva de Contingencia (`R1`–`R6` mitigados):** `$2.640.000 COP` (`6,2 %` del subtotal).
- **Costo Total Año 1 (con Contingencia e IVA `19 %`):** **`$54.127.150 COP`**.
- **Precio de Venta Total del Contrato (Margen `15 %` s/ precio + IVA `19 %`):** **`$63.679.000 COP`**, con una **holgura de `$6.321.000 COP`** por debajo del tope Variante B (`$70.000.000 COP`).
- **TCO proyectado a `36` meses (Costo base con IVA):** **`$68.490.450 COP`**.

---

## 2. Entendimiento de la Necesidad y Diagnóstico del Problema

Trazado a [`G1-P1`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/README.md) y [`G1-P2`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/README.md), se mantienen los cinco frentes de problema —pérdida de `8–15` min por llamado de lista, suplantación en papel, reproceso de tardanzas/CSV, riesgo Ley 1581 y dependencia celular— añadiendo la necesidad expresada en validación (`SUG-01`/`SUG-02`) de **proteger las jornadas de mañana y tarde/noche con respaldo sub-diario (`≤ 12 h`) y adaptar la tolerancia de llegada por ficha**.

---

## 3. Alcance del Proyecto (`Inclusiones`, `Exclusiones` y `Supuestos` `v1.1`)

### 3.1. Inclusiones (`Dentro del alcance`)
1. **Software propio `asistencia-sena` (`FT-SW-01 v1.1`):** `12 RF` y `6 RNF` en PHP 8.3 POO + MariaDB 10.11 (`10` tablas 3FN), incluyendo `OPcache` y tuning `InnoDB` para `p95 ≤ 1,5 s`, tolerancia de tardanza configurable por ficha (`5–30 min`), auto-alojamiento de `qrcode.min.js`, protección `.htaccess` (`HTTP 403`) y exportación CSV UTF-8.
2. **Infraestructura Nube Año 1 (`FT-SW-02 v1.1` + `FT-INF-01`):** DigitalOcean (`4 vCPU`, `8 GiB RAM`, `160 GB NVMe`) para `[N3]`/`[N4]`/`[N5]`, bucket Spaces S3 `250 GB` (`[N6]`) con **doble copia diaria cifrada `02:00`/`14:00` (`60` snapshots rotativos, `RPO ≤ 12 h`)**, dominio `.com/.co` y monitor externo `24/7` (`[N7]`).
3. **Hardware periférico (`FT-HW-02`):** `2` lectores QR 2D USB con base **Zebra DS2208-SR** y `2` kits de cables blindados y regleta supresora (`2` sedes).
4. **QA E2E + Capacitación ampliada (`SUG-04`):** Suite automatizada Playwright `100 %`, pruebas de carga `30` concurrentes (`p95 ≤ 1,5 s`), `16 h` de capacitación (`2` sedes), manuales técnicos/usuario y **`3` videocápsulas breves (`≤ 5 min` c/u)** para instructores nocturnos, más `12` meses de soporte ANS y `6` meses de garantía por defectos de código.

### 3.2. Exclusiones (`Fuera del alcance` — incluye rechazo `SUG-05`)
- Estaciones de escritorio de instructores (`[N1]`) y teléfonos móviles BYOD de aprendices (`[N2]`).
- Desarrollo de aplicación móvil nativa Android/iOS con captura biométrica facial (`SUG-05`, rechazada en `B5`).
- Red Wi-Fi de aulas, cableado eléctrico general de sedes e integraciones API con sistemas externos distintos de CSV UTF-8.

### 3.3. Supuestos
- Escenario **Variante B provisional** (`$70.000.000` tope, `2` sedes), ajustable inmediatamente desde `B3` en ambos libros `.xlsx` si el instructor asigna A, C o D; TRM `$4.000 COP/USD`; IVA `19 %` al final según Anexo D; confirmación escrita final de `@Kevin81A` en `B5` previa al `2026-12-05`.

---

## 4. Solución Propuesta y Arquitectura de Despliegue (`[N1]`–`[N7]`)

Se mantiene intacta la arquitectura aislada de `7` nodos ilustrada en [`03-diagrama-arquitectura-despliegue-g3.svg`](03-diagrama-arquitectura-despliegue-g3.svg) ([`.drawio`](03-diagrama-arquitectura-despliegue-g3.drawio)) con trazabilidad `1:1` contra [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx):

- `[N1]` Cliente Escritorio + Periférico QR (`P07 = $0` PC excluido; `P05`/`P06` lectores/kits incluidos; `P13` capacitación + videocápsulas).
- `[N2]` Cliente Móvil BYOD (`P08 = $0` teléfono excluido).
- `[N3]` Borde DNS + Nginx/Caddy `TLS 1.3` (`P11` dominio + `P01`/`P03`).
- `[N4]` Servidor Aplicación `Docker` (`PHP 8.3` POO con **OPcache**, **Estrategia**, **Fachada**, `qrcode.min.js`) en VPS (`P09`).
- `[N5]` Servidor Datos `MariaDB 10.11` (`TCP 3306` privado, buffer pool `InnoDB` ajustado) en VPS (`P09`).
- **`[N6]` Respaldos Externos S3 (`Spaces 250 GB`, `P10`):** actualizado en `v1.1` a **doble cron diario `02:00`/`14:00` cifrado `AES-256` (`60` copias en `30` días, `RPO ≤ 12 h`)**.
- `[N7]` Monitoreo Externo `24/7` (`P12` + soporte `P14`) verificando `ANS-01 ≥ 99,5 %` y `ANS-02 p95 ≤ 1,5 s`.

---

## 5. Especificaciones Técnicas, Proveedores y Marco Normativo (`v1.1`)

- **Fichas técnicas actualizadas (`G3-P1/A2`):** [`02-fichas-tecnicas.md`](../G3-P1-asistencia-sena/02-fichas-tecnicas.md) (`v1.1` con `FT-SW-01 p95 ≤ 1,5 s` + tardanza configurable y `FT-SW-02 RPO ≤ 12 h`).
- **Parámetros de capacidad actualizados (`G3-P1/A5`):** [`05-condiciones-tecnicas.md`](../G3-P1-asistencia-sena/05-condiciones-tecnicas.md) (`CAP-01`–`CAP-07` `v1.1`).
- **Proveedores seleccionados (`B1`):** [`01-comparativo-proveedores.md`](01-comparativo-proveedores.md) — **DigitalOcean** (`4,64 / 5,00`, TCO 36m `$8.865.000 sin IVA`) y **Zebra DS2208-SR** (`4,75 / 5,00`, TCO 36m `$920.000 sin IVA` por `2` sedes).
- **Licenciamiento (`A4`) y Normatividad (`A3`):** `$0` en licencias de producción OSS, cesión escrita de derechos patrimoniales (**Ley 23/1982** y **Decisión 351**), **Ley 1581/2012 + Decreto 1074/2015** (fundamento clave del rechazo de biometría facial `SUG-05`) y **WCAG 2.2 AA**.

---

## 6. Metodología, EDT de `12` Tareas y Ruta Crítica Recalculada (`v1.1` · `41` días hábiles)

Tras incorporar `AJ-01` (`T08`: `4 d → 5 d`) y `AJ-02` (`T07`: `5 d → 6 d`), el nuevo cálculo CPM sobre `4` sprints en jornada lunes–viernes queda en **`41` días hábiles (`8,2` semanas)**:

| ID | Fase / Actividad de la EDT (`A6 v1.1`) | Duración (días) | Predecesoras | ES | EF | LS | LF | Holgura (`LS-ES`) | ¿Ruta Crítica? | Responsable |
| :- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **`T01`** | Levantamiento definitivo, variante (`B`), alcance y diseño (`M11`) | `4` | — | `0` | `4` | `0` | `4` | **`0`** | **Sí** | Líder Técnico |
| **`T02`** | Aprovisionamiento VPS DigitalOcean, DNS y proxy TLS `[N3]` (`M10`) | `3` | `T01` | `4` | `7` | `20` | `23` | `16` | No | DevOps / Infra |
| **`T03`** | Despliegue MariaDB 3FN `[N5]` y módulos `M01` + `M02` | `5` | `T01` | `4` | `9` | `4` | `9` | **`0`** | **Sí** | Dev Backend/BD |
| **`T04`** | Módulo `M03` (sesiones QR rotativo, CSPRNG y código `6` dígitos) | `5` | `T03` | `9` | `14` | `9` | `14` | **`0`** | **Sí** | Dev Full-Stack |
| **`T05`** | Módulos `M04` + `M05` (autorregistro móvil Ley 1581 y geocerca Haversine) | `7` | `T04` | `14` | `21` | `14` | `21` | **`0`** | **Sí** | Dev Full-Stack |
| **`T06`** | Módulo `M06` (estrategias escáner QR 2D y contingencia manual) | `6` | `T04` | `14` | `20` | `15` | `21` | `1` | No | Dev Frontend/PHP |
| **`T07`** | **Módulos `M07` + `M08` (`v1.1` `AJ-02`: tardanza configurable `5–30 min`, `OPcache`/`InnoDB p95 ≤ 1,5 s`, CSV, `.htaccess`)** | **`6`** | `T05, T06` | `21` | `27` | `21` | `27` | **`0`** | **Sí** | Dev Backend/Seg |
| **`T08`** | **Doble respaldo S3 `RPO ≤ 12 h` (`02:00`/`14:00`) `[N6]` y monitor `[N7]` (`v1.1` `AJ-01`)** | **`5`** | `T02, T03` | `9` | `14` | `22` | `27` | `13` | No | DevOps / Admin BD |
| **`T09`** | Compra, calibración USB HID y entrega `2` lectores Zebra DS2208 (`FT-HW-02`) | `4` | `T01` | `4` | `8` | `23` | `27` | `19` | No | Soporte Hardware |
| **`T10`** | Suite E2E Playwright (`M09`), carga `30` conc. (`p95 ≤ 1,5 s`) y simulacro S3 | `5` | `T07, T08, T09` | `27` | `32` | `27` | `32` | **`0`** | **Sí** | Especialista QA |
| **`T11`** | Piloto `2` sedes, capacitación `16 h` + **`3` videocápsulas (`SUG-04`)** | `5` | `T10` | `32` | `37` | `32` | `37` | **`0`** | **Sí** | Líder + Soporte |
| **`T12`** | Puesta en producción oficial, entrega de manuales/código y acta de cierre | `4` | `T11` | `37` | `41` | `37` | `41` | **`0`** | **Sí** | Líder Técnico |

- **Ruta Crítica `v1.1` (`Holgura = 0`):** **`T01 -> T03 -> T04 -> T05 -> T07 -> T10 -> T11 -> T12`** (`4 + 5 + 5 + 7 + 6 + 5 + 5 + 4 = 41` días hábiles).
- **Hitos actualizados:** `H1` Día `9` (**Pago 1: `25 %`**) · `H2` Día `27` (**Pago 2: `45 %`**) · `H3` Día `37` (cierre piloto) · `H4` Día `41` (**Pago 3: `30 %`**).

---

## 7. Equipo de Trabajo y Responsabilidades

Estructura de roles sin cambio frente a `v1.0` (Líder Técnico, Desarrollador Full-Stack PHP/BD asignado `+10 h` en `M07`/`M10`, Especialista QA Playwright, DevOps/Soporte y Contraparte Institucional `@Kevin81A` durante validación).

---

## 8. Costos, Presupuesto Detallado y Flujo a `36` Meses (`B2 v1.1`)

Cifras calculadas con fórmulas vivas en [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx) (`Anexo D`, TRM `$4.000`, IVA `19 %`, margen sobre precio **`15,0 %`** por `AJ-03`):

| Categoría / Indicador (`02-presupuesto-proyecto.xlsx` `v1.1`) | Clasificación | Costo `v1.0` | Valor `v1.1` (COP) |
| :--- | :--- | :---: | :---: |
| **1. Talento Humano** (`360 h` dir. `$30.730.000` + `40 h` ind. `$3.400.000` = `400 h`) | Directo/Indirecto · SW · Único | `$33.260.000` | **`$34.130.000`** |
| **2. Licencias y Auditoría Legal** (`OSS $0` + DNDA `$480.000`) | Indirecto · SW | `$480.000` | **`$480.000`** |
| **3. Hardware e Infraestructura** (`2` Zebra DS2208 + `2` kits; `[N1]`/`[N2]` `$0` excl.) | Directo · HW · Único | `$1.000.000` | **`$1.000.000`** |
| **4. Nube y Operación** (DigitalOcean VPS + Spaces `250 GB` + Dominio + Monitor) | Mixto · SW · Recurrente | `$2.955.000` | **`$2.955.000`** |
| **5. Capacitación y Soporte** (`16 h` + `3` videocápsulas + `12` meses soporte) | Mixto · SW | `$4.280.000` | **`$4.280.000`** |
| **Subtotal Categorías 1 a 5 (sin IVA)** (`SW $41.845.000` · `HW $1.000.000`) | Dir. `$35.965.000` · Ind. `$6.880.000` | `$41.975.000` | **`$42.845.000`** |
| **6. Reserva de Contingencia (`SUMIF` `R1`–`R6`, `6,2 %` del subtotal)** | Gestión de riesgos (`AJ-01`/`AJ-02`) | `$3.000.000` | **`$2.640.000`** |
| **Base Gravable con Contingencia** | Subtotal + Contingencia | `$44.975.000` | **`$45.485.000`** |
| **IVA (`19 %`)** | Sobre Base con Contingencia | `$8.545.250` | **`$8.642.150`** |
| **Costo Total Año 1 (con Contingencia e IVA)** | Base de costo de ejecución | `$53.520.250` | **`$54.127.150`** |
| **Precio de Venta sin IVA** (`= Base / (1 - 0,15)`) | Margen **`15 %`** sobre precio | `$54.847.561` | **`$53.511.765`** |
| **Precio de Venta Total del Contrato (con IVA `19 %`)** | **`= Costo_con_IVA / (1 - 0,15)`** | `$65.268.598` | **`$63.679.000`** |
| **Holgura vs. Tope Variante B (`$70.000.000`)** | **Estado: `CUMPLE TOPE`** | `$4.731.402` | **`$6.321.000`** |

- **Flujo `36` Meses (`4_Flujo_36_Meses` `v1.1`):** Año 1 `$45.485.000` (con IVA `$54.127.150`) + Año 2 `$5.955.000` (con IVA `$7.086.450`) + Año 3 `$6.115.000` (con IVA `$7.276.850`) = **TCO 36 Meses Base `$57.555.000` · IVA `$10.935.450` · Con IVA `$68.490.450`**.

---

## 9. Matriz de Riesgos y Contingencia (`2_Riesgos_Contingencia v1.1`)

| ID | Riesgo | Prob. (`v1.1`) | Impacto (COP) | Valor Esperado (`v1.1`) | ¿Reserva? | Plan actualizado |
| :- | :--- | :---: | :---: | :---: | :---: | :--- |
| **`R1`** | Cambios en reglas de tardanza, reportes o geocerca | **`20,0 %`** *(antes `25 %`)* | `$3.200.000` | **`$640.000`** | **Sí** | Mitigado parcialmente por parámetro configurable `5–30 min` (`AJ-02`) |
| **`R2`** | Retraso en subdominio DNS o puertos `HTTPS 443` | `30,0 %` | `$2.000.000` | `$600.000` | **Sí** | Validación temprana semana `2` (`T02`) y proxy temporal |
| **`R3`** | Variación cambiaria TRM (`+15 %`) en servicios nube | `35,0 %` | `$800.000` | `$280.000` | **Sí** | Aceptar con reserva financiera cubierta para Año 1 |
| **`R4`** | Desabastecimiento o falla temprana de lectores QR 2D | `20,0 %` | `$1.100.000` | `$220.000` | **Sí** | Garantía `5` años Zebra + reserva reemplazo urgente |
| **`R5`** | Corrupción lógica o restauración de emergencia MariaDB | **`10,0 %`** *(antes `15 %`)* | `$4.000.000` | **`$400.000`** | **Sí** | Mitigado por **doble respaldo diario S3 `RPO ≤ 12 h`** (`AJ-01`) |
| **`R6`** | Indisponibilidad temporal de técnico de soporte | `20,0 %` | `$2.500.000` | `$500.000` | **Sí** | Documentación completa y respaldo cruzado |
| **`R7`** | Caída masiva de conectividad móvil de aprendices en aula | `40,0 %` | `$1.500.000` | `$600.000` | **No** | Mitigado en alcance (`6d` + escáner sede + contingencia manual) |
| **—** | **Total Matriz (`R1–R7`: VE `$3.240.000`)** | — | — | **`$2.640.000`** *(cubierto `R1–R6`)* | `6,2 %` | Cumple banda `5 %–15 %` del Anexo D |

---

## 10. Garantías, Soporte y Acuerdos de Nivel de Servicio (`ANS v1.1`)

Conforme a [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md) (`v1.1`):
- Garantía de software `6` meses sin costo; garantía lectores Zebra `5` años; soporte `12` meses incluido.
- **`ANS-01` Disponibilidad mensual:** **`≥ 99,5 %`** (máx. `3,6 h/mes`, medido cada `60 s` por `[N7]`).
- **`ANS-02` Latencia `p95` (`AJ-02`):** **`≤ 1,5 segundos`** bajo `30` concurrentes (antes `≤ 2,0 s`).
- **`ANS-03` `RPO` (`AJ-01`):** **`≤ 12 horas`** con copias `02:00` y `14:00` cifradas `AES-256` en `[N6]` (antes `≤ 24 h`).
- **`ANS-04` `P1` y `RTO`:** Respuesta inicial `≤ 30 min`, `RTO ≤ 2 horas`.

---

## 11. Condiciones Comerciales, Pagos (`25/45/30 %`), Propiedad Intelectual y Datos

### 11.1. Forma de Pago Ajustada (`AJ-03` — Valor Total Contrato: `$63.679.000 COP` IVA incluido)

| Cuota | % (`v1.1`) | Monto (COP con IVA) | Hito / Condición de facturación |
| :- | :---: | :---: | :--- |
| **Pago `1`** | **`25 %`** | **`$15.919.750`** | Firma de contrato y aprobación Hito `H1` (Día `9`: BD 3FN `[N5]` y entorno `TLS` `[N3]`). |
| **Pago `2`** | **`45 %`** | **`$28.655.550`** | Hito `H2` (Día `27`: software completo + tuning `p95` + doble respaldo S3 + `2` lectores Zebra entregados). |
| **Pago `3`** | **`30 %`** | **`$19.103.700`** | Hito `H4` (Día `41`: E2E `100 %`, capacitación `16 h` + `3` videocápsulas, manuales, código y salida a producción). |
| **TOTAL** | **`100 %`** | **`$63.679.000`** | *(`$15.919.750 + $28.655.550 + $19.103.700 = $63.679.000` exactos).* |

### 11.2. Propiedad Intelectual y Datos Personales
Sin modificaciones de fondo respecto a `v1.0`: cesión por escrito de derechos patrimoniales al contratante (**Ley 23/1982** y **Decisión 351** con reserva moral de `@andressalinasvargas`), y contrato de **transmisión de datos personales** como Encargado (**Ley 1581/2012** y **Decreto 1074/2015 art. `2.2.2.25.5.2`**).

---

## 12. Vigencia y Anexos Integrados de la Versión `1.1`

Oferta vigente por **`30` días calendario** desde el `2026-11-24`, respaldada por:
- Línea base histórica: [`03-propuesta-tecnica-v1.0.md`](03-propuesta-tecnica-v1.0.md) · Acta de validación: [`05-acta-validacion.md`](05-acta-validacion.md)
- Producto 1 (`G3-P1`): [`01-formato-ficha-tecnica.md`](../G3-P1-asistencia-sena/01-formato-ficha-tecnica.md) · [`02-fichas-tecnicas.md`](../G3-P1-asistencia-sena/02-fichas-tecnicas.md) · [`03-referente-tecnico-normativo.md`](../G3-P1-asistencia-sena/03-referente-tecnico-normativo.md) · [`04-dimensionamiento-licencias.md`](../G3-P1-asistencia-sena/04-dimensionamiento-licencias.md) · [`05-condiciones-tecnicas.md`](../G3-P1-asistencia-sena/05-condiciones-tecnicas.md) · [`06-estimacion-economica.xlsx`](../G3-P1-asistencia-sena/06-estimacion-economica.xlsx)
- Producto 2 (`G3-P2`): [`01-comparativo-proveedores.md`](01-comparativo-proveedores.md) · [`02-presupuesto-proyecto.xlsx`](02-presupuesto-proyecto.xlsx) · [`03-diagrama-arquitectura-despliegue-g3.svg`](03-diagrama-arquitectura-despliegue-g3.svg) · [`04-presentacion-negociacion.md`](04-presentacion-negociacion.md) · [`06-contrato-tdr-ans.md`](06-contrato-tdr-ans.md)

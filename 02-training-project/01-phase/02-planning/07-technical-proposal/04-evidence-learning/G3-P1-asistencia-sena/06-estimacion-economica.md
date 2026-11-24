# A6 · Estimación Preliminar de Condiciones Económicas

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P1 · Especificaciones técnicas (`RAP 593060`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-24`  
**Libro de cálculo con fórmulas vivas:** [06-estimacion-economica.xlsx](06-estimacion-economica.xlsx)  
**Escenario provisional activo:** **Variante B** (`120` usuarios totales, `30` concurrentes, `2` sedes, disponibilidad `99,5 %`, tope año 1 **`$70.000.000` COP**).

> **Cómo recalcular otra variante en el libro `.xlsx`:** Todas las cifras dependen mediante fórmulas `INDEX/MATCH`, `SUM` y `SUMIF` de la celda `1_Parametros_Variante!B3` (`"B"`). Al cambiarla a `"A"`, `"C"` o `"D"`, el libro actualiza sedes, lectores, nodos, subtotales a 12/36 meses, IVA (`19 %`) y la verificación contra el tope.

---

## 1. Método de Estimación de Talento Humano (`Horas por Módulo`)

Se aplicó el método de **estimación ascendente por horas por módulo funcional**, desglosado en **`11` ítems** (`10` módulos directos trazados a `RF-01`–`RF-12`, `A4` y pruebas E2E, más `1` ítem indirecto de gestión técnica y contractual) en la hoja `2_Esfuerzo_Modulos` de [06-estimacion-economica.xlsx](06-estimacion-economica.xlsx):

| ID | Módulo / Ítem de esfuerzo | Trazabilidad | Naturaleza | Horas | Tarifa (COP/h) | Subtotal (COP sin IVA) |
| :- | :--- | :--- | :---: | :---: | :---: | :---: |
| **M01** | Autenticación administrativa, sesiones `HttpOnly` y RBAC | `RF-01`, `RNF-01` | Directo | `28` | `$85.000` | `$2.380.000` |
| **M02** | Gestión de programas, sedes, fichas, aprendices y teléfonos 1FN | `RF-02`, `RNF-02` | Directo | `44` | `$85.000` | `$3.740.000` |
| **M03** | Apertura/cierre de sesiones, tokens CSPRNG y códigos 6 dígitos | `RF-03`, `RF-04`, `RF-11` | Directo | `32` | `$85.000` | `$2.720.000` |
| **M04** | Autorregistro móvil responsivo y consentimiento Ley 1581 | `RF-05`, `RNF-02`, `RNF-04` | Directo | `40` | `$85.000` | `$3.400.000` |
| **M05** | Validación de geocerca Haversine y auditoría de red/IP | `RF-06`, `RNF-06` | Directo | `32` | `$90.000` | `$2.880.000` |
| **M06** | Estrategias escáner QR (`BarcodeDetector`) y contingencia manual | `RF-07`, `RF-08`, `RF-09` | Directo | `44` | `$85.000` | `$3.740.000` |
| **M07** | Calculador de tardanza, servicio de reportes y exportación CSV | `RF-10`, `RF-12` | Directo | `32` | `$85.000` | `$2.720.000` |
| **M08** | Auto-alojamiento `qrcode.min.js` local, blindaje `.htaccess` y PDO | `A4`, `RNF-01`, `RNF-03` | Directo | `22` | `$90.000` | `$1.980.000` |
| **M09** | Suite de pruebas automatizadas E2E Playwright y QA funcional | `RNF-03`, `RNF-04`, `RNF-05` | Directo | `36` | `$75.000` | `$2.700.000` |
| **M10** | Despliegue Docker (`N4`/`N5`), proxy TLS (`N3`), S3 (`N6`) y manuales | `RNF-01`, `RNF-05`, `RNF-06` | Directo | `40` | `$90.000` | `$3.600.000` |
| **M11** | Gestión técnica, control de riesgos y coordinación contractual | Transversal | Indirecto | `40` | `$85.000` | `$3.400.000` |
| **TOTAL** | **Total Talento Humano (`350 h` Directo + `40 h` Indirecto)** | `RF-01`–`RF-12` | Mixto | **`390`** | — | **`$33.260.000`** |

---

## 2. Consolidado Económico Preliminar a `12` y `36` Meses (`Variante B`, TRM `$4.000`)

Cifras calculadas por fórmulas en la hoja `3_Costos_12_36M` de [06-estimacion-economica.xlsx](06-estimacion-economica.xlsx):

| Categoría | Clasificación (`D/I` · `U/R`) | Año 1 (`12 m`, sin IVA) | Año 2 (`12 m`, sin IVA) | Año 3 (`12 m`, sin IVA) | Total `36` meses (sin IVA) |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **1. Talento Humano** (`M01`–`M11`) | Directo `$29.860.000` · Indirecto `$3.400.000` · Único | `$33.260.000` | `$0` | `$0` | `$33.260.000` |
| **2. Licencias y Auditoría Legal** | OSS `$0` + Auditoría/DNDA Indirecto Único `$480.000` | `$480.000` | `$0` | `$0` | `$480.000` |
| **3. Hardware e Infraestructura** (`2` sedes) | `2` lectores QR (`$760.000`) + kits (`$240.000`) · Directo Único *(mantenimiento año 3: `$160.000`)* | `$1.000.000` | `$0` | `$160.000` | `$1.160.000` |
| **4. Nube y Operación** (`N3`, `N4/N5`, `N6`, `N7`) | VPS (`$2.304.000/año`), S3 (`$240.000/año`), Dominio (`$75.000/año`), Monitor (`$336.000/año`) · Recurrente | `$2.955.000` | `$2.955.000` | `$2.955.000` | `$8.865.000` |
| **5. Capacitación y Soporte** (`TdR-08` + `ANS`) | Capacitación `2` sedes Único (`$1.280.000`) + Soporte mensual Recurrente (`$3.000.000/año`) | `$4.280.000` | `$3.000.000` | `$3.000.000` | `$10.280.000` |
| **Subtotal Preliminar (sin IVA)** | Directos Año 1: **`$35.095.000`** · Indirectos Año 1: **`$6.880.000`** | **`$41.975.000`** | **`$5.955.000`** | **`$6.115.000`** | **`$54.045.000`** |
| **IVA (`19 %`)** | Aplicado al total por periodo (`Anexo D`) | `$7.975.250` | `$1.131.450` | `$1.161.850` | `$10.268.550` |
| **Total Preliminar con IVA** *(antes de reserva de riesgos `B2`)* | Costo Único Año 1 sin IVA: `$36.020.000` · Recurrente Año 1 sin IVA: `$5.955.000` | **`$49.950.250`** | **`$7.086.450`** | **`$7.276.850`** | **`$64.313.550`** |

---

## 3. Rango de Error, Verificación contra Tope, Supuestos y Exclusiones (`4_Resumen_A6`)

- **Rango de error preliminar (`±15 %` sobre estimación Año 1 con IVA de `$49.950.250`):**
  - Límite inferior (`-15 %`): **`$42.457.713`** COP.
  - Límite superior (`+15 %`): **`$57.442.788`** COP.
- **Verificación contra el tope de la Variante B (`$70.000.000` COP primer año):**
  - Estimación preliminar Año 1 con IVA (`$49.950.250`) **CUMPLE TOPE** con un margen de `$20.049.750` antes de incorporar la reserva de contingencia de riesgos y el margen comercial de la propuesta formal (ver [`G3-P2/02-presupuesto-proyecto.xlsx`](../G3-P2-asistencia-sena/02-presupuesto-proyecto.xlsx), donde incluso el **Precio de Venta Total con Contingencia, IVA 19 % y Margen 18 % = `$65.268.598`** sigue por debajo de `$70.000.000`).
- **Supuestos y exclusiones principales:**
  1. Se adopta **Variante B** provisional (`$70.000.000`, `2` sedes); si se asignara **Variante A** (`$45.000.000`), un desarrollo completo a la medida superaría el tope y requeriría acotar el alcance a un despliegue mínimo reutilizando el código base sin desarrollos adicionales.
  2. Precios en dólares convertidos a **TRM `$4.000` COP/USD** sin IVA.
  3. **Exclusiones:** equipos de escritorio de instructores (`[N1]`), teléfonos móviles propios de aprendices (`[N2]`), red Wi-Fi institucional y cableado eléctrico general de sedes.

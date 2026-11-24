# B1 · Análisis Comparativo de Proveedores y TCO a 36 Meses (`G3-P2`)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Autor:** `@andressalinasvargas` · Ficha `3413974`  
**Fecha de elaboración y consulta de referencias:** `2026-11-24`  
**Escenario de cálculo:** **Variante B (Provisional)** — `120` usuarios activos, `30` concurrentes, `2` sedes físicas, disponibilidad mínima `99,5 %`, tope presupuestal con IVA `$70.000.000 COP` (hasta confirmación oficial de variante por el instructor).  
**Base cambiaria y tributaria (Anexo D):** `TRM = $4.000 COP/USD`, importes unitarios comparados en `COP sin IVA` (con su equivalente `con IVA 19 %` al cierre de cada tabla TCO), horizonte de evaluación `36 meses` (`3 años`).

---

## 1. Marco de normalización y trazabilidad con fichas técnicas (`G3-P1/A2`)

Para garantizar una comparación objetiva entre cotizaciones de distintos proveedores y cumplir con `Rubricas_G3.md` (`C1`), todas las alternativas se normalizaron bajo las siguientes reglas antes de calificar:

1. **Categoría 1 · Infraestructura Cloud, Almacenamiento S3 de Respaldos y Monitoreo (`FT-SW-02`):**
   - Línea base técnica exigida por [02-fichas-tecnicas.md](../G3-P1-asistencia-sena/02-fichas-tecnicas.md) y [05-condiciones-tecnicas.md](../G3-P1-asistencia-sena/05-condiciones-tecnicas.md): servidor Linux x86_64 con `≥ 4 vCPU`, `≥ 8 GB RAM`, `≥ 160 GB NVMe/SSD` (`N4`/`N5` Docker + MariaDB), almacenamiento compatible S3 `250 GB` (`N6` respaldos cifrados `RPO ≤ 24 h`), agente de monitoreo HTTP `24/7` (`N7` verificación `ANS-01`/`ANS-02`) y renovación anual de dominio institucional `.com`/`.co` (`$75.000 COP/año`, igual para las 3 opciones).
   - Condición equivalente: moneda `USD` convertida a `COP` con `TRM $4.000`, horizonte `36 meses`, tráfico saliente mínimo incluido de `1 TB/mes` (para evitar sobrecargos ocultos por descarga de respaldos).
2. **Categoría 2 · Lector Óptico de Códigos QR 2D USB con Base Manos Libres (`FT-HW-02`):**
   - Línea base técnica exigida por `FT-HW-02`: lector CMOS 2D capaz de decodificar QR sobre **pantalla de teléfono móvil con brillo bajo/antirreflejo**, interfaz USB HID Plug & Play (sin drivers propietarios en Linux/Windows/ChromeOS), sellado mínimo `IP40–IP52`, resistencia a caídas de `1,5 m`, base manos libres incluida y garantía mínima de `3–5 años`.
   - Condición equivalente: compra de **`2` unidades** en Año 1 (`1` por cada sede de Variante B), más previsión de **mantenimiento/reposición de cable o base al Año 3**, en precios de referencia del mercado colombiano convertidos/normalizados sin IVA (`19 %` aplicado al final del TCO).
   - *Nota de trazabilidad con `B2`:* En la hoja `3_Presupuesto_Detallado` de [02-presupuesto-proyecto.xlsx](02-presupuesto-proyecto.xlsx), el rubro de Hardware Año 1 suma `$1.000.000 sin IVA` (`$760.000` de los `2` lectores Zebra DS2208 + `$240.000` de `2` kits transversales de cableado USB protegido/regleta eléctrica con supresor de picos, comunes a cualquier marca), mientras que la hoja `5_Comparativo_TCO` compara exclusivamente el TCO de las marcas de lectores (`adquisición 2 uds + mantenimiento Año 3`).

---

## 2. Categoría 1 · Infraestructura Nube, Respaldos S3 y Monitoreo (`FT-SW-02`)

### 2.1. Alternativas reales consultadas y normalización a `36 meses`

| Proveedor | Paquete / Referencia comercial equivalente (`4 vCPU / 8 GB / 160 GB`) | Costo mensual USD | Costo mensual COP (TRM $4.000) | Dominio anual COP | TCO 36 meses COP sin IVA | TCO 36 meses COP con IVA (19 %) | Fuente pública oficial (consultada `2026-11-24`) |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **DigitalOcean** *(Recomendado)* | Droplet Regular/AMD `4 vCPU / 8 GB / 160 GB NVMe` (`USD 48`) + Spaces S3 `250 GB / 1 TiB egress` (`USD 5`) + Snapshots/Monitor `24/7` (`USD 7`) — Región `NYC1/NYC3` (US-East) | `USD 60` | `$240.000` | `$75.000` | **`$8.865.000`** | **`$10.549.350`** | [DigitalOcean Pricing](https://www.digitalocean.com/pricing/droplets) · [Spaces Pricing](https://www.digitalocean.com/pricing/spaces-object-storage) |
| **AWS Lightsail** *(Mejor descartado)* | Lightsail Linux Bundle `4 vCPU / 8 GB / 160 GB SSD` (`USD 44` tarifa vigente) + Object Storage `250 GB` (`USD 6`) + CloudWatch/Snapshots (`USD 7`) — Región `us-east-1` | `USD 57` | `$228.000` | `$75.000` | **`$8.433.000`** | **`$10.035.270`** | [AWS Lightsail Pricing](https://aws.amazon.com/lightsail/pricing/) |
| **Hetzner Cloud** | Servidor `CPX31/CX32` `4 vCPU / 8 GB / 160 GB NVMe` (`USD 18` eq. EUR) + Storage/Object (`USD 6`) + Backups/Monitor (`USD 7`) — Región EU / US limitado | `USD 31` | `$124.000` | `$75.000` | **`$4.689.000`** | **`$5.579.910`** | [Hetzner Cloud Pricing](https://www.hetzner.com/cloud) |

*Fórmula de normalización TCO 36 meses (idéntica a `02-presupuesto-proyecto.xlsx!5_Comparativo_TCO`):*  
`TCO_36M_sin_IVA = (Costo_mensual_COP × 36) + (Dominio_anual × 3)`  
- **DigitalOcean:** `($240.000 × 36) + ($75.000 × 3) = $8.640.000 + $225.000 = $8.865.000` (`× 1,19 = $10.549.350`).  
- **AWS Lightsail:** `($228.000 × 36) + ($75.000 × 3) = $8.208.000 + $225.000 = $8.433.000` (`× 1,19 = $10.035.270`).  
- **Hetzner Cloud:** `($124.000 × 36) + ($75.000 × 3) = $4.464.000 + $225.000 = $4.689.000` (`× 1,19 = $5.579.910`).

### 2.2. Matriz de criterios ponderados (`suma = 100 %`, escala `1,0` a `5,0`)

| Criterio de evaluación | Peso | DigitalOcean | Puntaje DO | AWS Lightsail | Puntaje AWS | Hetzner Cloud | Puntaje Hetzner | Justificación técnica de la calificación |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **1. Latencia desde Colombia y cumplimiento ANS `99,5 %`** | `30 %` | `4,7` | `1,41` | `4,8` | `1,44` | `2,8` | `0,84` | `NYC1/NYC3` (DO) y `us-east-1` (AWS) ofrecen `55–70 ms` desde Colombia y SLA `99,99 %`; Hetzner tiene su infraestructura principal de almacenamiento Storage Box en Europa (`145–175 ms`) y menor madurez de Object Storage en US-East. |
| **2. Previsibilidad de facturación y TCO 36 meses** | `25 %` | `4,4` | `1,10` | `3,8` | `0,95` | `4,8` | `1,20` | Hetzner es el más barato; DigitalOcean cobra tarifa plana (`USD 60/mes`) con `1 TiB` S3 incluido sin sorpresas por peticiones GET/PUT; AWS Lightsail tiene cuota fija inicial menor, pero excedentes de egreso S3 y CloudWatch generan facturación variable. |
| **3. Integración VPS + S3 + Snapshots + Alertas en un solo panel** | `20 %` | `4,8` | `0,96` | `4,1` | `0,82` | `3,5` | `0,70` | DigitalOcean unifica Droplets, Spaces S3, Firewall Cloud y alertas en una consola única; Lightsail obliga a saltar a la consola IAM/CloudWatch estándar de AWS para políticas finas; Hetzner separa Cloud Console y Storage Robot. |
| **4. Facilidad operativa para equipo de soporte junior/SENA** | `15 %` | `4,8` | `0,72` | `4,0` | `0,60` | `3,8` | `0,57` | Documentación paso a paso, `doctl` sencillo y consola limpia en DigitalOcean reducen el riesgo operativo frente a la curva IAM de AWS o la interfaz técnica austera de Hetzner. |
| **5. Fricción de contratación y validación de cuenta desde Colombia** | `10 %` | `4,5` | `0,45` | `4,2` | `0,42` | `2,6` | `0,26` | DigitalOcean y AWS aceptan tarjetas corporativas/crédito locales sin bloqueos frecuentes; Hetzner aplica verificación KYC europea estricta con alto porcentaje de rechazos iniciales en cuentas nuevas de Latinoamérica. |
| **TOTAL PONDERADO** | **`100 %`** | — | **`4,64`** | — | **`4,23`** | — | **`3,57`** | **Ganador: DigitalOcean (`4,64 / 5,00`)**. |

### 2.3. Recomendación razonada y motivos de descarte (Categoría 1)

- **Opción recomendada — DigitalOcean (`4,64 / 5,00` | TCO 36m `$8.865.000 sin IVA`):** Aun cuando no es el proveedor de menor tarifa nominal mensual (`USD 60` frente a `USD 57` de AWS Lightsail y `USD 31` de Hetzner), **cumple de forma equilibrada los requisitos críticos de `ANS-01` (`99,5 %`) y `ANS-02` (`p95 ≤ 2,0 s`)** desde Colombia con latencia US-East (`~60 ms`), unifica servidor Docker (`N4`/`N5`), almacenamiento S3 cifrado (`N6`) y monitoreo (`N7`) en un solo contrato sin sobresaltos por tráfico S3, y se mantiene con amplia holgura dentro del presupuesto total de Variante B (`$65.268.598` vs tope `$70.000.000`).
- **Por qué se descarta AWS Lightsail (`4,23 / 5,00` | TCO 36m `$8.433.000 sin IVA`):** El ahorro marginal a 36 meses es de apenas `$432.000 sin IVA` (`$12.000/mes`, menos del `0,8 %` del presupuesto del proyecto), a cambio de fragmentar la administración entre la consola simplificada de Lightsail y la consola IAM/CloudWatch/Billing de AWS y asumir cargos variables si el volumen de snapshots o logs excede los límites del paquete.
- **Por qué se descarta Hetzner Cloud (`3,57 / 5,00` | TCO 36m `$4.689.000 sin IVA`):** Aunque ofrece el menor costo bruto, su red centralizada en Europa eleva la latencia base por encima de `145 ms` (reduciendo el margen de `ANS-02` bajo carga concurrente en horas pico de ingreso SENA), exige separar servicios entre consolas distintas y presenta fricción KYC documentada para alta y renovación de cuentas desde Colombia, elevando el riesgo de suspensión administrativa (`R5`).

---

## 3. Categoría 2 · Lector Óptico de Códigos QR 2D USB con Soporte (`FT-HW-02`)

### 3.1. Alternativas reales consultadas y normalización a `36 meses` (`2` sedes)

| Proveedor / Modelo | Especificación técnica clave (resolución / IP / caídas / base) | Precio unitario COP sin IVA | Cantidad (2 sedes) | Adquisición Año 1 sin IVA | Mantenimiento / Cable Año 3 (2 sedes) sin IVA | TCO 36 meses COP sin IVA | TCO 36 meses COP con IVA (19 %) | Fuente pública referenciada (consultada `2026-11-24`) |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **Zebra DS2208-SR (Kit USB + Base)** *(Recomendado)* | CMOS `640×480` omnidireccional PRZM, lectura pantalla móvil, `IP52`, caídas `1,5 m`, USB HID + base | `$380.000` | `2` | `$760.000` | `$160.000` (`$80.000 × 2`) | **`$920.000`** | **`$1.094.800`** | [Zebra DS2200 Series Specs](https://www.zebra.com/us/en/products/spec-sheets/scanners/general-purpose-scanners/ds2200-series.html) |
| **Honeywell Voyager XP 1470g (USB + Base)** *(Mejor descartado)* | CMOS `1040×720`, lectura pantallas bajas, `IP40`, caídas `1,8 m`, USB HID + base | `$430.000` | `2` | `$860.000` | `$160.000` (`$80.000 × 2`) | **`$1.020.000`** | **`$1.213.800`** | [Honeywell Voyager XP 1470g](https://automation.honeywell.com/us/en/products/productivity-products/barcode-scanners/general-duty/voyager-1470g) |
| **Datalogic QuickScan QD2590 (USB + Base)** | CMOS `1 MP (1280×800)`, Motionix + Green Spot, `IP52`, caídas `1,5 m`, USB HID + base | `$410.000` | `2` | `$820.000` | `$200.000` (`$100.000 × 2`) | **`$1.020.000`** | **`$1.213.800`** | [Datalogic QuickScan QD2500](https://www.datalogic.com/eng/retail-manufacturing-transportation-logistics-healthcare/general-purpose-handheld-scanners/quickscan-qd2500-pd-915.html) |

*Fórmula de normalización TCO 36 meses (idéntica a `02-presupuesto-proyecto.xlsx!5_Comparativo_TCO`):*  
`TCO_36M_sin_IVA = (Precio_unitario × Cantidad_sedes) + Mantenimiento_y_cables_36M`  
- **Zebra DS2208-SR:** `($380.000 × 2) + $160.000 = $760.000 + $160.000 = $920.000` (`× 1,19 = $1.094.800`).  
- **Honeywell Voyager XP 1470g:** `($430.000 × 2) + $160.000 = $860.000 + $160.000 = $1.020.000` (`× 1,19 = $1.213.800`).  
- **Datalogic QuickScan QD2590:** `($410.000 × 2) + $200.000 = $820.000 + $200.000 = $1.020.000` (`× 1,19 = $1.213.800`).

### 3.2. Matriz de criterios ponderados (`suma = 100 %`, escala `1,0` a `5,0`)

| Criterio de evaluación | Peso | Zebra DS2208 | Puntaje Zebra | Honeywell 1470g | Puntaje Honeywell | Datalogic QD2590 | Puntaje Datalogic | Justificación técnica de la calificación |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **1. TCO 36 meses normalizado (`2` sedes)** | `30 %` | `4,8` | `1,44` | `4,1` | `1,23` | `4,1` | `1,23` | Zebra logra el menor TCO a 36 meses (`$920.000` sin IVA), `$100.000` por debajo de ambas alternativas. |
| **2. Decodificación QR en pantalla móvil (brillo bajo)** | `25 %` | `4,8` | `1,20` | `4,8` | `1,20` | `4,4` | `1,10` | Zebra (PRZM) y Honeywell (`1470g`) son referentes en lectura sobre vidrio reflectante/OLED; Datalogic requiere ángulo más estricto cuando el brillo del teléfono es `< 30 %`. |
| **3. Robustez física, sellado IP y caídas en portería** | `20 %` | `4,6` | `0,92` | `4,8` | `0,96` | `4,5` | `0,90` | Honeywell soporta caídas de `1,8 m` (mejor impacto), pero Zebra y Datalogic ofrecen sellado `IP52` superior contra polvo y salpicaduras en porterías semiabiertas (`1,5 m`). |
| **4. Plug & Play USB HID y ergonomía con base incluida** | `15 %` | `4,8` | `0,72` | `4,6` | `0,69` | `4,4` | `0,66` | Los 3 emulan teclado USB sin drivers (`< 300 ms` por lectura), pero el kit estándar de Zebra incluye base articulada más compacta para escritorio estrecho. |
| **5. Garantía local y repuestos de cableado en Colombia** | `10 %` | `4,7` | `0,47` | `4,5` | `0,45` | `4,0` | `0,40` | Zebra y Honeywell cuentan con mayor inventario nacional de cables RJ45-USB de reemplazo rápido; Datalogic tiene menor rotación de repuestos en ciudades intermedias. |
| **TOTAL PONDERADO** | **`100 %`** | — | **`4,75`** | — | **`4,53`** | — | **`4,29`** | **Ganador: Zebra DS2208-SR (`4,75 / 5,00`)**. |

### 3.3. Recomendación razonada y motivos de descarte (Categoría 2)

- **Opción recomendada — Zebra DS2208-SR (`4,75 / 5,00` | TCO 36m `$920.000 sin IVA`):** Combina el menor costo total a 36 meses (`$920.000` por `2` sedes más `$240.000` del kit eléctrico/cableado común en `B2`), sellado `IP52` idóneo para portería SENA, lectura instantánea de QR TOTP en pantallas de celular y disponibilidad inmediata de garantía (`5` años fabricante) y repuestos en Colombia.
- **Por qué se descarta Honeywell Voyager XP 1470g (`4,53 / 5,00` | TCO 36m `$1.020.000 sin IVA`):** Ofrece excelente desempeño óptico, pero cuesta `$100.000 sin IVA` más (`+10,9 %` en TCO de lectores) y tiene menor protección contra polvo/llovizna en acceso (`IP40` frente a `IP52` de Zebra), sin aportar beneficio medible sobre QR estándar de `asistencia-sena`.
- **Por qué se descarta Datalogic QuickScan QD2590 (`4,29 / 5,00` | TCO 36m `$1.020.000 sin IVA`):** Iguala el mayor costo a 36 meses (`$1.020.000` por precio inicial y mayor costo de cable propietario de repuesto al Año 3) con menor penetración de distribuidores locales y menor tolerancia angular en pantallas con brillo bajo.

---

## 4. Consolidado de impacto en presupuesto `B2` (Variante B provisional)

| Categoría | Proveedor / Modelo seleccionado | TCO 36 meses sin IVA | TCO 36 meses con IVA (19 %) | Vínculo con `B2` (`02-presupuesto-proyecto.xlsx`) |
| :--- | :--- | :---: | :---: | :--- |
| **Cat. 1 (`FT-SW-02`)** | DigitalOcean (`4 vCPU/8 GB` + Spaces `250 GB` + Monitor) + Dominio | `$8.865.000` | `$10.549.350` | Hoja `3_Presupuesto_Detallado` (`N3`, `N4`, `N5`, `N6`, `N7`) + `4_Flujo_36_Meses` + `5_Comparativo_TCO` |
| **Cat. 2 (`FT-HW-02`)** | Zebra DS2208-SR (`2` uds. Año 1 + Mto/Cables Año 3) | `$920.000` | `$1.094.800` | Hoja `3_Presupuesto_Detallado` (`N1/N2 -> FT-HW-02`) + `4_Flujo_36_Meses` + `5_Comparativo_TCO` |
| **Total comparado** | **Proveedores seleccionados (`Cat. 1 + Cat. 2`)** | **`$9.785.000`** | **`$11.644.150`** | *Incluye el 100 % de los rubros variables externos ligados a infraestructura y periféricos QR.* |

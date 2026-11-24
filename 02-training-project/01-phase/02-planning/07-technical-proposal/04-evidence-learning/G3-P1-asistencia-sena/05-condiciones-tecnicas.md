# A5 · Estimación de Condiciones Técnicas de Capacidad y Servicio

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P1 · Especificaciones técnicas (`RAP 593060`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-24`  
**Escenario provisional activo:** **Variante B** (`U = 120` usuarios totales, `C = 30` concurrentes pico, `S = 2` sedes, disponibilidad `99,5 %` mensual).  
**Trazabilidad:** Coherente 100 % con las fichas `FT-SW-01`, `FT-SW-02`, `FT-INF-01` ([02-fichas-tecnicas.md](02-fichas-tecnicas.md)) y el Acuerdo de Niveles de Servicio ([`G3-P2/06-contrato-tdr-ans.md`](../G3-P2-asistencia-sena/06-contrato-tdr-ans.md) §3).

---

## 1. Parámetros Medibles de Capacidad y Servicio (`7` Parámetros con Fórmula y Supuesto)

| ID | Parámetro técnico | Fórmula / Cálculo explícito | Supuestos declarados | Valor objetivo (Variante B provisional) | Coherencia con fichas y ANS |
| :- | :--- | :--- | :--- | :--- | :--- |
| **CAP-01** | **Usuarios totales (`U`) y concurrentes pico (`C`)** | `U` y `C` tomados directamente de la variante; capacidad de diseño = `C × 2` (`factor de seguridad 2x` para picos de entrada a clase de `07:00 a. m.` y `06:00 p. m.`). | Cada aprendiz registra asistencia 1–2 veces/día en ventanas de 5–10 min; se dimensiona `Apache + PHP-FPM` para soportar el doble de `C` sin degradación. | **`120` usuarios totales / `30` concurrentes pico** *(diseñado hasta `60` req/s sostenidos)* | `FT-SW-01` (#2), `FT-INF-01` (`4 vCPU / 8 GiB RAM`) |
| **CAP-02** | **Almacenamiento inicial y crecimiento anual a `36` meses** | `BD_año = (U × 240 días/año × 2 reg/día × 1,2 KB/fila) + (15 % índices + logs/novedades)`. `Respaldo_30d = 30 × (BD_total × factor_compresión_0,35) + imágenes_sistema`. | `240` días hábiles académicos al año; `1,2 KB` promedio por registro incluyendo columnas GPS/red y entidad débil `novedad_contingencia`; retención diaria de `30` días en S3 `[N6]`. | **BD año 1:** `~85 MB`; **BD año 3:** `~255 MB`; **Sistema + logs + snapshots:** `~18 GB`; **Capacidad aprovisionada:** **`160 GB NVMe` (`[N4]`/`[N5]`) + `250 GB S3` (`[N6]`)** | `FT-INF-01` (#3), `FT-SW-02` (#3) |
| **CAP-03** | **Ancho de banda pico y transferencia mensual** | `BW_pico = C × Peso_carga_página (320 KB) × 8 bits / 2 s`. `Transf_mes = U × 2 sesiones/día × 22 días × 450 KB + consultas_admin (120 MB/día)`. | Páginas HTML/CSS/JS ligeras sin frameworks pesados (`qrcode.min.js` auto-alojado con caché HTTP 30 días); tráfico cifrado `HTTPS 443`. | **Pico en hora de entrada:** `~38,4 Mbps` *(enlace VPS `≥ 1.000 Mbps`)*; **Transferencia mensual:** **`~5,9 GB/mes`** *(plan incluye `≥ 2.000 GB/mes`)* | `FT-INF-01` (#4), `FT-SW-02` (#4) |
| **CAP-04** | **Disponibilidad objetivo mensual (`ANS-01`)** | `Tiempo_caída_máx_mes = 720 h/mes × (1 - Meta_disponibilidad)`. | Mes calendario estándar de `30` días (`720` horas), medición `24×7` por monitor externo `[N7]`, excluyendo mantenimientos programados `≤ 2 h/mes` en horario `00:00–05:00`. | **`≥ 99,5 %` mensual** *(caída no programada máxima permitida: **`3,6 horas/mes`**)* | `FT-SW-01`, `FT-SW-02` (#1), `ANS-01` |
| **CAP-05** | **Tiempo de respuesta `p95` (`ANS-02`)** | `T_total_p95 = T_red_TLS (≤ 90 ms) + T_PHP_fachada (≤ 180 ms) + T_SQL_InnoDB (≤ 80 ms) + T_render (≤ 150 ms) = ~0,50 s nominal` (límite contractual `≤ 2,0 s` bajo carga `C`). | Región América en VPS, `InnoDB` con índice `idx_reg_fecha_hora` y `UNIQUE (id_aprendiz, id_sesion)` sin DDL en runtime (`G2-P1/A4`). | **`≤ 2,0 segundos`** en percentil `95` bajo `30` peticiones concurrentes | `FT-SW-01` (#1), `ANS-02` |
| **CAP-06** | **Objetivo de Punto de Recuperación (`RPO`, `ANS-03`)** | `RPO = Intervalo_máximo_entre_respaldos_externos = 24 horas`. | Ejecución automatizada diaria de `mysqldump --single-transaction` a las `02:00 a. m.` (`America/Bogota`) cifrada `AES-256` hacia bucket S3 externo `[N6]`. | **`≤ 24 horas`** *(pérdida máxima tolerable ante falla grave del nodo `[N5]`)* | `FT-SW-02` (#5), `ANS-03` |
| **CAP-07** | **Objetivo de Tiempo de Recuperación (`RTO`, `ANS-04`)** | `RTO = T_detección (≤ 5 min) + T_respuesta_P1 (≤ 30 min) + T_aprovisionamiento_compose (≤ 35 min) + T_restauración_S3_y_verificación (≤ 50 min) ≤ 120 min`. | Imágenes Docker reproducibles, repositorio Git listo, respaldos en S3 verificados mensualmente mediante prueba de restauración (`POL-DIS-02`). | **`≤ 2 horas`** *(con respuesta inicial ante incidente crítico `P1 ≤ 30 min`)* | `FT-SW-01` (#13), `FT-SW-02` (#6), `ANS-04` |

---

## 2. Matriz Paramétrica de Condiciones Técnicas por Variante (`Anexo A`)

Para facilitar la actualización inmediata si el instructor confirma otra variante distinta de la **Variante B provisional**, la siguiente tabla recalcula cada condición técnica para las 4 variantes del `Anexo A`:

| Parámetro de capacidad / servicio | Variante A | **Variante B *(Activa Provisional)*** | Variante C | Variante D |
| :--- | :---: | :---: | :---: | :---: |
| Usuarios totales (`U`) | `60` | **`120`** | `250` | `500` |
| Usuarios concurrentes pico (`C`) | `15` | **`30`** | `60` | `120` |
| Sedes cubiertas (`S`) / Lectores QR (`FT-HW-02`) | `1` sede / `1` lector | **`2` sedes / `2` lectores** | `3` sedes / `3` lectores | `4` sedes / `4` lectores |
| Disponibilidad mensual (`CAP-04` / `ANS-01`) | `≥ 99,0 %` *(máx. `7,2 h/mes`)* | **`≥ 99,5 %` *(máx. `3,6 h/mes`)*** | `≥ 99,5 %` *(máx. `3,6 h/mes`)* | `≥ 99,9 %` *(máx. `43 min/mes`)* |
| Topología de servidores (`[N4]` + `[N5]`) | `1` nodo VPS (`4 vCPU / 8 GB`) | **`1` nodo VPS (`4 vCPU / 8 GB`)** | `1` nodo VPS escalado (`8 vCPU / 16 GB`) | `2` nodos activos balanceados + réplica BD |
| Almacenamiento BD estimado a 36 meses | `~130 MB` BD (`160 GB NVMe`) | **`~255 MB` BD (`160 GB NVMe`)** | `~530 MB` BD (`240 GB NVMe`) | `~1,06 GB` BD (`320 GB NVMe × 2`) |
| Transferencia mensual estimada en red | `~3,1 GB/mes` | **`~5,9 GB/mes`** | `~11,5 GB/mes` | `~22,5 GB/mes` |
| Ancho de banda pico requerido | `~19,2 Mbps` | **`~38,4 Mbps`** | `~76,8 Mbps` | `~153,6 Mbps` |
| Latencia `p95` (`CAP-05`) / `RPO` / `RTO` | `≤ 2,0 s` / `≤ 24 h` / `≤ 2 h` | **`≤ 2,0 s` / `≤ 24 h` / `≤ 2 h`** | `≤ 2,0 s` / `≤ 24 h` / `≤ 2 h` | `≤ 2,0 s` / `≤ 12 h` / `≤ 1 h` |
| Tope presupuestal primer año (`Anexo A`) | `$45.000.000` COP | **`$70.000.000` COP** | `$110.000.000` COP | `$160.000.000` COP |

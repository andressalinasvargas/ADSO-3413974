# A2 · Fichas Técnicas de Especificaciones (`4` Fichas Diligenciadas)

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P1 · Especificaciones técnicas (`RAP 593060`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-24`  
**Formato aplicado:** [01-formato-ficha-tecnica.md](01-formato-ficha-tecnica.md) (`15` campos basados en `ISO/IEC/IEEE 29148:2018` e `ISO/IEC 25010:2023`)  
**Escenario parametrizado:** **Variante B provisional** (`120` usuarios totales, `30` concurrentes pico, `2` sedes, disponibilidad `99,5 %` mensual), pendiente de confirmación final del instructor en Día 3.  
**Regla de neutralidad tecnológica (`Rubricas_G3.md` C2):** Ninguna ficha exige marcas o modelos comerciales obligatorios; únicamente se declaran protocolos o interfaces estándar de compatibilidad técnica.

---

## Ficha Técnica `FT-SW-01` — Sistema Web de Control de Asistencia (`asistencia-sena`, Software Propio)

| # | Campo | Especificación verificable |
| :- | :--- | :--- |
| **1** | **Código de ficha** | `FT-SW-01` |
| **2** | **Nombre del componente o servicio** | Aplicación Web de Control de Asistencia Institucional (`asistencia-sena`) — Software propio |
| **3** | **Categoría** | `Software propio` |
| **4** | **Versión, fecha y variante** | Versión `1.1` *(propagada tras validación `B5`)* · `2026-11-24` · Variante `B` *(provisional)* |
| **5** | **Descripción técnica y función** | Aplicación web de 3 capas en PHP 8.3 (POO con patrones GoF Estrategia y Fachada) y SQL/PDO sobre MariaDB 10.11 para apertura/cierre de sesiones de clase, autorregistro móvil por QR rotativo o código numérico de 6 dígitos con geocerca Haversine y consentimiento Ley 1581, registro por escáner QR 2D, contingencia manual con novedades, cálculo automático de tardanzas con tolerancia configurable por ficha (`5–30 min`, defecto `15 min`, ajuste `AJ-02`) y reportes CSV. |
| **6** | **Ubicación en arquitectura y trazabilidad** | Contenedor `sena-asistencias-web` en nodo `[N4]` Servidor Aplicación (`03-diagrama-arquitectura-despliegue-g3.svg`); soporta `RF-01` a `RF-12` y `RNF-01` a `RNF-06`. |
| **7** | **Cantidad y unidad de medida** | `1` sistema licenciado integral (`1` instancia desplegable en `1` contenedor web para Variantes A–C; `2` instancias detrás de balanceador en Variante D). |
| **8** | **Características técnicas medibles** | Ver subtabla `FT-SW-01` (`7` características medibles a continuación). |
| **9** | **Normas y estándares aplicables** | Ley 1581 de 2012 y Decreto 1074 de 2015, Ley 23 de 1982, Decisión Andina 351 de 1993, Ley 1273 de 2009, W3C WCAG 2.2 (Nivel AA) e ISO/IEC 25010:2023 (`03-referente-tecnico-normativo.md`). |
| **10** | **Compatibilidad e interoperabilidad** | Protocolo `HTTP/HTTPS` (`TLS 1.2/1.3`), PHP `8.3+`, conector `PDO_MySQL` compatible con MariaDB `10.11+`, HTML5 `Geolocation API` y `BarcodeDetector`, exportación estándar `CSV UTF-8`, navegadores modernos (`Chrome`, `Edge`, `Firefox`, `Safari` móvil `≥ 390 px`). |
| **11** | **Requisitos de seguridad y privacidad** | Contraseñas con hash y sal única (`BCrypt`/`Argon2id`), cookies de sesión `HttpOnly` + `SameSite=Lax`, protección CSRF en formularios de estado, sentencias preparadas PDO nativas, consentimiento explícito `consentimiento_datos = 1` obligatorio antes de capturar ubicación y bloqueo `.htaccess` (`HTTP 403`) sobre archivos sensibles. |
| **12** | **Condiciones de licenciamiento** | Licencia Propietaria / Privativa con cesión escrita de derechos patrimoniales al contratante y reserva de derechos morales (`04-dimensionamiento-licencias.md` §3); dependencias OSS inventariadas (`PHP 3.01`, `Apache 2.0`, `MIT` auto-alojando `qrcode.min.js`). |
| **13** | **Garantía, soporte y ANS** | Garantía de corrección de defectos de código de `6` meses sin costo; soporte operativo contratado a `12` meses; disponibilidad objetivo `≥ 99,5 %` mensual (`ANS-01`), latencia `p95 ≤ 1,5 s` (`ANS-02` `v1.1` ajustado desde `2,0 s` en `B5`), respuesta `P1 ≤ 30 min` y `RTO ≤ 2 h` (`ANS-04`). |
| **14** | **Condiciones de entrega, instalación y mantenimiento** | Empaquetado reproducible en contenedor Docker (`Dockerfile` + `docker-compose.yml`), script DDL 3FN (`05-script-creacion.sql`), suite E2E automatizada aprobada (`100 %`), manuales técnicos/usuario, `3` videocápsulas breves (`≤ 5 min`, `SUG-04`) y capacitación de `8 h` por sede (`2` sedes = `16 h`). |
| **15** | **Observaciones, supuestos y exclusiones** | No exige instalación de aplicación nativa en teléfonos de aprendices (`TdR-01`). Excluye dispositivos finales (`[N1]`/`[N2]`) y requiere dominio `HTTPS 443` para habilitar cámara y geolocalización en navegadores. |

#### Subtabla de Características Medibles — `FT-SW-01`

| # | Característica técnica | Valor objetivo | Unidad | Método de verificación |
| :- | :--- | :--- | :--- | :--- |
| 1 | Tiempo de respuesta `p95` en registro de asistencia (`30` usuarios concurrentes, `v1.1` `AJ-02`) | `≤ 1,5` *(antes `≤ 2,0`)* | segundos | Prueba de carga HTTP simulando `30` peticiones simultáneas sobre `registro.php` y `registrar_asistencia.php` con `PHP OPcache` y tuning `InnoDB` |
| 2 | Capacidad de usuarios y sedes soportadas (Variante B) | `≥ 120` usuarios / `2` | usuarios / sedes | Prueba funcional con carga de `120` registros de aprendices distribuidos en `2` sedes |
| 3 | Precisión máxima admitida de geocerca GPS (`Geolocation API`) | `≤ 100` (radio `300`) | metros | Prueba E2E verificando rechazo de registros con `precision > 100 m` o fuera del radio Haversine |
| 4 | Tiempo de detección de duplicados por aprendiz y sesión (`SQLSTATE 23000`) | `100 %` rechazo (`1` fila) | % integridad | Prueba de doble envío concurrente contra restricción `uk_reg_aprendiz_sesion` en MariaDB |
| 5 | Cobertura mínima de pruebas E2E automatizadas sin errores | `100 %` (`6/6` suites) | % casos aprobados | Ejecución automatizada de `npx playwright test` previo al acta de entrega |
| 6 | Adaptabilidad y accesibilidad visual móvil (WCAG 2.2 AA) | `0` desbordamiento a `≥ 390` / contraste `≥ 4,5:1` | píxeles / ratio | Inspección automática en viewport `390×844` y chequeo de contraste de texto/botones |
| 7 | Tiempo de expiración de token rotativo de sesión y código numérico | `≤ 15` (configurable) | minutos | Verificación de marcas `inicia_en` y `vence_en` en `sesion_asistencia` y prueba de código vencido |

---

## Ficha Técnica `FT-SW-02` — Servicio Cloud de Cómputo VPS y Almacenamiento S3 (`N3`/`N4`/`N5`/`N6`)

| # | Campo | Especificación verificable |
| :- | :--- | :--- |
| **1** | **Código de ficha** | `FT-SW-02` |
| **2** | **Nombre del componente o servicio** | Servicio de Servidor Privado Virtual (VPS) Linux, Almacenamiento Externo S3 y Monitoreo HTTP |
| **3** | **Categoría** | `Servicio de software o nube` |
| **4** | **Versión, fecha y variante** | Versión `1.1` *(propagada tras validación `B5`)* · `2026-11-24` · Variante `B` *(provisional)* |
| **5** | **Descripción técnica y función** | Servicio IaaS en la nube que aloja el proxy inverso TLS (`[N3]`), el servidor de aplicaciones Docker (`[N4]`) y la base de datos MariaDB (`[N5]`), complementado con almacenamiento de objetos compatible S3 (`[N6]`) para `2` copias diarias cifradas (`02:00` y `14:00`) fuera del servidor y servicio externo de monitoreo HTTP (`[N7]`). |
| **6** | **Ubicación en arquitectura y trazabilidad** | Nodos `[N3]`, `[N4]`, `[N5]`, `[N6]` y `[N7]` de `03-diagrama-arquitectura-despliegue-g3.svg`; soporta `RNF-01`, `RNF-03`, `RNF-05` y `RNF-06`. |
| **7** | **Cantidad y unidad de medida** | `1` instancia VPS Linux (`N_srv = 1` en Variantes A–C; `2` en D) + `1` bucket S3 (`≥ 250 GB`) + `1` dominio DNS + `1` monitor HTTP, contratados por `12` meses (`36` meses en flujo TCO). |
| **8** | **Características técnicas medibles** | Ver subtabla `FT-SW-02` (`6` características medibles a continuación). |
| **9** | **Normas y estándares aplicables** | Ley 1581 de 2012 y Decreto 1074 de 2015 art. `2.2.2.25.5.2` (contrato de **transmisión** como Encargado), ISO/IEC 27001:2022 (controles de respaldo y cifrado), ISO/IEC 25010:2023. |
| **10** | **Compatibilidad e interoperabilidad** | Sistema operativo Linux (`Ubuntu 24.04 LTS` o equivalente `x86_64`), Docker Engine CE + Compose v2, API S3 estándar (`HTTPS 443`), protocolo `ACME` para Let's Encrypt, salida SMTP/HTTPS para alertas de monitoreo. |
| **11** | **Requisitos de seguridad y privacidad** | Firewall perimetral permitiendo únicamente puertos `443/tcp` (`HTTPS`), `80/tcp` (redirección ACME) y `SSH` restringido por llave pública; puerto `3306` cerrado a Internet; cifrado en reposo `AES-256` en almacenamiento S3 de respaldos; prohibición de transferencia comercial de datos. |
| **12** | **Condiciones de licenciamiento** | Suscripción mensual de infraestructura en nube sin licenciamiento propietario por usuario final; el sistema operativo y Docker CE sobre Linux operan bajo licencias libres (`04-dimensionamiento-licencias.md`). |
| **13** | **Garantía, soporte y ANS** | SLA de infraestructura del proveedor `≥ 99,9 %`; disponibilidad global del servicio web `≥ 99,5 %` mensual (`ANS-01`), `RPO ≤ 12 h` (`ANS-03` `v1.1` ajustado desde `24 h` en `B5`) y `RTO ≤ 2 h` (`ANS-04`). |
| **14** | **Condiciones de entrega, instalación y mantenimiento** | Aprovisionamiento en región América (latencia `≤ 90 ms` a Colombia), configuración automatizada de cron `mysqldump` a las `02:00 a. m.` y `02:00 p. m.` (`14:00`) hacia S3 (`60` snapshots en `30` días, `AJ-01`), verificación diaria de checksums SHA-256 y prueba mensual de restauración. |
| **15** | **Observaciones, supuestos y exclusiones** | Precios de proveedores comparados en `G3-P2/B1` convertidos con TRM `$4.000/USD` sin IVA. Si la variante pasa a `D` (`99,9 %`), `N_srv` escala a `2` instancias activas. |

#### Subtabla de Características Medibles — `FT-SW-02`

| # | Característica técnica | Valor objetivo | Unidad | Método de verificación |
| :- | :--- | :--- | :--- | :--- |
| 1 | Disponibilidad mensual garantizada del servicio web (`ANS-01`) | `≥ 99,5` | % mensual | Reporte mensual del monitor HTTP externo `[N7]` con sondeo cada `60 s` |
| 2 | Latencia de red promedio desde Colombia hacia región del VPS | `≤ 90` | milisegundos (`ms`) | Medición `ping` / `curl -w %{time_connect}` desde estación en Colombia |
| 3 | Capacidad mínima del almacenamiento externo de respaldos S3 (`[N6]`) | `≥ 50` (base `250`) | GB | Consola/CLI de almacenamiento S3 y validación de retención `30` días (`60` snapshots) |
| 4 | Transferencia mensual de datos incluida sin cobro adicional | `≥ 2.000` | GB/mes (`2 TB`) | Especificación pública de plan contratado y panel de consumo de red |
| 5 | Objetivo de Punto de Recuperación (`RPO`, `ANS-03`, `v1.1` `AJ-01`) | `≤ 12` *(antes `≤ 24`)* | horas | Auditoría de doble ejecución diaria cifrada `AES-256` (`02:00` y `14:00`) en `[N6]` |
| 6 | Objetivo de Tiempo de Recuperación (`RTO`, `ANS-04`) | `≤ 2` | horas | Acta mensual de simulacro de restauración completa desde bucket S3 |

---

## Ficha Técnica `FT-INF-01` — Infraestructura de Cómputo de Servidor y Red Segura (`N4`/`N5`)

| # | Campo | Especificación verificable |
| :- | :--- | :--- |
| **1** | **Código de ficha** | `FT-INF-01` |
| **2** | **Nombre del componente o servicio** | Nodo de Infraestructura de Cómputo, Memoria y Almacenamiento NVMe para Contenedores (`Web + BD`) |
| **3** | **Categoría** | `Infraestructura de red o respaldo` |
| **4** | **Versión, fecha y variante** | Versión `1.0` · `2026-11-24` · Variante `B` *(provisional)* |
| **5** | **Descripción técnica y función** | Perfil mínimo de hardware virtual o físico requerido para ejecutar simultáneamente el servidor web (`Apache 2.4 + PHP 8.3`), el proxy inverso TLS (`Nginx/Caddy`) y el motor transaccional `MariaDB 10.11 InnoDB` con aislamiento por red puente privada y almacenamiento SSD/NVMe de alta tasa IOPS. |
| **6** | **Ubicación en arquitectura y trazabilidad** | Sustenta los nodos `[N3]`, `[N4]` y `[N5]` en `03-diagrama-arquitectura-despliegue-g3.svg`; soporta `RNF-01`, `RNF-03`, `RNF-05` y `RNF-06`. |
| **7** | **Cantidad y unidad de medida** | `1` nodo de cómputo (`4 vCPU`, `8 GiB RAM`, `160 GB NVMe`) para Variantes A–C; `2` nodos activos para Variante D. |
| **8** | **Características técnicas medibles** | Ver subtabla `FT-INF-01` (`6` características medibles a continuación). |
| **9** | **Normas y estándares aplicables** | ISO/IEC 25010:2023 (eficiencia de desempeño y fiabilidad), ISO/IEC 27001:2022 (segmentación de red y control de acceso), Ley 1273 de 2009. |
| **10** | **Compatibilidad e interoperabilidad** | Arquitectura `x86_64` (`AMD64`) con virtualización KVM/bare-metal, soporte de volúmenes persistentes Linux `ext4`/`xfs`, interfaz de red `IPv4/IPv6` de `≥ 1 Gbps` y red puente interna Docker (`172.x`) aislada. |
| **11** | **Requisitos de seguridad y privacidad** | Acceso administrativo exclusivamente por `SSH` con llave ed25519 (contraseña SSH deshabilitada), firewall de sistema operativo activo (`UFW`/`nftables`), cifrado de volumen o de respaldos `AES-256`, actualización automática de parches de seguridad del kernel. |
| **12** | **Condiciones de licenciamiento** | Hardware/infraestructura aprovisionada bajo plan mensual (`FT-SW-02`) o servidor institucional equivalente; sin cobro de licencia por procesador ni por núcleo en `Ubuntu` / `Docker CE` / `MariaDB Community`. |
| **13** | **Garantía, soporte y ANS** | Reemplazo automático de host físico ante falla de hardware por el proveedor IaaS; soporte técnico de administración Linux incluido en plan de operación `12` meses (`ANS-01` `≥ 99,5 %`). |
| **14** | **Condiciones de entrega, instalación y mantenimiento** | Verificación de recursos (`nproc`, `free -h`, `df -h`) y prueba de conectividad privada `TCP 3306` entre contenedores; mantenimiento preventivo mensual programado en ventana `00:00–05:00` (`≤ 2 h/mes`). |
| **15** | **Observaciones, supuestos y exclusiones** | Dimensionado con holgura del `100 %` en CPU/RAM para absorber picos de ingreso simultáneo al inicio de jornada académica (`30`–`60` aprendices en los primeros `5` minutos). Excluye hardware de red local de aulas. |

#### Subtabla de Características Medibles — `FT-INF-01`

| # | Característica técnica | Valor objetivo | Unidad | Método de verificación |
| :- | :--- | :--- | :--- | :--- |
| 1 | Núcleos de procesamiento dedicados o vCPU de alto rendimiento | `≥ 4` | vCPU (`x86_64`) | Comando `nproc` y lectura de `/proc/cpuinfo` en el servidor desplegado |
| 2 | Memoria RAM asignada para servidor web, opcache y buffer pool `InnoDB` | `≥ 8` | GiB | Inspección con `free -h` bajo carga nominal verificando uso `< 75 %` |
| 3 | Almacenamiento primario de estado sólido (`SSD / NVMe`) | `≥ 160` | GB | Verificación con `df -h` y prueba de lectura/escritura secuencial `fio`/`dd` |
| 4 | Velocidad de enlace de red pública/privada del nodo | `≥ 1.000` (`1` Gbps) | Mbps | Inspección de interfaz (`ethtool` / especificación de red del proveedor) |
| 5 | Aislamiento de puertos expuestos a Internet (superficie de ataque) | Solo `80`, `443` y `SSH` (`3306` cerrado) | puertos abiertos | Escaneo externo (`nmap`) y verificación de reglas `ufw status` |
| 6 | Retención de *snapshots* o puntos de restauración local previa a cambios | `≥ 7` | días | Verificación de política de instantáneas activada en consola de infraestructura |

---

## Ficha Técnica `FT-HW-02` — Estación Lectora Óptica de Código QR 2D USB para Sede (`Periférico de [N1]`)

| # | Campo | Especificación verificable |
| :- | :--- | :--- |
| **1** | **Código de ficha** | `FT-HW-02` |
| **2** | **Nombre del componente o servicio** | Lector Óptico Imager 2D de Escritorio con Interfaz USB y Base Manos Libres *(sin exigencia de marca)* |
| **3** | **Categoría** | `Hardware` |
| **4** | **Versión, fecha y variante** | Versión `1.0` · `2026-11-24` · Variante `B` *(provisional)* |
| **5** | **Descripción técnica y función** | Dispositivo periférico de captura óptica bidimensional (`2D Imager`) conectado al computador del instructor (`[N1]`) en cada sede, destinado a escanear rápidamente el código QR individual del carné o pantalla móvil del aprendiz durante el registro asistido (`RF-08`, `EstrategiaEscanerQr`), reduciendo errores de lectura en aulas con iluminación variable o cuando no se usa cámara web integrada. |
| **6** | **Ubicación en arquitectura y trazabilidad** | Periférico de entrada conectado al nodo `[N1]` (`Cliente Escritorio`, `scanner.php`); soporta `RF-08`, `RNF-04` y `RNF-05` (continuidad operativa). |
| **7** | **Cantidad y unidad de medida** | `2` equipos físicos (`1` por cada sede de la Variante B; parametrizado como `N_hw = S` sedes: `1` en A, `2` en B, `3` en C, `4` en D), más `1` kit de cable blindado y regleta supresora por equipo. |
| **8** | **Características técnicas medibles** | Ver subtabla `FT-HW-02` (`6` características medibles a continuación). |
| **9** | **Normas y estándares aplicables** | Estándar de simbología `ISO/IEC 18004` (QR Code), `ISO/IEC 15417` (Code 128), seguridad eléctrica y compatibilidad electromagnética (`CE` / `FCC`), `ISO/IEC 25010:2023` (capacidad de interacción). |
| **10** | **Compatibilidad e interoperabilidad** | Emulación estándar de teclado **`USB HID-KBW`** (*Plug & Play* sin controladores propietarios) con sufijo `Enter` configurable; compatible con `Windows 10/11`, `Linux` y `macOS` y con lectura directa en campo de entrada HTML5 de `scanner.php`. |
| **11** | **Requisitos de seguridad y privacidad** | El dispositivo no almacena localmente datos personales ni historiales de documentos (operación estrictamente en modo transmisión inmediata de token QR hacia la sesión autenticada del instructor por `HTTPS 443`). |
| **12** | **Condiciones de licenciamiento** | Adquisición única de propiedad del hardware (sin suscripción ni licencias recurrentes de software propietario para captura). |
| **13** | **Garantía, soporte y ANS** | Garantía de fábrica mínima de `36` meses (`3` años; modelos evaluados ofrecen `36`–`60` meses); reposición en sitio o equipo de respaldo según cobertura de hardware (`G3-P2/B1`). |
| **14** | **Condiciones de entrega, instalación y mantenimiento** | Entrega en sede física con base graduable manos libres, cable USB `≥ 1,8 m`, prueba de lectura de `20` carnés impresos y pantallas móviles reales, y configuración de sufijo salto de línea (`CR/LF`). |
| **15** | **Observaciones, supuestos y exclusiones** | **No se exige marca comercial**; cualquier fabricante que cumpla las 6 características medibles es admisible (`B1` evalúa 3 alternativas reales de mercado). Excluye el computador `[N1]` donde se conecta. |

#### Subtabla de Características Medibles — `FT-HW-02`

| # | Característica técnica | Valor objetivo | Unidad | Método de verificación |
| :- | :--- | :--- | :--- | :--- |
| 1 | Tipo de sensor óptico y simbologías soportadas | `2D CMOS Area Imager` (QR `ISO/IEC 18004`, DataMatrix, Code 128) | tecnología / estándar | Prueba práctica de lectura sobre QR en papel mate y pantalla de celular |
| 2 | Capacidad de lectura sobre pantallas iluminadas/retroiluminadas | Lectura efectiva con brillo móvil `≥ 30 %` en `< 0,5 s` | segundos / % brillo | Cronometraje de `10` escaneos consecutivos en `scanner.php` sobre teléfono Android/iOS |
| 3 | Tolerancia de caída física y sellado ambiental | Resistencia a caídas `≥ 1,5` m y protección `≥ IP42` | metros / grado IP | Revisión de ficha técnica oficial del fabricante previa a recepción |
| 4 | Interfaz física y modo de operación | `USB 2.0` (`HID-KBW` *Plug & Play*, cable `≥ 1,8 m`) | estándar / metros | Conexión en equipo estándar Windows/Linux comprobando detección automática sin driver |
| 5 | Ángulo de tolerancia y modo manos libres | Lectura omnidireccional `360°` + base de escritorio incluida | grados / accesorio | Prueba de escaneo en base fija pasando QR en ángulos horizontal y vertical |
| 6 | Garantía mínima respaldada en Colombia | `≥ 36` | meses | Certificado de garantía del distribuidor autorizado adjunto a la factura |

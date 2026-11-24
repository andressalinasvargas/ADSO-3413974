# A4 · Dimensionamiento de Licencias, Inventario de Dependencias y Propiedad Intelectual

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P1 · Especificaciones técnicas (`RAP 593060`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Insumos auditados del proyecto:** `Dockerfile`, `docker-compose.yml`, `e2e/package.json`, `e2e/package-lock.json`, `sesion.php`, `qr.php`, `politica_datos.php` y `03-execute/24-week/02-optional-activity/Toma_Asistencia.zip`.

---

## 1. Dimensionamiento de Licencias por Componente (`8` Componentes Tecnológicos)

> **Parametrización respecto a la variante del escenario (`Anexo A`):** Como la variante oficial (`A`, `B`, `C` o `D`) está pendiente de confirmación del instructor, cada fila expresa la **fórmula exacta en función de usuarios totales (`U`), usuarios concurrentes (`C`), sedes (`S`) y desarrolladores (`D = 2`)**, seguida de una matriz de resultados para las cuatro variantes (`A`–`D`). En cuanto se confirme la variante, se fija la columna activa en Commit 3 junto a `A2`, `A5` y `A6`.

| # | Categoría y componente | Tipo de licencia | Modelo de cobro | Fórmula de cantidad a partir de la variante | Costo unitario de referencia (COP sin IVA, TRM `$4.000`) | Costo anual / periodo | Obligación de cumplimiento y restricciones |
| :- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **Sistema operativo de servidor** — Ubuntu Server 24.04 LTS | Software libre / código abierto (GPL v2/v3 + paquetes OSS) | Gratuita por instancia | `N_srv = 1` si `C ≤ 60` (Variantes A–C); `2` nodos activos si `C > 60` o `disp. ≥ 99,9 %` (Variante D) | `$0` (actualizaciones estándar gratuitas; Ubuntu Pro gratis hasta 5 máquinas) | `$0 / año` | Conservar avisos de licencia de paquetes redistribuidos; parches de seguridad periódicos sin costo de licencia. |
| **2** | **Motor de contenedores** — Docker Engine CE + Compose v2 (Linux) | Código abierto (**Apache License 2.0**) | Gratuita en servidor Linux *(alerta: Docker Desktop exige suscripción paga en empresas `> 250` empleados o `> USD 10M` ingresos)* | `N_srv` instancias en servidor (misma fórmula que #1) | `$0` en servidor Linux (`Docker Engine CE`). Si la entidad usara Docker Desktop comercial: `USD 9/usuario/mes` | `$0 / año` *(usando Docker Engine Linux + Rancher/Podman en estaciones)* | Atribución Apache 2.0; prohibido instalar Docker Desktop sin licencia comercial si el contratante supera umbrales de Docker Inc. |
| **3** | **Servidor web y runtime de aplicación** — Apache HTTP Server 2.4 + PHP 8.3 | Código abierto (**Apache License 2.0** + **PHP License 3.01**) | Gratuita por instancia / sin límite de usuarios ni núcleos | `N_web = N_srv` contenedores (`1` en A–C; `2` balanceados en D) | `$0` | `$0 / año` | Conservar avisos de copyright Apache 2.0; PHP License 3.01 prohíbe usar el nombre «PHP» para promocionar derivados sin autorización. |
| **4** | **Sistema gestor de base de datos** — MariaDB Community Server 10.11 (`InnoDB`) | Software libre copyleft (**GPL v2**) | Gratuita por instancia / sin cobro por núcleo ni usuario | `N_db = 1` instancia principal (`A`–`C`); `2` nodos primario + réplica si `disp. ≥ 99,9 %` (`D`) | `$0` (edición Community) | `$0 / año` | Al ejecutarse como **proceso independiente por red TCP (`3306`)** consumido vía extensión `PDO_MySQL` de PHP (sin enlazar estáticamente código GPL en `asistencia-sena`), **no activa copyleft** sobre el código fuente propio. |
| **5** | **Certificado digital TLS/SSL** — Let's Encrypt (ACME / Certbot) | Servicio abierto sin costo (ISRG) | Gratuita por dominio / subdominio (`renovación cada 90 días`) | `N_cert = 1` certificado principal (o `1` por sede si se usan subdominios independientes `S`) | `$0` | `$0 / año` | Automatizar renovación con Certbot/Caddy cada 60–90 días y monitorear vencimiento para no interrumpir `HTTPS 443`, `Geolocation API` ni `BarcodeDetector`. |
| **6** | **Control de versiones y CI/CD** — Git + GitHub (repositorio privado institucional) | Git (**GPL v2**, gratuito) + GitHub (**Propietaria SaaS — suscripción**) | Nominal por usuario desarrollador (`D = 2` desarrolladores) | `Q_git = D = 2` cuentas nominales (`GitHub Free` cubre repositorios privados y `2.000 min/mes` de Actions; `GitHub Team` si se requieren reglas avanzadas: `USD 4/usuario/mes`) | `$0` (Plan Free) o `USD 4 × 4.000 = $16.000 / dev / mes` (Team) | `$0` (Free) o `$384.000 / año` (2 devs en Team) | Respetar términos de servicio de GitHub; prohibido subir secretos, contraseñas o datos personales reales de aprendices al repositorio. |
| **7** | **Herramientas de desarrollo y diagramación** — Visual Studio Code + diagrams.net (`draw.io`) | VS Code (código **MIT**, distribución Microsoft gratuita) + draw.io (**Apache 2.0**) | Gratuita nominal por estación de desarrollo (`D = 2`) | `Q_ide = D = 2` estaciones de trabajo | `$0` | `$0 / año` | Permitido uso comercial y educativo sin costo; verificar licencias individuales de extensiones de terceros instaladas en el IDE. |
| **8** | **Infraestructura en nube (VPS + Almacenamiento de respaldos S3 + Dominio)** | Servicio propietario de infraestructura (**Suscripción mensual / anual**) | Por instancia mensual + GB almacenamiento + dominio anual | `N_srv` servidores VPS (`1` en A–C, `2` en D) + `1` bucket S3 (`≥ 50 GB` para `30` respaldos diarios cifrados) + `1` dominio `.co`/`.com` | Dominio: `$75.000/año`; VPS y S3 según proveedor ganador en `G3-P2/B1` | Se cuantifica con cotizaciones reales en `A6` y `G3-P2/B1–B2` | Suscripción de contrato de **transmisión de datos** (Decreto 1074 de 2015, art. `2.2.2.25.5.2`) con el proveedor como Encargado, sin transferencia no autorizada. |

### Tabla de Sensibilidad de Cantidades según Variante (`Anexo A`)

| Parámetro / Componente dimensionado | Variante A (`60` u · `15` conc · `1` sede · `99,0 %`) | Variante B (`120` u · `30` conc · `2` sedes · `99,5 %`) | Variante C (`250` u · `60` conc · `3` sedes · `99,5 %`) | Variante D (`500` u · `120` conc · `4` sedes · `99,9 %`) |
| :--- | :---: | :---: | :---: | :---: |
| Instancias `Apache + PHP 8.3` (`N_web`) | `1` | `1` | `1` *(escalado vertical)* | `2` *(balanceo alta disponibilidad)* |
| Instancias `MariaDB 10.11` (`N_db`) | `1` | `1` | `1` | `2` *(primario + réplica)* |
| Certificados TLS (`Let's Encrypt`) | `1` | `1` | `1` | `1` *(wildcard / multi-SAN)* |
| Cuentas desarrollador (`GitHub` / `IDE`) | `2` | `2` | `2` | `2` |
| Costo total licencias software base (COP/año) | **`$0`** *(open source en producción)* | **`$0`** | **`$0`** | **`$0`** *(o `$384.000/año` si se activa GitHub Team)* |

---

## 2. Inventario de Dependencias del Código y Análisis de Compatibilidad (`6` Dependencias Verificadas)

Extraído directamente de `Dockerfile`, `docker-compose.yml`, `sesion.php`, `qr.php`, `e2e/package.json` y `e2e/package-lock.json` del código de `asistencia-sena`:

| # | Dependencia | Versión verificada | Archivo donde se declara | Uso en `asistencia-sena` | Licencia verificada | Alerta de compatibilidad y acción requerida |
| :- | :--- | :--- | :--- | :--- | :--- | :--- |
| **1** | **`php:8.3-apache`** *(PHP + PDO_MySQL)* | `8.3.x` | `Dockerfile` (L1–L3) | Runtime del servidor y acceso parametrizado a BD | **PHP License 3.01** *(permisiva)* | **Compatible (baja alerta):** mantener licencia; no usar "PHP" en el nombre comercial del producto. |
| **2** | **`Apache HTTP Server`** | `2.4.x` | `Dockerfile` (L1, L4) | Servidor web, `mod_rewrite`, `mod_headers`, blindaje `.htaccess` | **Apache License 2.0** *(permisiva con cláusula de patentes)* | **Compatible (baja alerta):** conservar avisos de licencia en imagen/documentación. |
| **3** | **`mariadb`** *(imagen oficial)* | `10.11` | `docker-compose.yml` (L3) | Motor relacional `InnoDB` para las 10 tablas 3FN | **GPL v2** *(copyleft fuerte)* | **Alerta media (copyleft controlado):** se ejecuta como contenedor/servicio aislado vía protocolo de red `TCP 3306`; el código PHP nunca enlaza bibliotecas GPL en binario único, por lo que **no obliga** a liberar `asistencia-sena` bajo GPL v2. |
| **4** | **`qrcodejs`** | `1.0.0` | `sesion.php` (L176) y `qr.php` (L73) | Generación de QR rotativo de sesión y credencial individual en navegador | **MIT License** *(permisiva)* | **Alerta media operativa (no legal):** licencia MIT 100 % compatible, pero actualmente se carga desde CDN externo (`cdn.jsdelivr.net`). **Acción:** descargar y alojar localmente en `assets/vendor/qrcode.min.js` conservando su cabecera MIT para eliminar dependencia de Internet en aula y evitar rastreo de terceros. |
| **5** | **`@playwright/test`** | `1.65.1` | `e2e/package.json` (L15) | Suite de pruebas automatizadas E2E (`01` a `06`), solo QA/desarrollo | **Apache-2.0** *(permisiva)* | **Compatible (sin impacto en producción):** dependencia `devDependencies`, excluida de la imagen de producción vía `.dockerignore` y bloqueada por `.htaccess`. |
| **6** | **`mysql2`** | `3.24.6` | `e2e/package.json` (L16) | Conector auxiliar Node.js para preparar/verificar BD en pruebas E2E | **MIT** *(permisiva)* | **Compatible (solo desarrollo/QA):** no se despliega en el contenedor de producción `sena-asistencias-web`. |

> **Nota sobre costo de reemplazo de componentes (`Rubricas_G3.md` Anexo D):** Si el contratante decidiera sustituir `qrcodejs` por generación de QR 100 % del lado servidor en PHP (`chillerlan/php-qrcode`, licencia MIT), el esfuerzo estimado sería de `6 horas × tarifa desarrollador` (se registrará en `A6` si aplica como opción). Actualmente basta con **auto-alojar `qrcode.min.js`** (`2 horas`, licencia MIT conservada, costo de licencia `$0`).

---

## 3. Decisión y Justificación de la Licencia del Software Propio (`asistencia-sena`)

### Decisión adoptada
**Licencia Propietaria / Privativa con Cesión Escrita de Derechos Patrimoniales al Cliente Contratante** *(bajo contrato de desarrollo a la medida, conservando los derechos morales de paternidad e integridad en cabeza del autor conforme a la Ley 23 de 1982 y la Decisión Andina 351 de 1993)*.

### Justificación técnica, legal y comercial
1. **Coherencia con una propuesta técnica comercial (`G3-P2/B2` y `B6`):** Al presentarse una propuesta económica con precio de venta y contrato de desarrollo de software a la medida para una institución educativa contratante, el cliente requiere exclusividad operativa sobre la solución entregada y claridad contractual sobre su titularidad patrimonial (exigida por escrito por la Ley 23 de 1982 y art. 28 de la Ley 1450 de 2011).
2. **Compatibilidad total con el inventario de dependencias:** Ninguna dependencia distribuida junto al código propio es copyleft (`PHP 3.01`, `Apache 2.0`, `MIT`), y `MariaDB 10.11` (`GPL v2`) opera desacoplada como servicio de base de datos sobre TCP. Por tanto, no existe impedimento legal para licenciar el código propio bajo contrato privativo.
3. **Alternativas evaluadas y descartadas:**
   - **GPL v3 (copyleft fuerte):** descartada porque obligaría al contratante a liberar el código fuente bajo la misma licencia ante cualquier distribución derivada, lo cual suele ser rechazado en términos de referencia institucionales.
   - **MIT (permisiva pública):** descartada para la versión contratada porque permitiría a terceros explotar comercialmente el sistema sin acuerdo con el cliente que financió su desarrollo *(se reserva únicamente si el proyecto se publicara posteriormente como iniciativa abierta académica previa autorización del titular patrimonial)*.
4. **Registro y protección:** Se recomienda registrar el código fuente y manuales ante la **Dirección Nacional de Derecho de Autor (DNDA)** (trámite gratuito en línea en Colombia) como respaldo probatorio de autoría y fecha de creación.

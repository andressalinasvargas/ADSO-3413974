# A4 · Dimensionamiento Parametrizado e Inventario Real de Licencias — Fotocopiadora SyP

> **Estado del escenario:** **Variante B provisional** (`120` usuarios activos mensuales, `30` usuarios concurrentes en pico, `2` sedes en Neiva —Sede Principal y Sede Comercial/Bodega—, disponibilidad objetivo `99,5 %`, tope presupuestal de referencia `$70.000.000 COP`). Los costos comerciales definitivos y la comparación entre proveedores se consolidarán en los entregables del Día 2 (`A5`, `A6`, `B1`–`B4`).

---

## 1. Matriz de escenarios parametrizados (`A` – `D`)

Para respaldar decisiones de escalabilidad sin atar la propuesta a una única configuración, se parametriza el dimensionamiento en cuatro escenarios progresivos:

| Parámetro operativo | Escenario A (Base local) | **Escenario B (Provisional seleccionado)** | Escenario C (Regional ampliado) | Escenario D (Alta disponibilidad) |
|---|---:|---:|---:|---:|
| **Usuarios activos / mes** | `40` | **`120`** | `400` | `1.200+` |
| **Concurrencia pico estimada** | `10` usuarios | **`30` usuarios** | `90` usuarios | `250` usuarios |
| **Sedes atendidas** | `1` sede | **`2` sedes** | `4` sedes | `8+` sedes |
| **Disponibilidad objetivo (`ANS-01`)** | `99,0 %` | **`99,5 %`** | `99,8 %` | `99,9 %` |
| **Objetivo de recuperación (`RPO` / `RTO`)** | `<= 24 h` / `<= 8 h` | **`<= 24 h` / `<= 2 h`** | `<= 6 h` / `<= 1 h` | `<= 15 min` / `<= 30 min` |
| **Topología de cómputo y BD** | Instancia única app + BD | **API Docker (`2` vCPU / `4 GB`) + PostgreSQL 16 privado + Respaldos S3 + Monitoreo `60 s`** | Clúster balanceado + BD con réplica de lectura | Multi-AZ activa + caché dedicada + failover automático |

---

## 2. Dimensionamiento técnico de los `8` componentes alineados a `[N1]`–`[N7]`

Los primeros `7` componentes corresponden exactamente 1:1 con los nodos `[N1]`–`[N7]` del diagrama de despliegue [`03-diagrama-arquitectura-despliegue-g3.svg`](../G3-P2-fotocopiadora-syp/03-diagrama-arquitectura-despliegue-g3.svg), más el entorno de calidad y automatización CI-CD:

| # | Nodo / Componente (`G3-P2`) | Especificación en **Escenario B (Provisional)** | Escalado en Escenarios A / C / D | Tipo de licenciamiento |
|---:|---|---|---|---|
| **1** | **`[N1]` Navegador Cliente PWA (`EXCLUIDO`)** | Equipos y móviles propios del comprador (`PWA + sw.js + fallback localStorage`), **presupuesto `$0`**. | Idéntico en A–D (hardware del visitante/cliente) | Estándar web abierto (sin licencia comercial) |
| **2** | **`[N2]` Estación Administrador (`EXCLUIDO`)** | PC actual del personal de SyP en Neiva (`admin.html`, exportación `ExportadorCsvSeguro`, reportes), **presupuesto `$0`**. | Idéntico en A–D (hardware existente en sedes SyP) | Navegador moderno + aplicación web propia |
| **3** | **`[N3]` Borde DNS + Proxy TLS 1.3** | Dominio `.com`/`.co` + CDN `HTTPS 443` + certificado `Let's Encrypt` + cabeceras `CSP`/`HSTS`. | A: TLS estándar \| C: WAF reglas OWASP \| D: WAF dedicado multi-región | Servicio DNS/Proxy gestionado + TLS abierto |
| **4** | **`[N4]` Servidor Aplicación API (`Docker`)** | VPS Linux (`2 vCPU`, `4 GB RAM`) ejecutando contenedor `FastAPI + Uvicorn + 9 Routers + BCrypt` y cookie `HttpOnly` `syp_session` (`N_srv` nodos según variante). | A: `1 vCPU`, `2 GB` \| C: `2` nodos balanceados \| D: autoescalado `4+` nodos | Código propio + stack `MIT` / `BSD-3-Clause` / `Apache-2.0` |
| **5** | **`[N5]` Servidor Base de Datos Privado** | `PostgreSQL 16` en red Docker privada (`TCP 5432` cerrado a Internet), `2 vCPU`, `4 GB RAM`, `80 GB SSD` cifrados en reposo, `12` tablas `3FN`. | A: `1 vCPU`, `2 GB`, `30 GB SSD` \| C: `4 vCPU`, `8 GB` + réplica \| D: Multi-AZ | Licencia PostgreSQL (permisiva, `$0` por núcleo) |
| **6** | **`[N6]` Respaldos Externos S3 Cifrados** | Almacenamiento de objetos S3 externo cifrado (`AES-256`), volcado diario `02:00 COT`, retención mínima `30` días (`RPO <= 24 h`). | A: `30 GB` \| C: `250 GB` \| D: `500 GB` con replicación geográfica | Pago por consumo / S3 estándar |
| **7** | **`[N7]` Monitoreo Externo y Alertas ANS** | Sondeo `HTTPS` continuo cada `60 s` (`ANS-01` / `ANS-02`) con alertas tempranas para incidentes críticos (`P1 <= 30 min`). | A: sondeo básico `5 min` \| C: métricas APM \| D: SIEM y soporte 24/7 | Servicio de monitoreo externo SaaS / abierto |
| **8** | **Entorno de Pruebas y CI-CD (`Dev/QA`)** | Pipeline automatizado con `node --check`, `pytest` + `httpx`, `Playwright` E2E y validación DDL `SQLite 3` / `PostgreSQL 16`. | Idéntico transversal para A–D | Herramientas abiertas (`MIT` / `BSD` / `Apache-2.0`) |

---

## 3. Inventario real verificado de dependencias del repositorio `Fotocopiadora-SyP-main`

Inventario comprobado directamente sobre los manifiestos reales del proyecto ([`fastapi_backend/requirements.txt`](../../../../../../../Fotocopiadora-SyP-main/fastapi_backend/requirements.txt), [`requirements-dev.txt`](../../../../../../../Fotocopiadora-SyP-main/requirements-dev.txt) y [`package.json`](../../../../../../../Fotocopiadora-SyP-main/package.json)):

### 3.1 Dependencias de producción Backend (`fastapi_backend/requirements.txt` — `8` paquetes)

| Paquete | Versión fijada | Rol en Fotocopiadora SyP | Licencia OSI | Compatibilidad con software propietario |
|---|---:|---|---|---|
| `fastapi` | `0.115.14` | Framework ASGI REST y contratos OpenAPI | `MIT` | Compatible sin copyleft |
| `starlette` | `0.46.2` | Enrutamiento ASGI, middlewares y respuestas HTTP | `BSD-3-Clause` | Compatible sin copyleft |
| `uvicorn` | `0.54.0` | Servidor ASGI de producción | `BSD-3-Clause` | Compatible sin copyleft |
| `pydantic` | `2.14.4` | Validación estricta de esquemas y serialización | `MIT` | Compatible sin copyleft |
| `email-validator` | `2.4.0` | Validación sintáctica de correos en registro/contacto | `Unlicense` | Dominio público / compatible |
| `pyjwt` | `2.15.1` | Emisión y verificación de tokens JWT (`syp_session`) | `MIT` | Compatible sin copyleft |
| `bcrypt` | `5.0.0` | Hashing adaptativo con sal (`POL-CON-01` / `RNF-05`) | `Apache-2.0` | Compatible sin copyleft |
| `python-multipart` | `0.0.34` | Procesamiento de formularios multipart/archivos | `Apache-2.0` | Compatible sin copyleft |

### 3.2 Dependencias de pruebas y automatización (`requirements-dev.txt` — `3` paquetes adicionales)

| Paquete | Versión fijada | Uso exclusivo en calidad y pruebas | Licencia OSI | Observación |
|---|---:|---|---|---|
| `pytest` | `9.2.0` | Suite de pruebas unitarias e integración backend | `MIT` | No se empaqueta en runtime de cliente |
| `httpx` | `0.28.1` | Cliente HTTP para pruebas de endpoints FastAPI | `BSD-3-Clause` | No se empaqueta en runtime de cliente |
| `playwright` | `1.65.2` | Pruebas automatizadas E2E y renderizado de navegador | `Apache-2.0` | Solo entorno QA/CI |

### 3.3 Runtime y tooling Frontend (`package.json` — `fotocopiadora-syp` v`2.0.0`)

- **Arquitectura Frontend real:** HTML5 + CSS3 + JavaScript modular nativo sin bundler ni dependencias npm de producción externas (`0` paquetes npm de terceros en ejecución), con soporte objetivo declarado en `browserslist`: `> 0.5% in CO`, `Chrome >= 90`, `Safari >= 14`, `Firefox >= 90` y `engines.node >= 18`.
- **Verificación automatizada:** script `npm run check` (`node --check` sobre `js/config.js`, `js/products.js`, `js/auth.js`, `js/services.js`, `js/interactions.js`, `sw.js` y módulos en `js/app/`).

---

## 4. Estrategia de licenciamiento y propiedad intelectual del software

1. **Software desarrollado a la medida (código fuente, SQL, vistas y documentación):** Licenciamiento **propietario exclusivo** a favor de **Fotocopiadora SyP**, instrumentado mediante **cesión escrita de derechos patrimoniales** conforme a la **Ley 23 de 1982** y la **Decisión Andina 351 de 1993**, conservando el equipo desarrollador los derechos morales irrenunciables de autoría.
2. **Higiene de licencias de terceros:** El `100 %` de los `11` paquetes Python inventariados (`8` de producción y `3` de QA) utilizan licencias permisivas (`MIT`, `BSD-3-Clause`, `Apache-2.0`, `Unlicense`), garantizando **cero contaminación copyleft (`GPL`/`AGPL`)** y permitiendo distribuir o alojar el sistema propietario con total seguridad jurídica, manteniendo únicamente la atribución de avisos de copyright (`NOTICE` / licencias) exigida por Apache-2.0/MIT/BSD.

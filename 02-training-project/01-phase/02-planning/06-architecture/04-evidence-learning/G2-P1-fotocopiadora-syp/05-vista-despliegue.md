# A6 · Vista de Despliegue (`5` Nodos — `Fotocopiadora SyP`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Fuente editable:** [05-vista-despliegue.drawio](05-vista-despliegue.drawio) · **Imagen exportada:** [05-vista-despliegue.svg](05-vista-despliegue.svg)

---

## 1. Catálogo de Nodos, Artefactos y Protocolos

| ID | Nodo de despliegue | Artefactos alojados | Conexión y protocolo | Decisiones que atienden `RNF` |
| :- | :--- | :--- | :--- | :--- |
| **`N1`** | **`NavegadorClientePWA`** *(Dispositivo móvil/PC del visitante o cliente)* | HTML/CSS/JS empacados en `dist/`, imágenes `WebP`, `sw.js` y respaldo en `localStorage` | `HTTPS 443 (TLS 1.3)` hacia `N3` | Atiende `RNF-02` (`≥ 320 px`), `RNF-04` (`WebP` + `lazy`) y `RNF-06` (modo estático sin bloqueo). |
| **`N2`** | **`EstacionAdministrador`** *(PC administrativo en Neiva)* | `admin.html`, `login.html`, exportaciones CSV descargadas bajo demanda | `HTTPS 443 (TLS 1.3)` hacia `N3` | Opera exclusivamente con cookie `HttpOnly` (`RNF-05`) y saneamiento de CSV (`RF-11`). |
| **`N3`** | **`BordeEstaticoRenderCDN`** *(CDN / Proxy Inverso TLS)* | Distribución estática `dist/` (oculta backend/documentación), reglas `CSP`/`HSTS`/`X-Frame-Options` | Recibe `HTTPS 443`; enruta llamadas REST hacia `N4` por canal cifrado | Resuelve `RNF-04` (caché CDN de activos) y `RNF-05` (superficie de exposición mínima: en estático no filtra docs ni endpoints). |
| **`N4`** | **`ServidorAPIFastAPIDocker`** *(Contenedor Docker Python 3.12 + Uvicorn)* | `fastapi_backend` (`main.py`, `core.py`, `schemas.py`, `9` routers), lógica hexagonal y `BCrypt`/`PyJWT` | Recibe tráfico API de `N3`; conecta con `N5` por **`TCP 5432` privado** | Aísla lógica y sesiones `HttpOnly` (`RNF-05`), valida esquemas Pydantic y habilita pruebas E2E portables (`RNF-08`). |
| **`N5`** | **`MotorRelacionalPostgreSQL`** *(Motor PostgreSQL 16 en prod / SQLite 3 en QA)* | `12` tablas normalizadas en 3FN, índices, llaves foráneas `ON DELETE` y volcados periódicos | Escucha **solo en red privada `TCP 5432`** (puerto cerrado a Internet) | Impide exposición directa de datos personales (`RNF-05`) y asegura atomicidad en pedidos y contadores (`RF-05`, `RF-10`). |

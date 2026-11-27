# A4 · Arquitectura del Software (Estilo Hexagonal / Puertos y Adaptadores)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Fuente editable:** [03-arquitectura-software.drawio](03-arquitectura-software.drawio) · **Imagen exportada:** [03-arquitectura-software.svg](03-arquitectura-software.svg)

---

## 1. Estilo Arquitectónico Definido y Reglas de Comunicación

Se adopta el estilo de **Arquitectura Hexagonal (Puertos y Adaptadores)** dividido en tres anillos concéntricos sin saltos:

1. **Adaptadores Primarios (Entrada):**
   - `PWA Web Pública` (`index.html`, `productos.html`, `cotizacion.html`, `servicio-tecnico.html`, `contacto.html`) y `Panel Admin SPA` (`admin.html`, `login.html`).
   - Se comunican por **`HTTPS/JSON`** únicamente con los **Puertos de Entrada (Routers FastAPI + esquemas Pydantic + JWT `HttpOnly`)**; nunca acceden directo al motor SQL ni contienen reglas de cálculo definitivas.
2. **Núcleo de Dominio y Aplicación (Centro):**
   - Agrupa entidades (`Persona`, `Pedido`, `Cotizacion`, `SolicitudServicio`, `ReporteContador`), comandos GoF (`IComandoOperacion`) y fábricas (`IFabricaEntregaComercial`).
   - Recalcula precios, IVA (`19 %`), disponibilidad (`stock_status`) y enmascaramiento de PII (`is_owner`) de manera **independiente de la base de datos o framework HTTP**.
3. **Puertos de Salida e Adaptadores Secundarios:**
   - El dominio define interfaces (`IRepositorioComercial`, `IExportadorCsvSeguro`, `ICanalMensajeria`).
   - Los adaptadores secundarios (`SQLAlchemy/PostgreSQL`, `Exportador CSV anti-fórmulas`, `WhatsApp + respaldo localStorage`) implementan dichas interfaces sin acoplar el núcleo de negocio.

---

## 2. Decisiones Arquitectónicas frente a los `8` RNF (`RNF-01`–`RNF-08`)

| ID RNF | Categoría | Decisión arquitectónica adoptada | Cómo garantiza el cumplimiento |
| :--- | :--- | :--- | :--- |
| **`RNF-01`** | Usabilidad | Adaptadores primarios separados por rol (`WebCatalogoPWA` vs. `PanelAdminWeb`) con menú jerárquico de 6 categorías | Reduce fricción de navegación (`≤ 3` clics) y mantiene el flujo de invitado separado de la administración. |
| **`RNF-02`** | Responsividad | Sistema CSS con rejillas adaptables y puntos de quiebre uniformes (`320 px` a escritorio) en los adaptadores HTML | Evita desbordamiento horizontal y asegura controles táctiles de `24–44 px` en móviles. |
| **`RNF-03`** | Accesibilidad | Validadores semánticos, tokens de contraste `≥ 4.5:1` y gestión centralizada de foco en adaptadores UI | Garantiza operación por teclado (`radiogroup`, `Escape`) en modos claro y oscuro. |
| **`RNF-04`** | Rendimiento | Separación del borde estático (`dist/` + imágenes `WebP` + `sw.js`) frente a endpoints REST ligeros sin estado | Disminuye peso de transferencia (`6,5 MB → 0,77 MB` en galería) y desacopla descargas estáticas de la API. |
| **`RNF-05`** | Seguridad y privacidad | Validación obligatoria en puertos de entrada (`Pydantic`, `BCrypt`, cookie `HttpOnly` `syp_session`, rate limiting, `is_owner`) | Impide enumeración de datos en cotizaciones/pedidos y frena inyecciones o abuso antes de alcanzar el dominio. |
| **`RNF-06`** | Disponibilidad y contingencia | Desacoplamiento por puertos que habilita respaldo en `localStorage` + adaptador WhatsApp cuando la API no responde | Mantiene cotizaciones y catálogo operativos en despliegue estático (`dist/`) sin bloquear al visitante. |
| **`RNF-07`** | Localización y formatos | Formateo monetario `COP` y fechas `es-CO` encapsulados en utilidades compartidas de dominio/presentación | Uniformidad entre comprobantes web, impresión y tablas administrativas. |
| **`RNF-08`** | Mantenibilidad y verificación | Reglas de negocio aisladas del transporte y la BD tras interfaces (`IRepositorioComercial`, `IComandoOperacion`) | Permite ejecutar `pytest` sobre routers y comandos con BD aislada y pruebas E2E Playwright sin mocks invasivos. |

---

## 3. Alternativas Arquitectónicas Descartadas

1. **Monolito acoplado sin puertos (lógica SQL directamente en vistas/rutas HTTP — descartado):**
   - **Por qué se descarta:** Mezclar consultas SQL crudas y validaciones de negocio dentro de los controladores HTTP impide reutilizar reglas entre pedidos, cotizaciones y exportaciones, viola la cohesión y dificulta las pruebas unitarias aisladas (`RNF-08`).
2. **Microservicios distribuidos por entidad (catálogo, pedidos, servicio y notificaciones en servicios separados — descartado):**
   - **Por qué se descarta:** Para un equipo pequeño (`2` desarrolladores) y un volumen comercial de negocio local, dividir en `4–5` servicios con mensajería distribuida introduce latencia innecesaria, consistencia eventual en stock/pedidos y costos de infraestructura que superan la necesidad real del caso.

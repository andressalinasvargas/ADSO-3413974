# A1 · Formato Estandarizado de Ficha Técnica de Software — Fotocopiadora SyP

> **Propósito:** Establecer una plantilla estandarizada y agnóstica de proveedor para especificar técnicamente los módulos, artefactos e infraestructura del sistema **Fotocopiadora SyP** (comercio electrónico de equipos multifuncionales/insumos y gestión de servicio técnico con reporte mensual de contadores), alineada con **ISO/IEC/IEEE 29148:2018** e **ISO/IEC 25010:2023**.

---

## 1. Marco metodológico y neutralidad tecnológica

- **Norma de ingeniería de requisitos:** `ISO/IEC/IEEE 29148:2018` (completitud, consistencia, verificabilidad y trazabilidad bidireccional).
- **Norma de calidad de producto:** `ISO/IEC 25010:2023` (adecuación funcional, eficiencia de desempeño, compatibilidad, capacidad de interacción, fiabilidad, seguridad, mantenibilidad y flexibilidad).
- **Principio de neutralidad:** Los campos describen capacidades técnicas, protocolos abiertos (`HTTPS TLS 1.3`, `REST/JSON`, `SQL estándar`, `HTML5/CSS3/ES`, `UTF-8`) y métricas objetivas sin imponer atadura comercial a un único proveedor de nube o fabricante de hardware.
- **Trazabilidad del proyecto:**
  - Origen funcional y no funcional (`G1-P1`): [`00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) (`12 RF` `RF-01`–`RF-12`, `8 RNF` `RNF-01`–`RNF-08`, `5` actores).
  - Origen arquitectónico (`G2-P1`): [Arquitectura Hexagonal y vistas](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/03-arquitectura-software.md) (`24` elementos OO, patrones **Comando** y **Fábrica Abstracta**, `7` componentes y `5` nodos).
  - Origen de persistencia (`G2-P2`): [Modelo lógico y DDL verificado](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/02-modelo-logico-y-transformacion.md) (`12` tablas en `3FN`).

---

## 2. Formato estandarizado de Ficha Técnica (`15` campos obligatorios)

| # | Campo estándar | Descripción e instrucciones de diligenciamiento | Regla de validación / evidencia |
|---:|---|---|---|
| **1** | **Código y nombre del módulo** | Identificador único (`FT-SYP-XXX`) y nombre funcional del componente o artefacto. | Nomenclatura consistente con `G2-P1` y `G3`. |
| **2** | **Versión, fecha y estado** | Número semántico (`vX.Y`), fecha ISO (`AAAA-MM-DD`) y estado (`Borrador`, `En validación`, `Aprobado`). | Control de cambios registrado en el campo 15. |
| **3** | **Responsable técnico / rol** | Rol responsable del diseño, mantenimiento y verificación del componente (sin exponer PII). | Trazable a roles del proyecto ADSO. |
| **4** | **Propósito y alcance funcional** | Objetivo operativo del componente dentro de Fotocopiadora SyP y límites de responsabilidad. | Debe corresponder a un puerto o adaptador definido en `G2-P1`. |
| **5** | **Trazabilidad de requisitos (RF / RNF)** | Lista explícita de códigos `RF-01`..`RF-12` y `RNF-01`..`RNF-08` atendidos por el módulo. | Cobertura verificable contra `00-insumo-srs-base.md`. |
| **6** | **Actores y permisos de acceso** | Actores autorizados (`Visitante`, `Cliente Registrado`, `Administrador`, `Pasarela de Pagos`, `Servicio de Mensajería`) y alcance CRUD/RBAC. | Alineado con políticas `GOB-SYP-01..04`. |
| **7** | **Interfaces de entrada y salida (API / UI)** | Contratos de entrada/salida, códigos HTTP (`200`, `201`, `400`, `401`, `403`, `404`, `422`), payloads JSON y formatos documentales (`PDF`, `CSV`). | Sin dependencias exclusivas de cliente propietario. |
| **8** | **Modelo de datos y persistencia** | Tablas involucradas del esquema de `12` tablas (`G2-P2`), llaves primarias/foráneas y reglas de integridad. | Verificable mediante DDL y pruebas negativas SQL. |
| **9** | **Patrón de diseño y estilo arquitectónico** | Ubicación en la Arquitectura Hexagonal (núcleo de dominio, puerto de entrada/salida o adaptador) y patrón OO aplicado (**Comando** / **Fábrica Abstracta**). | Coherencia exacta con `02-diagrama-clases.svg` y `03-arquitectura-software.svg`. |
| **10** | **Dimensionamiento y capacidad (Escenario B provisional)** | Concurrencia esperada (`30` usuarios concurrentes / `120` usuarios activos mensuales / `2` sedes), volumen de datos y cotas de latencia. | Parametrizado para ajuste en `A4` y `G3-P2`. |
| **11** | **Atributos de calidad (ISO/IEC 25010:2023)** | Métricas objetivo de desempeño (`p95 <= 1,5 s`), disponibilidad (`99,5 %` escenario B), usabilidad (`WCAG 2.2 AA`) y mantenibilidad. | Medible por pruebas automatizadas y monitoreo. |
| **12** | **Controles de seguridad y privacidad** | Cifrado en tránsito (`TLS 1.3`), hash de credenciales (`bcrypt`), autenticación (`JWT`), validación de entradas y tratamiento de datos (`Ley 1581/2012`). | Mapeado a OWASP ASVS y `06-politicas-seguridad-datos.md`. |
| **13** | **Dependencias técnicas y licenciamiento** | Módulos/bibliotecas requeridas con licencia abierta permisiva (`MIT`, `BSD-3-Clause`, `Apache-2.0`) o protocolo estándar, sin vendor lock-in. | Sin licencias copyleft que restrinjan la cesión patrimonial. |
| **14** | **Criterios de aceptación y pruebas** | Casos de prueba unitarios, de integración o SQL (`pytest`, Playwright, SQLite/PostgreSQL) con umbral mínimo de aprobación. | Evidencia reproducible antes de paso a producción. |
| **15** | **Historial de revisiones y vigencia** | Registro cronológico de ajustes (`Versión`, `Fecha`, `Motivo del cambio`, `Validación aplicada`). | Requerido antes de cierre de fase o firma de contrato. |

---

## 3. Mapa de aplicación del formato a los módulos de Fotocopiadora SyP

Como referencia para el diligenciamiento completo de las fichas operativas (programado para el **Día 2** en `02-fichas-tecnicas-aplicacion.md`), los cuatro bloques del sistema se estructuran así:

| Código de ficha | Módulo del sistema | Requisitos trazados (`G1-P1`) | Tablas principales (`G2-P2`) | Patrón / puerto (`G2-P1`) |
|---|---|---|---|---|
| `FT-SYP-001` | **Catálogo, Compatibilidad y Carrito** | `RF-01`, `RF-02`, `RF-03`, `RNF-01`, `RNF-05` | `categoria`, `producto`, `compatibilidad_producto` | Puerto `PuertoCatalogoProductos` + `AdaptadorRepositorioPg` |
| `FT-SYP-002` | **Pedidos, Pagos y Cotizaciones PDF** | `RF-04`, `RF-05`, `RF-06`, `RF-07`, `RNF-02`, `RNF-06` | `pedido`, `detalle_pedido`, `cotizacion`, `detalle_cotizacion` | Patrón **Comando** (`ComandoCrearPedido`, `ComandoGenerarCotizacion`) + **Fábrica Abstracta** (`FabricaDocumentoPdf`) |
| `FT-SYP-003` | **Servicio Técnico, Contadores y Contacto** | `RF-08`, `RF-09`, `RF-10`, `RF-11`, `RNF-03`, `RNF-04` | `solicitud_servicio`, `reporte_contador`, `mensaje_contacto` | Puerto `PuertoServicioTecnico` + `ComandoRegistrarContador` |
| `FT-SYP-004` | **Identidad, Seguridad, Notificaciones y Despliegue** | `RF-12`, `RNF-02`, `RNF-07`, `RNF-08` | `usuario`, `notificacion` | Puerto `PuertoNotificaciones` + `PuertoAutenticacionJwt` |

---

## 4. Control de versión del documento

| Versión | Fecha | Descripción | Autor / Rol |
|---|---|---|---|
| `v1.0` | `2026-11-27` | Creación inicial del formato estandarizado `A1` (`15` campos) para `Fotocopiadora SyP`, neutral en marca y trazado a `G1` y `G2`. | `@andressalinasvargas` |

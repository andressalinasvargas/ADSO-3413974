# Matriz Requisito Funcional → Caso de Uso · Fotocopiadora SyP

Esta matriz verifica la cobertura completa entre los requisitos funcionales consolidados en [00-insumo-srs-base.md](00-insumo-srs-base.md) y los casos de uso modelados en [03-diagrama-casos-uso.svg](03-diagrama-casos-uso.svg), manteniendo separados explícitamente los requisitos no funcionales (`C3` de `Rubricas_G1.md`).

---

## 1. Cobertura Directa `RF → Caso de Uso` (`12 / 12 = 100 %`)

| ID RF | Requisito funcional | Caso(s) de uso que lo cubren | Estado | Justificación / Observación |
|---|---|---|---|---|
| `RF-01` | Visualizar inicio y propuesta de valor | `CU-01` Consultar inicio y catálogo de productos | Cubierto | Presenta portada, categorías destacadas, servicios y acceso inmediato al catálogo. |
| `RF-02` | Explorar catálogo, filtrar y comparar | `CU-01` Consultar inicio y catálogo de productos | Cubierto | Integra filtros por categoría, búsqueda en vivo, paginación de 12 en 12 y comparador de equipos. |
| `RF-03` | Consultar ficha y compatibilidades | `CU-01` Consultar inicio y catálogo de productos | Cubierto | La vista rápida del catálogo expone ficha técnica, stock y productos compatibles. |
| `RF-04` | Gestionar carrito de compras persistente | `CU-02` Gestionar carrito de compras | Cubierto | Gestiona altas, cambios de cantidad, eliminación y cálculo de totales persistentes. |
| `RF-05` | Confirmar pedido de compra | `CU-03` Confirmar pedido de compra, `CU-05` Consultar documento comercial | Cubierto | Captura envío/pago, impide doble envío y emite comprobante consultable. |
| `RF-06` | Generar y consultar cotización formal | `CU-04` Generar cotización formal, `CU-05` Consultar documento comercial | Cubierto | Emite código único desde el carrito o cotizador y abre el visor imprimible con control de privacidad. |
| `RF-07` | Gestionar cuenta de usuario e historial | `CU-06` Autenticar cuenta de usuario, `CU-07` Gestionar perfil e historial comercial | Cubierto | Separa la autenticación/registro (`CU-06`) de la consulta del historial personal (`CU-07`). |
| `RF-08` | Enviar consulta por canal de contacto | `CU-08` Enviar consulta de contacto | Cubierto | Cubre mapa de ubicación, canales directos y formulario con confirmación. |
| `RF-09` | Solicitar servicio técnico y diagnóstico | `CU-09` Solicitar servicio técnico y diagnóstico | Cubierto | Agrupa diagnóstico de códigos/atascos, calculadora renting, cobertura y agendamiento técnico. |
| `RF-10` | Reportar contadores de renting | `CU-10` Reportar contadores de renting *(incluye `CU-06`)* | Cubierto | Registra lecturas periódicas B/N y color previa autenticación del titular. |
| `RF-11` | Administrar catálogo y operaciones | `CU-11` Administrar catálogo y operaciones comerciales | Cubierto | Centraliza catálogo, estados operativos, analítica y exportación segura de reportes. |
| `RF-12` | Gestionar notificaciones de estado | `CU-12` Gestionar notificaciones de estado | Cubierto | Permite listar avisos de pedidos/citas y marcarlos como leídos para cliente y administrador. |

- **Total de requisitos funcionales del SRS:** `12`
- **Requisitos cubiertos por al menos un caso de uso:** `12` (`100 %`, supera el mínimo exigible de `90 %`).
- **Requisitos funcionales no cubiertos:** `0`.

---

## 2. Auditoría Inversa `Caso de Uso → RF` (`12 / 12 = 100 %`)

| Caso de uso | Requisitos funcionales que atiende | ¿Caso huérfano? |
|---|---|---|
| `CU-01` Consultar inicio y catálogo de productos | `RF-01`, `RF-02`, `RF-03` | No |
| `CU-02` Gestionar carrito de compras | `RF-04` | No |
| `CU-03` Confirmar pedido de compra | `RF-05` | No |
| `CU-04` Generar cotización formal | `RF-06` | No |
| `CU-05` Consultar documento comercial | `RF-05`, `RF-06` | No |
| `CU-06` Autenticar cuenta de usuario | `RF-07`, `RF-10` *(vía `«include»`)* | No |
| `CU-07` Gestionar perfil e historial comercial | `RF-07` | No |
| `CU-08` Enviar consulta de contacto | `RF-08` | No |
| `CU-09` Solicitar servicio técnico y diagnóstico | `RF-09` | No |
| `CU-10` Reportar contadores de renting | `RF-10` | No |
| `CU-11` Administrar catálogo y operaciones comerciales | `RF-11` | No |
| `CU-12` Gestionar notificaciones de estado | `RF-12` | No |

---

## 3. Distinción Explícita de Requisitos No Funcionales (`RNF`)

Los requisitos `RNF-01` a `RNF-08` (usabilidad, responsividad desde 320 px, accesibilidad WCAG 2.2 AA, rendimiento WebP/caché, seguridad/privacidad, contingencia sin conexión, localización COP y verificabilidad automatizada) **no aparecen como óvalos de caso de uso**, pues restringen transversalmente cómo deben operar los casos `CU-01` a `CU-12` y se documentan en sus reglas de negocio, criterios de diseño y listas de validación en `G1-P2-fotocopiadora-syp/`.

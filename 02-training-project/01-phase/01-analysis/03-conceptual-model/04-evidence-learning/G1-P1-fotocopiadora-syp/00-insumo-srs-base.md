# Insumo SRS Consolidado · Fotocopiadora SyP

## 1. Propósito y Contexto del Caso

**Fotocopiadora SyP** es una plataforma de comercio electrónico y gestión de servicio técnico enfocada en la comercialización de fotocopiadoras multifuncionales, impresoras, insumos de impresión (tóners, tintas), repuestos y prestación de mantenimiento preventivo/correctivo y planes de renting en Neiva, Huila.

Este insumo consolida las necesidades identificadas en la especificación de requisitos del equipo (**Equipo Fotocopiadora SyP**, versión consolidada v2.0), separando con precisión los **requisitos funcionales (`RF`)** de los **requisitos no funcionales (`RNF`)** y eliminando duplicidades o detalles de implementación tecnológica antes de pasar al modelado conceptual.

---

## 2. Requisitos Funcionales Consolidados (`RF-01` a `RF-12`)

| ID | Nombre corto | Descripción funcional verificable |
|---|---|---|
| `RF-01` | Visualizar inicio y propuesta de valor | El sistema debe mostrar una portada con carrusel informativo, accesos directos por categoría, resumen de servicios técnicos/renting y buscador rápido hacia el catálogo. |
| `RF-02` | Explorar catálogo, filtrar y comparar | El sistema debe listar los productos activos con paginación de 12 elementos, permitir filtrar por categoría, buscar por palabra clave en vivo y comparar especificaciones lado a lado. |
| `RF-03` | Consultar ficha y compatibilidades | El sistema debe mostrar la vista detallada de cada producto con precio en COP, estado de disponibilidad, especificaciones clave y listado de insumos o equipos compatibles. |
| `RF-04` | Gestionar carrito de compras persistente | El sistema debe permitir agregar productos disponibles, modificar cantidades (>= 1), eliminar artículos, conservar el carrito entre visitas y recalcular subtotal, IVA y total en tiempo real. |
| `RF-05` | Confirmar pedido de compra | El sistema debe capturar datos de entrega y facturación, ofrecer métodos de pago (en línea o coordinación comercial), impedir envíos duplicados, validar precios/existencias y emitir comprobante único. |
| `RF-06` | Generar y consultar cotización formal | El sistema debe permitir generar una cotización formal con código único desde los artículos seleccionados, mostrar el formato imprimible y ocultar datos personales sensibles a visitantes que no sean titulares ni administradores. |
| `RF-07` | Gestionar cuenta de usuario e historial | El sistema debe permitir el registro de nuevos clientes con contraseña segura, inicio y cierre de sesión, y consulta del historial propio de pedidos, cotizaciones y solicitudes. |
| `RF-08` | Enviar consulta por canal de contacto | El sistema debe ofrecer datos de atención, ubicación geográfica en mapa, acceso directo a mensajería instantánea y formulario de contacto con confirmación de envío. |
| `RF-09` | Solicitar servicio técnico y diagnóstico | El sistema debe permitir registrar solicitudes de mantenimiento preventivo o correctivo y brindar herramientas de consulta de códigos de error, diagnóstico de atascos, cobertura y simulador de renting. |
| `RF-10` | Reportar contadores de renting | El sistema debe permitir a los clientes autenticados registrar mensualmente los contadores de páginas en blanco y negro y color por equipo asignado. |
| `RF-11` | Administrar catálogo y operaciones | El sistema debe restringir al administrador un panel de gestión para consultar analíticas, administrar productos, actualizar estados de pedidos y solicitudes, revisar contactos/contadores y exportar listados seguros. |
| `RF-12` | Gestionar notificaciones de estado | El sistema debe notificar al cliente y al administrador sobre nuevos pedidos, citas técnicas o cambios de estado, permitiendo consultar la bandeja y marcar avisos como leídos. |

---

## 3. Requisitos No Funcionales Consolidados (`RNF-01` a `RNF-08`)

Los requisitos no funcionales definen atributos de calidad y restricciones transversales del sistema. **No se modelan como casos de uso** porque no representan metas interactivas independientes de un actor sino propiedades que deben cumplir todas las funciones:

| ID | Categoría | Requisito no funcional |
|---|---|---|
| `RNF-01` | Usabilidad | Navegación intuitiva que permita ubicar cualquier categoría o producto en un máximo de 3 interacciones desde el inicio, con encabezados jerárquicos claros. |
| `RNF-02` | Responsividad | Adaptación fluida sin desbordamiento horizontal desde 320 px (móvil) hasta escritorio, con controles táctiles mínimos de 24 a 44 px. |
| `RNF-03` | Accesibilidad | Cumplimiento de contraste mínimo 4.5:1 en modos claro y oscuro, foco visible de teclado, trampas de foco en modales, atajo `Escape` y textos alternativos en imágenes. |
| `RNF-04` | Rendimiento | Imágenes optimizadas de carga rápida con descarga diferida en catálogo, caché inteligente sin conexión y respuestas con compresión de carga. |
| `RNF-05` | Seguridad y privacidad | Almacenamiento protegido de credenciales, acceso basado en roles, control de intentos en autenticación, protección ante abuso automatizado y enmascaramiento de datos personales ante terceros. |
| `RNF-06` | Disponibilidad y contingencia | Operación continua con respaldo de catálogo estático y canal alternativo de atención cuando la conectividad comercial no esté disponible. |
| `RNF-07` | Localización y formatos | Interfaz en español (`es-CO`), precios expresados en pesos colombianos (COP) y fechas en formato colombiano. |
| `RNF-08` | Mantenibilidad y verificación | Estructura modular acompañada de pruebas automatizadas de extremo a extremo y regresión crítica antes de cada entrega. |

---

## 4. Actores Identificados para el Análisis

| Actor | Tipo | Responsabilidad principal |
|---|---|---|
| `Visitante` | Primario | Explora catálogo, compara equipos, arma carrito, envía contacto, solicita servicio técnico, genera cotización o compra como invitado. |
| `Cliente Registrado` | Primario (especialización de `Visitante`) | Conserva las acciones de visitante y además consulta su historial comercial, reporta contadores mensuales de renting y revisa sus notificaciones. |
| `Administrador` | Primario | Gestiona catálogo, inventario, pedidos, cotizaciones, solicitudes técnicas, contadores, analítica comercial y exportación de reportes. |
| `Pasarela de Pagos` | Secundario | Procesa la autorización del pago en línea durante la confirmación de pedidos. |
| `Servicio de Mensajería` | Secundario | Canal externo mediante el cual se canalizan avisos comerciales o confirmaciones directas con el negocio. |

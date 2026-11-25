# Caracterización de la Solución y Selección de Metodología · Fotocopiadora SyP

## 1. Caracterización de la Solución (4 Aspectos Obligatorios)

De acuerdo con la revisión de [00-insumo-srs-base.md](00-insumo-srs-base.md) y la estructura actual de la plataforma **Fotocopiadora SyP**, se caracterizan los cuatro aspectos fundamentales del proyecto:

| Aspecto | Valor en el proyecto | Implicación para el análisis y desarrollo |
|---|---|---|
| **1. Tipo de proyecto** | Plataforma web híbrida de comercio electrónico B2C/B2B, cotización formal imprimible, autodiagnóstico técnico y panel administrativo comercial. | Combina reglas de carrito/pedidos en tiempo real con flujos administrativos, validación documental y respaldo estático resiliente. |
| **2. Tamaño del equipo** | Equipo pequeño (2 integrantes base: Equipo Fotocopiadora SyP), con ajuste individual de análisis en esta entrega (`@andressalinasvargas`). | Requiere una metodología ligera con entregas incrementales frecuentes, mínima burocracia documental y control continuo por iteraciones cortas. |
| **3. Estabilidad de requisitos** | Estabilidad **media-alta** en el núcleo transaccional (catálogo, carrito, pedidos) y **evolutiva** en herramientas técnicas, accesibilidad, caché sin conexión y visualización de datos. | Se beneficia de ciclos cortos donde las mejoras de experiencia, seguridad y accesibilidad puedan validarse e integrarse sin rehacer toda la especificación. |
| **4. Disponibilidad del cliente** | Alta disponibilidad mediante canal directo con la propietaria/administración del negocio y validaciones continuas de interfaz, catálogo y flujos de atención. | Permite demostraciones tempranas de prototipos, revisión directa de catálogos/cotizaciones y retroalimentación rápida entre iteraciones. |

---

## 2. Comparación de Metodologías de Desarrollo

Para comparar objetivamente cuatro metodologías reconocidas (**Scrum**, **RUP**, **XP** y **RAD**), se emplean **5 criterios** derivados directamente de las cuatro características anteriores:

| Criterio (derivado de la caracterización) | Scrum | RUP | XP (Extreme Programming) | RAD |
|---|---|---|---|---|
| **1. Adecuación a equipo pequeño (2 personas)** | **Alta**: roles ligeros y ciclos semanales sin sobrecarga burocrática. | **Baja**: exige múltiples artefactos y roles formales excesivos para 2 personas. | **Media-Alta**: pensada para equipos chicos, aunque exige programación en pareja estricta en sitio. | **Media**: se enfoca en prototipado rápido, menos estructurado en gestión de pendientes. |
| **2. Manejo de requisitos evolutivos** | **Alta**: lista priorizada (*Product Backlog*) que absorbe mejoras por sprint (ej. diagnóstico SC, renting, accesibilidad). | **Media**: soporta cambios entre fases, pero requiere replanificar artefactos pesados. | **Alta**: adapta cambios dentro de iteraciones cortas mediante pruebas continuas. | **Media-Alta**: acepta ajustes sobre prototipos visuales, aunque puede descuidar reglas de negocio. |
| **3. Aprovechamiento de alta disponibilidad del cliente** | **Alta**: revisión formal al final de cada sprint con validación directa de incremento funcional. | **Media**: concentra la validación en hitos de fase más espaciados. | **Alta**: propone cliente en sitio permanente (difícil de cumplir 100 % con comercio activo). | **Alta**: involucra al usuario desde prototipos tempranos de interfaz. |
| **4. Soporte a entrega web híbrida (tienda + taller + admin)** | **Alta**: permite dividir por módulos funcionales priorizados (catálogo, checkout, soporte, admin) con valor desde la primera entrega. | **Alta**: disciplina arquitectónica sólida en capas y casos de uso formales. | **Media**: prioriza código sobre modelado visual de procesos multi-actor. | **Media**: fuerte en pantallas rápidas, débil en consistencia de inventario, precios y seguridad. |
| **5. Trazabilidad y verificación antes de cerrar entrega** | **Alta**: definición de terminado (*Definition of Done*) compatible con listas de chequeo y pruebas E2E. | **Alta**: revisiones formales por fase con matrices exhaustivas. | **Media-Alta**: depende de pruebas automatizadas continuas, menos orientada a auditoría documental. | **Baja-Media**: suele sacrificar verificación documental por velocidad de prototipo. |

---

## 3. Selección Justificada de Metodología

### Metodología seleccionada: **Scrum** (complementada en análisis con modelado UML de trazabilidad)

**Justificación alineada con los 4 aspectos de caracterización:**

1. **Coherencia con equipo pequeño y ventana de entrega corta**: Scrum organiza el trabajo en iteraciones cortas con una lista priorizada de requisitos (`RF-01` a `RF-12`), evitando la carga ceremonial innecesaria de RUP pero manteniendo disciplina frente a la informalidad de RAD.
2. **Respuesta directa a requisitos con mejoras incrementales**: las funcionalidades de tienda, cotizaciones, herramientas técnicas y controles de seguridad/accesibilidad (`RNF-03`, `RNF-05`) evolucionan en incrementos verificables sin romper el núcleo del catálogo ni del checkout.
3. **Capitalización de la disponibilidad del negocio**: al tener contacto ágil con la operación comercial de Fotocopiadora SyP, las revisiones al cierre de cada bloque permiten validar flujos críticos reales (checkout, cotización formal e historial de servicio técnico) antes de pasar al siguiente módulo.
4. **Criterio de terminado verificable**: la práctica de *Definition of Done* de Scrum enlaza naturalmente el análisis de requisitos con listas de chequeo de consistencia, pruebas de regresión y verificación cruzada antes del cierre de entrega.

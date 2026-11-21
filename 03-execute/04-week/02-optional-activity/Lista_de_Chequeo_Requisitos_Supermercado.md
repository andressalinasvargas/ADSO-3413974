# Lista de Chequeo — Análisis de Requisitos del Sistema (Supermercado)

**Programa:** Análisis y Desarrollo de Software (ADSO) — Ficha 3413974  
**Aprendiz:** Andrés Fernando Salinas Vargas  
**Semana:** Week 4  

> **Documentos fuente en esta carpeta:**  
> - [`Analisis-de-Requerimientos-del-Sistema.pdf`](./Analisis-de-Requerimientos-del-Sistema.pdf) (15 páginas — levantamiento por módulos y perspectivas Dueño / Empleado)  
> - [`Cuestionario_GS_v2_Consolidado.xlsx`](./Cuestionario_GS_v2_Consolidado.xlsx) (hojas: `Cuestionario Consolidado`, `Análisis de Integración`, `Leyenda`)  

---

## 1. Objetivo de la lista de chequeo

Consolidar y verificar los puntos clave evaluados durante el trabajo en equipos para el análisis de requisitos del sistema del supermercado, cubriendo:
- Identificación de necesidades del negocio y procesos actuales (*AS-IS*).
- Participación de *stakeholders* (perspectiva del **Dueño** y del **Empleado / Cajero**).
- Validación de integración entre módulos y requisitos no funcionales.

---

## 2. Lista de chequeo por módulo y perspectiva

### Módulo 1: Ventas
- [x] **Perspectiva Dueño:** identificar si el proceso actual es manual o digital, cantidad de cajas POS y horarios de operación.
- [x] **Perspectiva Dueño:** validar exigencia de facturación electrónica (normatividad DIAN) y reportes detallados de cierre de caja por turno.
- [x] **Perspectiva Dueño:** definir necesidad de operación *offline* temporal, integración contable (ej. Siigo / SAP) y tiempo máximo por transacción.
- [x] **Perspectiva Empleado:** listar medios de pago aceptados (efectivo, tarjeta, QR, Nequi, etc.) y reglas/límites de descuento manual.
- [x] **Perspectiva Empleado:** documentar flujo de devoluciones/cambios con impacto en inventario, uso de lector de código de barras vs. SKU manual, consulta de stock en tiempo real y venta cruzada.

### Módulo 2: Inventario
- [x] **Perspectiva Dueño:** estimar cantidad de SKUs, existencia de códigos de barras (propios o EAN/UPC) y rol/frecuencia de actualización de precios.
- [x] **Perspectiva Dueño:** verificar manejo de fechas de vencimiento con alertas de caducidad, múltiples bodegas y periodicidad de conteos físicos.
- [x] **Perspectiva Dueño:** evaluar generación automática de órdenes de compra por stock mínimo y sincronización en tiempo real POS ↔ portal web.
- [x] **Perspectiva Empleado:** levantar campos actuales por producto, responsable de recepción de mercancía y registro de mermas/pérdidas.
- [x] **Perspectiva Empleado:** confirmar unidades de medida variables (kg/lb, unidades, litros), rotación de próximos a vencer, tiempo de ubicación en bodega y dificultades en auditoría física.

### Módulo 3: Promociones
- [x] **Perspectiva Dueño:** relevar uso actual de promociones y tipos frecuentes (descuentos %, combos, 2x1, precio especial) y canales de comunicación.
- [x] **Perspectiva Dueño:** definir vigencia programable (inicio/fin), aplicación automática vs. cupón, acumulación y regla de prioridad entre promociones.
- [x] **Perspectiva Dueño:** validar sincronización POS ↔ web, reportes de efectividad/margen y acuerdos financiados por proveedores (*trade marketing*).
- [x] **Perspectiva Empleado:** delimitar permisos por rol para evitar modificaciones no autorizadas de precios o promociones desde el POS.

### Módulo 4: Portal Web
- [x] **Perspectiva Dueño:** confirmar interés/estado actual de catálogo web, campos obligatorios vs. opcionales y proyección hacia *e-commerce*.
- [x] **Perspectiva Dueño:** definir modalidad de entrega (domicilio, recogida en tienda o ambas), pasarelas de pago (PSE, tarjeta, Nequi), reserva de stock en carrito, concurrencia en hora pico, notificaciones (correo/SMS), buscador con filtros y diseño *responsive*.
- [x] **Perspectiva Empleado:** asignar rol responsable de administrar contenidos/banners del portal y su cadencia de actualización.

### Módulo 5: Reportes
- [x] **Perspectiva Dueño:** priorizar tipos de reportes (ventas, inventario, empleados, promociones, financiero) y periodicidad (diaria, semanal, mensual).
- [x] **Perspectiva Dueño:** requerir ranking de productos más vendidos y menor rotación, formatos de exportación (Excel/PDF) y tablero en tiempo real con KPIs clave.

### Módulo 6: Requerimientos No Funcionales (RNF) y Adopción
- [x] **Perspectiva Dueño:** definir tiempo máximo de respuesta en POS (< 2 s), disponibilidad mínima (SLA, ej. 99.5%) y tiempo objetivo de recuperación (RTO).
- [x] **Perspectiva Dueño:** verificar cumplimiento de protección de datos (Ley 1581 Colombia), estándar PCI-DSS (si aplica tarjetas), frecuencia de respaldos, modelo de infraestructura (nube / *on-premise* / híbrida), escalabilidad y logs de auditoría.
- [x] **Perspectiva Empleado:** evaluar experiencia previa del equipo operativo con sistemas POS y planificar los días de capacitación requeridos.

---

## 3. Verificación de consolidación e integración

- [x] Cuestionario consolidado registrado en la hoja `Cuestionario Consolidado` de [`Cuestionario_GS_v2_Consolidado.xlsx`](./Cuestionario_GS_v2_Consolidado.xlsx).
- [x] Dependencias cruzadas entre módulos evaluadas en la hoja `Análisis de Integración`.
- [x] Convenciones y criterios de lectura documentados en la hoja `Leyenda`.
- [x] Presentación estructurada de soporte revisada en [`Analisis-de-Requerimientos-del-Sistema.pdf`](./Analisis-de-Requerimientos-del-Sistema.pdf).

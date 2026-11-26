# Informe de Análisis · Fotocopiadora SyP

**Guía 1 · Modelo conceptual (Producto 2)** · Autor: `@andressalinasvargas` · Última verificación (Día 2): `2026-11-26`

---

## 1. Interpretación de Requisitos del Caso

A partir del trabajo previo desarrollado junto al **Equipo Fotocopiadora SyP** y su última consolidación funcional, se interpretaron y estructuraron los requisitos del sistema en dos conjuntos claramente delimitados en [00-insumo-srs-base.md](../G1-P1-fotocopiadora-syp/00-insumo-srs-base.md):

1. **12 Requisitos Funcionales (`RF-01` a `RF-12`)**: abarcan el ciclo completo de venta consultiva y servicio técnico de la empresa — navegación de portada y catálogo paginado de 12 en 12 con comparador y compatibilidades (`RF-01`–`RF-03`), carrito persistente (`RF-04`), confirmación de pedido con múltiples medios de pago y prevención de envíos duplicados (`RF-05`), emisión y consulta privada de cotizaciones formales (`RF-06`), gestión de cuentas e historial (`RF-07`), canal institucional de contacto (`RF-08`), herramientas de autodiagnóstico técnico y agendamiento (`RF-09`), reporte mensual de contadores de renting (`RF-10`), administración integral con analítica y exportación segura (`RF-11`) y notificaciones de estado comercial (`RF-12`).
2. **8 Requisitos No Funcionales (`RNF-01` a `RNF-08`)**: delimitan usabilidad (<= 3 interacciones), responsividad sin desbordamiento desde 320 px, accesibilidad WCAG 2.2 AA (contraste >= 4.5:1 y navegación completa por teclado), rendimiento con imágenes ligeras y caché sin conexión, seguridad/privacidad de datos, disponibilidad mediante respaldo comercial alternativo, localización en pesos colombianos (`es-CO`) y verificabilidad automatizada.

La caracterización de 4 aspectos en [01-caracterizacion-y-metodologias.md](../G1-P1-fotocopiadora-syp/01-caracterizacion-y-metodologias.md) justificó la elección de **Scrum** como metodología idónea para un equipo pequeño de requisitos evolutivos con alta disponibilidad de validación comercial, ejecutada mediante un plan de `8` actividades en [02-plan-actividades-analisis.md](../G1-P1-fotocopiadora-syp/02-plan-actividades-analisis.md).

---

## 2. Modelos Elaborados e Interconectados

- **Modelo funcional (Casos de uso UML)**: [03-diagrama-casos-uso.svg](../G1-P1-fotocopiadora-syp/03-diagrama-casos-uso.svg) ([fuente `.drawio`](../G1-P1-fotocopiadora-syp/03-diagrama-casos-uso.drawio)) y [03-justificacion-relaciones-cu.md](../G1-P1-fotocopiadora-syp/03-justificacion-relaciones-cu.md), con frontera del sistema, `12` casos verbo + objeto, `3` actores primarios (`Cliente Registrado --|> Visitante`, `Administrador`), `2` secundarios (`Pasarela de Pagos`, `Servicio de Mensajería`), `3 «include»` y `2 «extend»`, verificados al `100 %` en [04-matriz-rf-casos-uso.md](../G1-P1-fotocopiadora-syp/04-matriz-rf-casos-uso.md).
- **Comportamiento detallado (Actividades y Plantillas)**:
  - Diagramas de actividades con calles, guardas `[...]` completas y nodos paralelos (`fork`/`join`): [CU-03 Confirmar pedido de compra](01-actividad-cu03-confirmar-pedido.svg) ([`.drawio`](01-actividad-cu03-confirmar-pedido.drawio)) y [CU-09 Solicitar servicio técnico y diagnóstico](02-actividad-cu09-servicio-tecnico.svg) ([`.drawio`](02-actividad-cu09-servicio-tecnico.drawio)).
  - Tres plantillas extendidas libres de detalles técnicos de implementación en [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md) (`CU-03`, `CU-09` y `CU-11`).
- **Modelo conceptual de negocio (Dominio)**: `12` clases abstractas sin métodos ni claves foráneas, con generalización `Persona` y clase de asociación `DetallePedido`, en [04-modelo-dominio-descripcion.md](04-modelo-dominio-descripcion.md) y [04-modelo-dominio.svg](04-modelo-dominio.svg) ([`.drawio`](04-modelo-dominio.drawio)).
- **Modelo de datos conceptual/lógico (MER Crow's Foot)**: `11` entidades con identificadores, cardinalidad y participación total/parcial, resolución de `2` relaciones `N:M` (`DETALLE_PEDIDO`, `DETALLE_COTIZACION`), entidad débil `NOTIFICACION` y relación recursiva de compatibilidad en `PRODUCTO`, en [05-mer-descripcion.md](05-mer-descripcion.md) y [05-modelo-entidad-relacion.svg](05-modelo-entidad-relacion.svg) ([`.drawio`](05-modelo-entidad-relacion.drawio)).
- **Prototipo inicial de interfaz**: `4` pantallas wireframe rotuladas por caso de uso en [06-prototipo-inicial/06-prototipo-inicial.md](06-prototipo-inicial/06-prototipo-inicial.md).

---

## 3. Resultado de la Verificación y Ajustes Realizados

Se aplicó la lista de chequeo de `18` criterios verificables (`5` de cobertura y trazabilidad) en [07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md):

- **Primera verificación (`2026-11-25`)**: `12 / 18` criterios aprobados y `6` hallazgos (`H-01` a `H-06`) identificados: enlaces faltantes de `RF-06`/`RF-12` en matriz Anexo C, inclusión explícita de `ReporteContador` en dominio, sincronización exacta de ramas alternas/excepciones entre actividades y plantillas, eliminación de validaciones dentro de precondiciones y de un término técnico en `CU-11`, adición de relación recursiva en `PRODUCTO` en el MER y sanitización total de ejemplos ficticios sin PII.
- **Segunda verificación (Día 2 · `2026-11-26`)**: tras documentar y corregir todos los hallazgos en [08-registro-ajustes.md](08-registro-ajustes.md), se revalidó el paquete completo obteniendo **`18 / 18` criterios cumplidos (`100 %`)**, `12 / 12` requisitos trazados en [09-matriz-trazabilidad.md](09-matriz-trazabilidad.md) y `0` coincidencias de información personal o detalles de implementación en el análisis.

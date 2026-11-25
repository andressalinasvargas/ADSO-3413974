# Entrega · Guía 1 · Modelo conceptual (Producto 2)

Ruta de entrega en mi fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/`

Fecha límite de la guía: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**

---

## 1. Datos de la entrega

- **Producto:** P2 modelo de análisis y verificación
- **Usuario de GitHub del autor:** `@andressalinasvargas`
- **Caso de estudio:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**
- **Trabajo en equipo del año:** Sí — proyecto colaborativo del año desarrollado junto al **Equipo Fotocopiadora SyP** (los modelos de comportamiento, dominio, MER, verificación y ajustes de este Producto 2 son trabajo individual de `@andressalinasvargas`).

## 2. Qué reutilicé

| Artefacto | Ruta o referencia de origen (trabajo previo del año) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Base funcional y entidades iniciales del caso | Arquitectura conceptual, catálogo de productos, flujo de pedidos/cotizaciones y reglas de negocio trabajadas en el proyecto del año (**Equipo Fotocopiadora SyP**) | En equipo (**Equipo Fotocopiadora SyP**) |
| Flujos narrativos actualizados de checkout, diagnóstico técnico y panel administrativo | Especificaciones y pantallas funcionales consolidadas del proyecto **Fotocopiadora SyP** (incluyendo paginación, contraste AA, prevención de doble envío y exportación segura) | En equipo (**Equipo Fotocopiadora SyP**) |
| Referencia metodológica de verificación y trazabilidad | Experiencias previas de análisis individual en `03-execute/` y los requisitos consolidados en [G1-P1-fotocopiadora-syp](../G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) | Solo (`@andressalinasvargas`) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | [01-actividad-cu03-confirmar-pedido.drawio](01-actividad-cu03-confirmar-pedido.drawio), [02-actividad-cu09-servicio-tecnico.drawio](02-actividad-cu09-servicio-tecnico.drawio) y [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md) | Alineé cada guarda entre corchetes (`[...]`) de los diagramas de actividades con las ramas alternas y excepciones de las 3 plantillas extendidas, moviendo la validación de existencias fuera de precondiciones y eliminando todo término técnico (`H-03`, `H-04` de `C1`/`C2`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 2 | [04-modelo-dominio-descripcion.md](04-modelo-dominio-descripcion.md) y [04-modelo-dominio.drawio](04-modelo-dominio.drawio) | Abstraje `12` clases conceptuales puras sin métodos ni claves foráneas, incorporando la clase `ReporteContador`, generalización `Persona` y clase de asociación `DetallePedido` coherente con las plantillas (`H-02` de `C3`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 3 | [05-mer-descripcion.md](05-mer-descripcion.md) y [05-modelo-entidad-relacion.drawio](05-modelo-entidad-relacion.drawio) | Formalicé notación **Pata de gallo (Crow's Foot)** declarada con participación total/parcial, resolución `N:M` en `DETALLE_PEDIDO`/`DETALLE_COTIZACION`, entidad débil `NOTIFICACION` y relación recursiva en `PRODUCTO` (`H-05` de `C4`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |
| 4 | [07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md), [08-registro-ajustes.md](08-registro-ajustes.md), [09-matriz-trazabilidad.md](09-matriz-trazabilidad.md) y [10-informe-analisis.md](10-informe-analisis.md) | Ejecuté lista de chequeo de `18` criterios (`5` de cobertura), documenté `6` hallazgos corregidos (`H-01`–`H-06`) incluyendo sanitización total de PII ficticio y completé trazabilidad `12/12 RF` (`100 %`) (`C6`, `C7`, `C8`). | [`ccdbe30`](https://github.com/andressalinasvargas/ADSO-3413974/commit/ccdbe30) |

## 4. Qué construí nuevo

- **2 diagramas de actividades UML** con calles por actor, guardas completas y barras `fork`/`join` para `CU-03` y `CU-09`.
- **3 plantillas extendidas de casos de uso** (`CU-03`, `CU-09`, `CU-11`) en [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md).
- **Modelo de dominio de 12 clases** y **MER Crow's Foot de 11 entidades** con su documentación descriptiva y fuentes editables `.drawio`.
- **4 wireframes iniciales rotulados** por caso de uso en [06-prototipo-inicial/06-prototipo-inicial.md](06-prototipo-inicial/06-prototipo-inicial.md).
- **Lista de chequeo (18 criterios), registro de 6 ajustes, matriz Anexo C y análisis formal** en [10-informe-analisis.md](10-informe-analisis.md).

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2): [CU-03 Confirmar pedido](01-actividad-cu03-confirmar-pedido.svg) ([`.drawio`](01-actividad-cu03-confirmar-pedido.drawio) · [`.png`](01-actividad-cu03-confirmar-pedido.png)) y [CU-09 Servicio técnico](02-actividad-cu09-servicio-tecnico.svg) ([`.drawio`](02-actividad-cu09-servicio-tecnico.drawio) · [`.png`](02-actividad-cu09-servicio-tecnico.png))
- [x] Plantillas extendidas de casos de uso (3): [03-plantillas-casos-uso.md](03-plantillas-casos-uso.md)
- [x] Modelo de dominio: [04-modelo-dominio-descripcion.md](04-modelo-dominio-descripcion.md) · [04-modelo-dominio.drawio](04-modelo-dominio.drawio) · [`.svg`](04-modelo-dominio.svg) · [`.png`](04-modelo-dominio.png)
- [x] Modelo entidad-relación: [05-mer-descripcion.md](05-mer-descripcion.md) · [05-modelo-entidad-relacion.drawio](05-modelo-entidad-relacion.drawio) · [`.svg`](05-modelo-entidad-relacion.svg) · [`.png`](05-modelo-entidad-relacion.png)
- [x] Prototipo inicial (4 pantallas rotuladas): [06-prototipo-inicial/06-prototipo-inicial.md](06-prototipo-inicial/06-prototipo-inicial.md)
- [x] Lista de chequeo diligenciada (18 criterios, 5 de cobertura): [07-lista-chequeo-validacion.md](07-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación: [08-registro-ajustes.md](08-registro-ajustes.md)
- [x] Informe de análisis (Anexo E): [10-informe-analisis.md](10-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C): [09-matriz-trazabilidad.md](09-matriz-trazabilidad.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@andressalinasvargas` · `2026-11-25`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente IA) | Apoyo en redacción libre de tecnología de plantillas `CU-03`/`CU-09`/`CU-11`, generación de diagramas `.drawio`/`.svg`/`.png`, generación de wireframes `.png` y cruce de matriz Anexo C. | Verifiqué manualmente la correspondencia de todas las guardas de actividades con las plantillas, la ausencia de métodos o claves foráneas en el modelo de dominio, las cardinalidades Crow's Foot del MER, la inspección visual de imágenes y la eliminación total de PII real. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1 publicado el `2026-11-25`; pendiente segundo commit de revisión en Día 2 antes del sábado `2026-11-28` a las 6:00 a. m.)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.

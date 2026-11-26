# Entrega · Guía 1 · Modelo conceptual (Producto 1)

Ruta de entrega en mi fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/`

Fecha límite de la guía: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**

---

## 1. Datos de la entrega

- **Producto:** P1 plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `@andressalinasvargas`
- **Caso de estudio:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**
- **Trabajo en equipo del año:** Sí — proyecto colaborativo del año desarrollado junto al **Equipo Fotocopiadora SyP** (la consolidación, ajuste metodológico y modelado de análisis de esta entrega son trabajo individual de `@andressalinasvargas`).

## 2. Qué reutilicé

| Artefacto | Ruta o referencia de origen (trabajo previo del año) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Especificación inicial de requisitos (`RF`/`RNF`) | Especificación SRS v2.0 consolidada del proyecto del año (**Equipo Fotocopiadora SyP**, repo colaborativo `Fotocopiadora-SyP`, documento base de requisitos) | En equipo (**Equipo Fotocopiadora SyP**) |
| Alcance funcional de catálogo, carrito, checkout, servicio técnico, renting y panel admin | Módulos funcionales implementados durante el año en la plataforma web **Fotocopiadora SyP** (actualizados con paginación, accesibilidad, caché sin conexión y privacidad en documentos) | En equipo (**Equipo Fotocopiadora SyP**) |
| Referencia metodológica y estructura de casos de uso del fork | Prácticas previas de análisis individual registradas en `03-execute/` (semanas 16–19 de este fork) aplicadas ahora al caso **Fotocopiadora SyP** | Solo (`@andressalinasvargas`) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | [00-insumo-srs-base.md](00-insumo-srs-base.md) y [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md) | Incorporé los requisitos actualizados del proyecto (paginación de 12 en 12, comparador, prevención de doble envío, privacidad en cotizaciones/pedidos, exportación segura y notificaciones) y separé explícitamente `12 RF` de `8 RNF` explicando por qué los RNF no son casos de uso (`C3` de `Rubricas_G1.md`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 2 | [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md) y [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md) | Construí desde la realidad del equipo pequeño (`2` integrantes) la caracterización de 4 aspectos, la matriz de 4 metodologías con 5 criterios propios y un plan Scrum de 8 actividades priorizadas con responsable, fecha y entregable (`C1` y `C2` de `Rubricas_G1.md`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 3 | [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio) y [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md) | Organicé los objetivos en `12` casos de uso verbo + objeto agrupando operaciones CRUD triviales en `CU-11`, tracé frontera del sistema con 3 actores primarios (`Cliente Registrado --|> Visitante`) y 2 secundarios externos, y corregí el sentido y justificación de 3 `«include»` y 2 `«extend»` con puntos de extensión (`C4` de `Rubricas_G1.md`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |
| 4 | [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md) | Añadí auditoría inversa `Caso de Uso → RF` (`12/12`, 0 casos huérfanos) para garantizar trazabilidad limpia hacia diseño (`C3`) y cierre de verificación cruzada en Día 2 (`2026-11-26`). | [`4c00ba4`](https://github.com/andressalinasvargas/ADSO-3413974/commit/4c00ba4) |

## 4. Qué construí nuevo

- **Caracterización formal de los 4 aspectos y matriz comparativa de 4 metodologías** (Scrum, RUP, XP, RAD) con 5 criterios derivados de la solución en [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md).
- **Plan de actividades de análisis en 2 sprints Scrum** con 8 entregables trazables en [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md).
- **Diagrama de casos de uso UML unificado de 12 casos** (`.drawio`, `.svg` y `.png`) con justificación explícita de cada relación en [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md).
- **Matriz bidireccional `RF ↔ Caso de Uso` al 100 %** en [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md).

## 5. Artefactos entregados

**Producto 1**

- [x] Insumo SRS base consolidado (`12 RF` y `8 RNF`): [00-insumo-srs-base.md](00-insumo-srs-base.md)
- [x] Caracterización de la solución: [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md#1-caracterización-de-la-solución-4-aspectos-obligatorios)
- [x] Comparación de metodologías y selección justificada: [01-caracterizacion-y-metodologias.md](01-caracterizacion-y-metodologias.md#2-comparación-de-metodologías-de-desarrollo)
- [x] Plan de actividades, cronograma y entregables: [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [03-diagrama-casos-uso.drawio](03-diagrama-casos-uso.drawio)
- [x] Diagrama de casos de uso (imágenes y justificación): [03-diagrama-casos-uso.png](03-diagrama-casos-uso.png) · [03-diagrama-casos-uso.svg](03-diagrama-casos-uso.svg) · [03-justificacion-relaciones-cu.md](03-justificacion-relaciones-cu.md)
- [x] Matriz requisito → caso de uso: [04-matriz-rf-casos-uso.md](04-matriz-rf-casos-uso.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@andressalinasvargas` · `2026-11-26`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity (asistente IA) | Apoyo en consolidación de requisitos `RF`/`RNF` a partir de la actualización más reciente de Fotocopiadora SyP, estructuración de tablas comparativas y generación de fuentes `.drawio`/`.svg`/`.png`. | Verifiqué manualmente que cada `RF` refleje el comportamiento real actual del proyecto, que no haya datos personales ni detalles de implementación en el análisis, y que la dirección de flechas `«include»`/`«extend»` cumpla la sección 7 de `Rubricas_G1.md`. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: `2026-11-25` [`4c00ba4`, `a21333a`] · Día 2: `2026-11-26`, verificación cruzada en matriz y cierre de entrega)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.

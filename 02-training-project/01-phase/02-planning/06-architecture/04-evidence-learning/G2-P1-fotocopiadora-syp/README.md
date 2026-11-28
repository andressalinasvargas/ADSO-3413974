# README de entrega · Guía 2: Diseño de la solución

> **English version:** [english/README.md](english/README.md)

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) · [`G1-P2-fotocopiadora-syp/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/10-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el proyecto del año (**Fotocopiadora SyP**) se trabajó en equipo de `2` integrantes (`@andressalinasvargas` y `@Kevin81A`), pero el análisis consolidado de `G1-P1-fotocopiadora-syp` / `G1-P2-fotocopiadora-syp` y todo este diseño son elaboración individual propia. |
| ¿Qué parte del SRS es tuya? | El 100 % de los `12 RF` (`RF-01`–`RF-12`) y `8 RNF` (`RNF-01`–`RNF-08`) estructurados y verificados en `G1-P1-fotocopiadora-syp` y `G1-P2-fotocopiadora-syp`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, trabajo individual y con decisiones de diseño propias diferenciadas (patrones GoF **Comando** y **Fábrica Abstracta**, arquitectura **Hexagonal**, `7` componentes y `24` clases/interfaces). |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. Ningún archivo de diseño de `G2-P1` fue copiado de `@Kevin81A` ni de otros aprendices. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
| :--- | :--- | :--- | :--- |
| **A1.** Ficha de interpretación y plataforma | [01-ficha-interpretacion-y-plataforma.md](01-ficha-interpretacion-y-plataforma.md) | [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) | Incorporé los `12 RF` y `8 RNF`, `5` actores y justifiqué **Python 3.12 + FastAPI** y **BD Relacional** con `4` condiciones concretas del negocio. |
| **A2.** Diagrama de clases | [02-diagrama-clases-y-patrones.md](02-diagrama-clases-y-patrones.md) · [`.drawio`](02-diagrama-clases.drawio) · [`.svg`](02-diagrama-clases.svg) | [`G1-P2-fotocopiadora-syp/04-modelo-dominio.drawio`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/04-modelo-dominio.drawio) | Evolucioné las `12` clases conceptuales hacia **`24` elementos OO (`21` clases + `3` interfaces)** con visibilidad, tipos, parámetros, herencia, agregaciones, composiciones y cero mezcla de áreas. |
| **A3.** Patrones de diseño GoF | [02-diagrama-clases-y-patrones.md](02-diagrama-clases-y-patrones.md#3-patrones-de-diseño-gof-propios-aplicados-a3--ninguno-es-singleton) | Nuevo | Apliqué e integré en el diagrama los patrones **Comando** (`IComandoOperacion`, `DespachadorComandos`, `3` comandos) y **Fábrica Abstracta** (`IFabricaEntregaComercial`, `2` fábricas), ambos distintos de Singleton. |
| **A4.** Arquitectura del software | [03-arquitectura-software.md](03-arquitectura-software.md) · [`.drawio`](03-arquitectura-software.drawio) · [`.svg`](03-arquitectura-software.svg) | Nuevo | Definí **Arquitectura Hexagonal (Puertos y Adaptadores)** con flujo estricto sin saltos, tabla de decisiones para los `8` RNF y `2` alternativas descartadas. |
| **A5.** Vista de componentes | [04-vista-componentes.md](04-vista-componentes.md) · [`.drawio`](04-vista-componentes.drawio) · [`.svg`](04-vista-componentes.svg) | Nuevo | Diseñé **`7` componentes** con interfaces provistas/requeridas nombradas, dependencias válidas y mapeo completo de clases/requisitos. |
| **A6.** Vista de despliegue | [05-vista-despliegue.md](05-vista-despliegue.md) · [`.drawio`](05-vista-despliegue.drawio) · [`.svg`](05-vista-despliegue.svg) | Nuevo | Modelé **`5` nodos** (`NavegadorClientePWA`, `EstacionAdministrador`, `BordeEstaticoRenderCDN`, `ServidorAPIFastAPIDocker`, `MotorRelacionalPostgreSQL`) con `HTTPS 443 TLS 1.3` y `TCP 5432` privado. |
| **A7.** Matriz de trazabilidad análisis → diseño | [06-matriz-trazabilidad-diseno.md](06-matriz-trazabilidad-diseno.md) | [`G1-P2-fotocopiadora-syp/09-matriz-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/09-matriz-trazabilidad.md) | Mapeé `12/12 RF` (`100 %`) y `8/8 RNF` hacia clases, componentes y tablas, con verificación inversa `24/24` clases sin huérfanas. |

**Qué reutilicé (resumen):**
Partí del análisis individual realizado en `G1-P1-fotocopiadora-syp` y `G1-P2-fotocopiadora-syp` (`12 RF`, `8 RNF`, `12` clases conceptuales y `11` entidades) junto con los módulos reales del proyecto colaborativo del año (`Fotocopiadora SyP`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**
Convertí el dominio conceptual sin métodos en un diagrama OO de `24` elementos tipados, con herencia (`Persona`), agregaciones (`Categoria`/`CarritoCompra`) y composiciones (`Pedido`, `Cotizacion`, `Notificacion`), desacoplando persistencia y exportación CSV.

**Qué hice completamente nuevo (resumen):**
Diseñé desde cero la **Arquitectura Hexagonal**, los patrones GoF **Comando** y **Fábrica Abstracta**, la vista de `7` componentes con sus interfaces, la vista de despliegue de `5` nodos con cifrado TLS y red privada BD, y la matriz bidireccional `A7`.

---

## 4. Autoverificación de mínimos

- [x] **A1** Ficha de interpretación: `12` RF y `8` RNF con ID; plataforma **Python 3.12 + FastAPI / PostgreSQL-SQLite** justificada con `4` condiciones concretas.
- [x] **A2** Diagrama de clases: `24` elementos (`≥ 8`), tipos, métodos, multiplicidades, composiciones/agregaciones y herencia + `3` interfaces con implementaciones polimórficas.
- [x] **A3** `2` patrones GoF distintos aplicados en el diagrama (**Comando** y **Fábrica Abstracta**, ninguno Singleton).
- [x] **A4** Arquitectura **Hexagonal** con diagrama, tabla de `8` RNF → decisión y `2` alternativas descartadas.
- [x] **A5** Vista de componentes: `7` componentes (`≥ 5`) con interfaces provistas y requeridas nombradas.
- [x] **A6** Vista de despliegue: `5` nodos (`≥ 3`) con artefactos, `HTTPS 443` y `TCP 5432` privado.
- [x] **A7** Matriz de trazabilidad análisis → diseño al `100 %` (`12/12` RF y `24/24` clases).
- [x] Fuente editable (`.drawio`) e imagen exportada (`.svg`) de cada diagrama (`02`–`05`).

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-27` (Día 1) | `feat(g2-p1): agregar diseno OO con Comando y Fabrica Abstracta, arquitectura hexagonal, vistas y trazabilidad de fotocopiadora-syp` — Construcción completa de `A1`–`A7` y diagramas `.drawio`/`.svg` propios sobre `G1-P1`/`G1-P2`. |
| *`2026-11-28` (Día 2 programado antes `06:00 a. m.`)* | Cierre de trazabilidad cruzada `P1 ↔ P2` contra políticas `POL-*` y hallazgo `H-04` en [`G2-P2/07-lista-chequeo-verificacion.md`](../G2-P2-fotocopiadora-syp/07-lista-chequeo-verificacion.md). |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en redacción técnica de arquitectura hexagonal, tablas de trazabilidad `A7` y generación XML `.drawio`/`.svg` de los `4` diagramas de `G2-P1`. | Verifiqué manualmente la coherencia con mis `12 RF`/`8 RNF` propios de `G1-P1`, comprobé que mis patrones (**Comando** y **Fábrica Abstracta**) y arquitectura fueran propios e independientes de otros forks, e inspeccioné que no haya mezcla de capas ni PII. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) · [`G1-P2-fotocopiadora-syp/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-fotocopiadora-syp/10-informe-analisis.md)
- Carpeta de esta entrega en GitHub: [`G2-P1-fotocopiadora-syp`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp)
- Carpeta par Producto 2: [`G2-P2-fotocopiadora-syp`](../G2-P2-fotocopiadora-syp/README.md)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@andressalinasvargas`  Fecha: `2026-11-27`

# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) · [`G1-P2-asistencia-sena/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/10-informe-analisis.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | No, lo consolidé individualmente sobre mis entregables previos del año en `03-execute/`. |
| ¿Qué parte del SRS es tuya? | El 100 % de los 12 RF (`RF-01` a `RF-12`), 6 RNF (`RNF-01` a `RNF-06`) y el informe de análisis de `G1-P2-asistencia-sena`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, elaboración y diseño individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
| :--- | :--- | :--- | :--- |
| **A1.** Ficha de interpretación y plataforma | [01-ficha-interpretacion-y-plataforma.md](01-ficha-interpretacion-y-plataforma.md) | [`G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) | Seleccioné los 12 RF y 6 RNF con métricas medibles y justifiqué PHP 8.3 (POO) y MariaDB 10.11 InnoDB con 4 condiciones del caso cada uno. |
| **A2.** Diagrama de clases | [02-diagrama-clases-y-patrones.md](02-diagrama-clases-y-patrones.md) · [`.drawio`](02-diagrama-clases.drawio) · [`.svg`](02-diagrama-clases.svg) | [`03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio`](../../../../../../03-execute/16-week/02-optional-activity/Diagramas_UML_Asistencia_SENA.drawio) y [`G1-P2/04-modelo-dominio.drawio`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/04-modelo-dominio.drawio) | Evolucioné de 3 clases iniciales y 11 conceptuales a **19 clases/interfaces OO** con visibilidad, tipos, parámetros, multiplicidades, herencia (`Persona`), agregación (`FichaFormacion o-- Aprendiz`) y composición (`SesionAsistencia *-- RegistroAsistencia *-- NovedadContingencia`). |
| **A3.** Patrones de diseño GoF | [02-diagrama-clases-y-patrones.md](02-diagrama-clases-y-patrones.md) · [`.drawio`](02-diagrama-clases.drawio) · [`.svg`](02-diagrama-clases.svg) | Nuevo | Apliqué e integré en el diagrama **Estrategia** (`IEstrategiaRegistro` con 3 implementaciones polimórficas) y **Fachada** (`FachadaControlAsistencia`), distintos de Singleton. |
| **A4.** Arquitectura del software | [03-arquitectura-software.md](03-arquitectura-software.md) · [`.drawio`](03-arquitectura-software.drawio) · [`.svg`](03-arquitectura-software.svg) | Nuevo | Definí estilo estricto en **3 capas** sin saltos de capa, protocolos entre capas y tabla de decisiones para `RNF-01` a `RNF-06` con alternativas descartadas. |
| **A5.** Vista de componentes | [04-vista-componentes.md](04-vista-componentes.md) · [`.drawio`](04-vista-componentes.drawio) · [`.svg`](04-vista-componentes.svg) | Nuevo | Modelé **8 componentes** con interfaces provistas y requeridas nombradas, dependencias descendentes y mapeo de las 19 clases/interfaces hacia requisitos. |
| **A6.** Vista de despliegue | [05-vista-despliegue.md](05-vista-despliegue.md) · [`.drawio`](05-vista-despliegue.drawio) · [`.svg`](05-vista-despliegue.svg) | Nuevo | Modelé **4 nodos** (`Cliente Escritorio`, `Cliente Móvil`, `Servidor Aplicación Apache/PHP Docker`, `Servidor Datos MariaDB Docker`) con protocolos (`HTTPS 443`, `TCP 3306` privado) y decisiones frente a RNF. |
| **A7.** Matriz de trazabilidad análisis → diseño | [06-matriz-trazabilidad-diseno.md](06-matriz-trazabilidad-diseno.md) | [`G1-P2/09-matriz-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/09-matriz-trazabilidad.md) | Extendí la trazabilidad hacia clases (`A2`), tablas (`G2-P2`), componentes (`A5`) y decisiones (`A3`/`A4`/`A6`) al 100 %, más verificación inversa de las 19 clases y auditoría cruzada `P1 ↔ P2` contra políticas `POL-*` (`2026-11-24`). |

**Qué reutilicé (resumen):**
Partí del SRS consolidado (`G1-P1`), del informe de análisis y modelo de dominio (`G1-P2`) y del boceto original de 3 clases de la semana 16 (`Diagramas_UML_Asistencia_SENA.drawio`), conservando las reglas reales del llamado a lista en SENA (QR rotativo, código numérico de 6 dígitos, geocerca, contingencia y Ley 1581).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**
Convertí el modelo conceptual sin métodos en un diagrama de clases de diseño completo con encapsulamiento, tipado PHP 8.3, herencia, agregación, composiciones, separación estricta de responsabilidades (sin mezclar UI, lógica, persistencia ni reportes) y trazabilidad bidireccional al 100 %.

**Qué hice completamente nuevo (resumen):**
Diseñé desde cero la aplicación de los patrones GoF **Estrategia** y **Fachada**, la arquitectura de **3 capas**, la vista de **8 componentes** con sus interfaces provistas/requeridas, la vista de despliegue de **4 nodos** con protocolos y cifrado TLS, y todos sus diagramas `.drawio` y `.svg`.

---

## 4. Índice y Autoverificación de Mínimos (`A1`–`A7`)

- [x] **A1** [Ficha de interpretación](01-ficha-interpretacion-y-plataforma.md): `12` RF y `6` RNF con ID; plataforma **PHP 8.3 + MariaDB 10.11 InnoDB** justificada con 4 condiciones del caso.
- [x] **A2** [Diagrama de clases](02-diagrama-clases-y-patrones.md) ([`.drawio`](02-diagrama-clases.drawio) · [`.svg`](02-diagrama-clases.svg)): `19` clases/interfaces con visibilidad, tipos, parámetros y retornos, multiplicidades completas, herencia (`Persona`), agregación (`FichaFormacion o-- Aprendiz`) y composición (`SesionAsistencia *-- RegistroAsistencia *-- NovedadContingencia`).
- [x] **A3** [Patrones GoF aplicados](02-diagrama-clases-y-patrones.md#3-patrones-de-diseño-gof-aplicados-a3): **Estrategia** (`IEstrategiaRegistro` con 3 implementaciones polimórficas) y **Fachada** (`FachadaControlAsistencia`), ambos distintos de Singleton.
- [x] **A4** [Arquitectura 3 capas](03-arquitectura-software.md) ([`.drawio`](03-arquitectura-software.drawio) · [`.svg`](03-arquitectura-software.svg)): estilo definido sin saltos de capa, comunicación entre capas y tabla de `6` RNF + estilo con alternativas descartadas.
- [x] **A5** [Vista de componentes](04-vista-componentes.md) ([`.drawio`](04-vista-componentes.drawio) · [`.svg`](04-vista-componentes.svg)): `8` componentes con interfaces provistas/requeridas nombradas, dependencias correctas y mapeo completo de clases y requisitos.
- [x] **A6** [Vista de despliegue](05-vista-despliegue.md) ([`.drawio`](05-vista-despliegue.drawio) · [`.svg`](05-vista-despliegue.svg)): `4` nodos con artefactos alojados, puertos/protocolos (`HTTPS 443`, `TCP 3306`) y decisiones vinculadas a RNF.
- [x] **A7** [Matriz de trazabilidad](06-matriz-trazabilidad-diseno.md): `12/12` RF (`100 %`) y `6/6` RNF mapeados hacia adelante y `19/19` clases verificadas hacia atrás (`0` clases huérfanas).
- [x] Fuente editable (`.drawio`) e imagen exportada (`.svg`) de cada diagrama (`A2`/`A3`, `A4`, `A5`, `A6`).

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-23` (Día 1) | [`0edb683`](https://github.com/andressalinasvargas/ADSO-3413974/commit/0edb683) — `feat(g2-p1): agregar ficha, diagrama de clases con GoF, arquitectura, componentes, despliegue y trazabilidad` |
| `2026-11-24` (Día 2) | `docs(g2-p1): completar trazabilidad cruzada P1-P2 y cierre Dia 2` — Revisión cruzada `8` componentes / `19` clases contra `10` tablas y `9` políticas `POL-*` de `G2-P2` ([06-matriz-trazabilidad-diseno.md](06-matriz-trazabilidad-diseno.md) §3), verificando `24/24` criterios cumplidos |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Apoyo en la estructuración de tablas de trazabilidad, redacción de especificaciones de arquitectura y generación XML de diagramas `.drawio` y gráficos `.svg`. | Verifiqué manualmente la correspondencia exacta de las 19 clases/interfaces con los flujos reales de `asistencia-sena`, la ausencia de mezcla de responsabilidades por clase, la dirección de flechas UML y la coherencia entre componente, interfaz y requisito. |

---

## 7. Enlaces

- Informe de análisis / SRS del caso: [`G1-P1-asistencia-sena/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) · [`G1-P2-asistencia-sena/10-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/10-informe-analisis.md)
- Carpeta de esta entrega en GitHub: [`G2-P1-asistencia-sena`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-asistencia-sena)
- Carpeta par Producto 2: [`G2-P2-asistencia-sena`](../G2-P2-asistencia-sena/README.md)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@andressalinasvargas`  Fecha: `2026-11-24`

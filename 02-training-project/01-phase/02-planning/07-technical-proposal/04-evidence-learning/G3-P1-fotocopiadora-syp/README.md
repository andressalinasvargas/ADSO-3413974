# README de entrega · Guía 3: Propuesta Técnica

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P1 (Ficha técnica estandarizada, referente normativo y dimensionamiento de licencias) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Enlace al informe de análisis / arquitectura (ruta en tu fork) | [`G1-P1-fotocopiadora-syp/00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md) · [`G2-P1-fotocopiadora-syp/03-arquitectura-software.md`](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/03-arquitectura-software.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el proyecto del año (**Fotocopiadora SyP**) pertenece a un equipo de `2` integrantes (`@andressalinasvargas` y `@Kevin81A`), pero todos los artefactos técnicos y de propuesta económica en `ADSO-3413974` (`G2` y `G3`) son de elaboración individual diferenciada. |
| ¿Qué parte del SRS es tuya? | Los `12 RF`, `8 RNF`, modelo OO Hexagonal (Comando + Fábrica Abstracta) y esquema lógico `12` tablas documentados en `G1-*-fotocopiadora-syp` y `G2-*-fotocopiadora-syp`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. Todo el diseño de fichas (`A1`), marco normativo colombiano (`A3`) e inventario real (`A4`) se construyó de forma independiente bajo **Escenario B provisional**. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. Se mantiene diferenciación arquitectónica y presupuestal total (arquitectura Hexagonal, `12` tablas, Escenario B `120` usuarios / `2` sedes). |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo (Día 1 — en progreso hacia Día 2)

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué construí / estado actual |
| :--- | :--- | :--- | :--- |
| **A1.** Formato estandarizado de ficha técnica | [01-formato-ficha-tecnica.md](01-formato-ficha-tecnica.md) | Nuevo (trazado a `G1-P1`, `G2-P1`, `G2-P2`) | Plantilla neutral de `15` campos alineada a `ISO/IEC/IEEE 29148:2018` e `ISO/IEC 25010:2023`, con mapa `FT-SYP-001`–`004`. (**Completado Día 1**) |
| **A2.** Diligenciamiento de fichas técnicas operativas | *Programado Día 2* (`02-fichas-tecnicas-aplicacion.md`) | Pendiente | Diligenciamiento detallado de `FT-SYP-001`..`004` + perfil de infraestructura. (**Pendiente Día 2**) |
| **A3.** Referente técnico y marco normativo | [03-referente-tecnico-normativo.md](03-referente-tecnico-normativo.md) | Nuevo | `6` referentes externos verificados al `2026-11-27` (`Ley 1581/2012 + Dec. 1074/2015` con transmisión vs. transferencia, `Ley 23/1982`, `Decisión 351/1993`, `WCAG 2.2 AA / ISO 25010`, `Ley 527/1999`, `Ley 1480/2011`), separados de `GOB-SYP-01..04`. (**Completado Día 1**) |
| **A4.** Dimensionamiento e inventario real de licencias | [04-dimensionamiento-licencias.md](04-dimensionamiento-licencias.md) | Nuevo + inventario real de `Fotocopiadora-SyP-main` | Parametrización escenarios `A`–`D` (con **Escenario B provisional**), `8` componentes trazados a `[N1]`–`[N7]`, e inventario exacto de `8` dependencias prod + `3` QA Python + `package.json` sin copyleft. (**Completado Día 1**) |
| **A5.** Evaluación comparativa de alternativas tecnológicas | *Programado Día 2* | Pendiente | Matriz multicriterio de proveedores/runtimes y selección justificada. (**Pendiente Día 2**) |
| **A6.** Consolidación de costos de licenciamiento e infraestructura | *Programado Día 2* | Pendiente | Integración de valores unitarios hacia presupuesto `G3-P2`. (**Pendiente Día 2**) |

---

## 4. Autoverificación de mínimos (progreso Día 1)

- [x] **A1** Formato estandarizado de ficha técnica (`15` campos, `ISO/IEC/IEEE 29148:2018` / `ISO/IEC 25010:2023`, agnóstico de marca).
- [ ] **A2** Fichas técnicas diligenciadas por módulo e infraestructura *(programado para commit Día 2 antes del cierre `2026-12-05`)*.
- [x] **A3** Referente técnico y normativo vigente (`6` referentes verificados al `2026-11-27`, separado de políticas internas `GOB-SYP-01..04`).
- [x] **A4** Dimensionamiento parametrizado (`A`–`D`, **Escenario B provisional**) + inventario real de `Fotocopiadora-SyP-main` y estrategia de cesión patrimonial sin contaminación copyleft.
- [ ] **A5** Matriz comparativa de alternativas tecnológicas *(programado Día 2)*.
- [ ] **A6** Consolidación preliminar de costos de licenciamiento/infraestructura *(programado Día 2)*.

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-27` (Día 1) | `feat(g3-p1): crear formato A1, referente normativo A3 y README inicial de fotocopiadora-syp` — Estructuración normativa y plantilla de ficha técnica de `Fotocopiadora SyP`. |
| `2026-11-27` (Día 1) | `feat(g3-p1): agregar dimensionamiento de licencias e inventario real FastAPI A4 de fotocopiadora-syp` — Parametrización `A`–`D` e inventario exacto de dependencias `requirements.txt` / `requirements-dev.txt` / `package.json`. |
| *Día 2 (programado antes `2026-12-05 06:00 a. m.`)* | Incorporación de `A2`, `A5` y `A6` con comparación multicriterio y costos definitivos de licencias/nube. |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Estructuración del formato `A1`, síntesis de artículos normativos colombianos en `A3` y tabulación de escenarios `A`–`D` en `A4`. | Verifiqué personalmente cada versión exacta de paquete en `fastapi_backend/requirements.txt`, `requirements-dev.txt` y `package.json` de `Fotocopiadora-SyP-main`, confirmando licencias OSI y trazabilidad con `G2-P1`/`G2-P2`. |

---

## 7. Enlaces

- Insumo SRS (`G1-P1`): [`00-insumo-srs-base.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-fotocopiadora-syp/00-insumo-srs-base.md)
- Diseño y BD (`G2-P1` / `G2-P2`): [`G2-P1-fotocopiadora-syp`](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/README.md) · [`G2-P2-fotocopiadora-syp`](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/README.md)
- Carpeta par Producto 2 (`G3-P2`): [`G3-P2-fotocopiadora-syp`](../G3-P2-fotocopiadora-syp/README.md)
- Carpeta de esta entrega en GitHub: [`G3-P1-fotocopiadora-syp`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/07-technical-proposal/04-evidence-learning/G3-P1-fotocopiadora-syp)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo previo en `Fotocopiadora SyP` está declarado en las secciones 2 y 3, que no copié propuestas de otros aprendices ni materiales del instructor como propios, y que puedo sustentar cada decisión técnica en la verificación oral.

# README de entrega · Guía 3: Propuesta Técnica y Económica

## 1. Datos de la entrega

| Campo | Valor |
| :--- | :--- |
| Producto | P2 (Propuesta técnica, arquitectura de despliegue, presupuesto y marco contractual) |
| Usuario de GitHub del autor | `@andressalinasvargas` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP** (`fotocopiadora-syp`) |
| Enlace a la propuesta / arquitectura base (ruta en tu fork) | [`G2-P1-fotocopiadora-syp/05-vista-despliegue.md`](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/05-vista-despliegue.md) · [`G3-P1-fotocopiadora-syp/README.md`](../G3-P1-fotocopiadora-syp/README.md) |
| Cuenta de GitHub con la que haces los commits | `@andressalinasvargas` |

---

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
| :--- | :--- |
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el proyecto **Fotocopiadora SyP** corresponde a un equipo de `2` integrantes (`@andressalinasvargas` y `@Kevin81A`), manteniendo entregables `G2` y `G3` completamente independientes en arquitectura, modelo de datos, presupuesto y TdR. |
| ¿Qué parte del SRS es tuya? | El consolidado `G1-P1`/`G1-P2`, el diseño OO Hexagonal `G2-P1`, las `12` tablas SQL verificadas en `G2-P2` y la presente estructura `G3`. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. El diagrama de despliegue de `7` nodos (`B3`) y el marco contractual/TdR/ANS (`B6`) bajo **Escenario B provisional** fueron construidos individualmente. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. Ningún archivo, cifra o diagrama fue tomado de otro aprendiz. |

---

## 3. Qué reutilicé, qué ajusté y qué hice nuevo (Día 1 — en progreso hacia Días 2 y 3)

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué construí / estado actual |
| :--- | :--- | :--- | :--- |
| **B1.** Análisis de requerimientos y alcance económico | *Programado Día 2* | Pendiente | Consolidación de alcance CAPEX/OPEX en escenario B. (**Pendiente Día 2**) |
| **B2.** Cotizaciones y fuentes de precios | *Programado Día 2* | Pendiente | Evidencia comparativa de precios de nube, dominio, SMTP y horas de desarrollo. (**Pendiente Día 2**) |
| **B3.** Diagrama de arquitectura de despliegue (`7` nodos `[N1]`–`[N7]`) | [03-diagrama-arquitectura-despliegue-g3.drawio](03-diagrama-arquitectura-despliegue-g3.drawio) · [`.svg`](03-diagrama-arquitectura-despliegue-g3.svg) | Evolución desde [`G2-P1/05-vista-despliegue.svg`](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/05-vista-despliegue.svg) | Ampliado de `5` a **`7` nodos** (`[N1]` WAF/DNS, `[N2]` Proxy Inverso, `[N3]` API ASGI FastAPI, `[N4]` Worker PDF/SMTP, `[N5]` PostgreSQL 16, `[N6]` Storage backups `AES-256`, `[N7]` Observabilidad y SMTP) trazables a presupuesto y ANS. (**Diagrama completado Día 1**; tabla de costos en Día 2) |
| **B4.** Presupuesto consolidado (tope `$70.000.000 COP`) | *Programado Día 2* | Pendiente | Presupuesto detallado bajo **Escenario B provisional**. (**Pendiente Día 2**) |
| **B5.** Acta de verificación técnica y económica | *Programado Día 3* | Pendiente | Validación cruzada final entre `G3-P1` y `G3-P2`. (**Pendiente Día 3**) |
| **B6.** Marco contractual, TdR y ANS | [06-contrato-tdr-ans.md](06-contrato-tdr-ans.md) | Nuevo | **`14`** elementos esenciales del contrato, **`8`** TdR específicos (`TdR-01`–`TdR-08`) y **`4`** métricas ANS medibles (`ANS-01` `99,5 %`, `ANS-02` `p95 <= 1,5 s`, `ANS-03` `RPO <= 24 h`, `ANS-04` `P1 <= 30 min` / `RTO <= 2 h`). (**Completado Día 1**) |
| **B7.** Documento maestro de propuesta técnico-económica | *Programado Día 3* | Pendiente | Consolidación ejecutiva final de la propuesta `v1.0` tras validación `B5`. (**Pendiente Día 3**) |

---

## 4. Autoverificación de mínimos (progreso Día 1)

- [ ] **B1** Alcance económico y premisas financieras *(programado Día 2)*.
- [ ] **B2** Cotizaciones reales y tabla comparativa *(programado Día 2)*.
- [x] **B3** Diagrama de arquitectura de despliegue (`7` nodos `[N1]`–`[N7]` en `.drawio` y `.svg` válidos) trazado a licencias (`A4`) y ANS (`B6`). *(Tabla económica asociada se agrega en Día 2).*
- [ ] **B4** Presupuesto consolidado dentro de tope `$70.000.000 COP` *(programado Día 2)*.
- [ ] **B5** Acta de verificación integral *(programado Día 3)*.
- [x] **B6** Contrato (`14` elementos), Términos de Referencia (`TdR-01`–`TdR-08`) y `ANS-01`–`ANS-04` medibles con matriz de severidad `P1`–`P3`.
- [ ] **B7** Propuesta técnico-económica consolidada *(programado Día 3 antes del cierre `2026-12-05`)*.

---

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
| :--- | :--- |
| `2026-11-27` (Día 1) | `feat(g3-p2): crear diagrama de despliegue 7 nodos B3, marco contrato-TdR-ANS B6 y README inicial de fotocopiadora-syp` — Generación de diagrama `B3` (`[N1]`–`[N7]`) y documento contractual/ANS `B6`. |
| *Día 2 (programado)* | Incorporación de `B1`, `B2`, descripción detallada `B3` y presupuesto `B4` en Escenario B. |
| *Día 3 (programado antes `2026-12-05 06:00 a. m.`)* | Cierre con acta `B5` y propuesta consolidada `B7`, completando entregas escalonadas en múltiples días calendario. |

---

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
| :--- | :--- | :--- |
| Antigravity (asistente IA) | Generación XML `.drawio`/`.svg` del diagrama de `7` nodos `[N1]`–`[N7]` y estructuración tabular del marco contractual, `TdR-01`–`TdR-08` y `ANS-01`–`ANS-04`. | Validé que los archivos `.drawio` y `.svg` sean XML válidos sin errores, que los `7` nodos coincidan `1:1` con los componentes de `A4` y que cada métrica ANS tenga umbral medible y nodo responsable. |

---

## 7. Enlaces

- Ficha, normativa y licencias (`G3-P1`): [`G3-P1-fotocopiadora-syp`](../G3-P1-fotocopiadora-syp/README.md)
- Vista de despliegue previa (`G2-P1`): [`05-vista-despliegue.md`](../../../06-architecture/04-evidence-learning/G2-P1-fotocopiadora-syp/05-vista-despliegue.md)
- Diagrama de despliegue G3 (`B3`): [`03-diagrama-arquitectura-despliegue-g3.svg`](03-diagrama-arquitectura-despliegue-g3.svg)
- Carpeta de esta entrega en GitHub: [`G3-P2-fotocopiadora-syp`](https://github.com/andressalinasvargas/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/07-technical-proposal/04-evidence-learning/G3-P2-fotocopiadora-syp)

---

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que la trazabilidad con `G1` y `G2` de **Fotocopiadora SyP** está documentada en las secciones 2 y 3, que no copié propuestas de terceros y que puedo sustentar cada decisión técnica y nivel de servicio en la verificación oral.

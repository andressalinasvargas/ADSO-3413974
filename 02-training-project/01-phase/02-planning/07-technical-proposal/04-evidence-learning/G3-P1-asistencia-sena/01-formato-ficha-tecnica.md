# A1 · Formato Propio de Ficha Técnica de Especificaciones

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974`  
**Producto:** G3-P1 · Especificaciones técnicas (`RAP 593060`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23` · **Versión:** `1.0`

---

## 1. Estándares Base y Reglas de Uso del Formato

Este formato propio de ficha técnica fue diseñado con **15 campos obligatorios** tomando como referencia técnica:

- **ISO/IEC/IEEE 29148:2018** (*Systems and software engineering — Life cycle processes — Requirements engineering*): exige que cada especificación sea inequívoca, completa, consistente y verificable mediante un criterio objetivo.
- **ISO/IEC 25010:2023** (*Systems and software Quality Requirements and Evaluation — SQuaRE — Product quality model*): orienta la definición de atributos medibles de desempeño, seguridad, confiabilidad, compatibilidad, capacidad de interacción y mantenibilidad.

### Reglas de Diligenciamiento (aplicadas en todas las fichas de `A2`)
1. **Neutralidad tecnológica (sin exigir marcas):** ninguna ficha exige una marca o modelo comercial como requisito obligatorio; solo se permiten menciones de compatibilidad justificadas (por ejemplo, compatibilidad con protocolo MySQL/MariaDB o navegadores estándar HTML5).
2. **Características medibles obligatorias:** cada característica técnica debe expresar **valor objetivo**, **unidad de medida** y **método concreto de verificación** (se prohíben adjetivos vagos como *"rápido"*, *"potente"* o *"alta disponibilidad"* sin métrica).
3. **Trazabilidad a la variante y al caso:** toda cifra de capacidad, concurrencia, almacenamiento o disponibilidad debe derivarse de los parámetros de la variante asignada y del SRS de `asistencia-sena`.

---

## 2. Plantilla de Ficha Técnica (`15` Campos)

> Copia esta estructura para cada componente de software, servicio, hardware o infraestructura de `A2` (`02-fichas-tecnicas.md`) y para la prueba de desempeño.

### Ficha Técnica `[FT-XX]` — `[Nombre genérico del bien, software o servicio]`

| # | Campo | Descripción / Contenido esperado |
| :- | :--- | :--- |
| **1** | **Código de ficha** | Identificador único trazable (ej. `FT-SW-01`, `FT-HW-01`). |
| **2** | **Nombre del componente o servicio** | Denominación genérica sin marca comercial obligatoria (ej. *Servidor virtual de aplicaciones web*). |
| **3** | **Categoría** | `Software propio` / `Servicio de software o nube` / `Hardware` / `Infraestructura de red o respaldo`. |
| **4** | **Versión, fecha y variante** | Versión de la ficha, fecha `AAAA-MM-DD` y variante del escenario (`A`, `B`, `C` o `D`). |
| **5** | **Descripción técnica y función** | Qué hace el componente y qué necesidad operativa del proyecto atiende. |
| **6** | **Ubicación en arquitectura y trazabilidad** | Nodo o componente de la arquitectura (`G2-P1/A4–A6`) y requisitos (`RF`/`RNF`) que soporta. |
| **7** | **Cantidad y unidad de medida** | Cantidad numérica derivada de la variante y unidad exacta (`instancia`, `licencia`, `equipo`, `mes`, `GB/mes`). |
| **8** | **Características técnicas medibles** | Mínimo **6 características** en tabla con: *Parámetro · Valor objetivo · Unidad · Método de verificación*. |
| **9** | **Normas y estándares aplicables** | Referentes legales y técnicos de `A3` que aplican directamente a este componente. |
| **10** | **Compatibilidad e interoperabilidad** | Protocolos, formatos, sistemas operativos, motores o estándares con los que debe operar. |
| **11** | **Requisitos de seguridad y privacidad** | Controles concretos de cifrado en tránsito (`TLS`), autenticación, aislamiento y protección de datos. |
| **12** | **Condiciones de licenciamiento** | Tipo de licencia, modelo de cobro, restricciones y obligaciones de cumplimiento (`A4`). |
| **13** | **Garantía, soporte y ANS** | Plazo de garantía, canal y horario de soporte, tiempo de respuesta/reemplazo y disponibilidad objetivo. |
| **14** | **Condiciones de entrega, instalación y mantenimiento** | Criterios de aceptación en la recepción, entorno requerido y rutina de mantenimiento/respaldos. |
| **15** | **Observaciones, supuestos y exclusiones** | Restricciones de entorno, supuestos de dimensionamiento y elementos explícitamente excluidos. |

#### Subtabla Obligatoria del Campo 8 (Características Técnicas Medibles — Mínimo `6` Filas)

| # | Característica técnica | Valor objetivo | Unidad | Método de verificación |
| :- | :--- | :--- | :--- | :--- |
| 1 | *(ej. Tiempo de respuesta p95 en registro)* | `≤ 2,0` | segundos | Prueba de carga con herramienta HTTP sobre 30 peticiones concurrentes |
| 2 | *(ej. Memoria RAM dedicada)* | `≥ 4` | GiB | Inspección del sistema (`free -h` / panel del proveedor) en recepción |
| 3 | *(ej. Disponibilidad mensual del servicio)* | `≥ 99,5` | % mensual | Reporte de monitor externo HTTP con sondeo cada 60 s |
| 4 | *(ej. Capacidad de almacenamiento SSD/NVMe)* | `≥ 80` | GB | Verificación de volumen montado (`df -h`) al aprovisionamiento |
| 5 | *(ej. Cifrado de transporte)* | `TLS 1.2 / 1.3` | versión de protocolo | Auditoría SSL/TLS en puerto `443` sin cifrados débiles |
| 6 | *(ej. Objetivo de punto de recuperación — RPO)* | `≤ 24` | horas | Revisión de cron de respaldo diario y prueba mensual de restauración |

---

## 3. Verificación del Formato contra `Rubricas_G3.md` (Criterio `C1`)

| Requisito de `Rubricas_G3.md` (`C1` — Nivel 100) | Cumplimiento en este formato |
| :--- | :--- |
| Formato propio de `12` o más campos | **15 campos** estructurados y numerados (`1`–`15`). |
| Incluye identificación y descripción | Campos `1`, `2`, `3`, `4` y `5`. |
| Característica con valor, unidad y método de verificación | Campo `8` + subtabla obligatoria con 4 columnas explícitas. |
| Cantidad y unidad de medida | Campo `7`. |
| Normas o estándares | Campo `9` + declaración de estándares base (`ISO/IEC/IEEE 29148:2018` e `ISO/IEC 25010:2023`). |
| Garantía, compatibilidad y observaciones | Campos `10`, `13` y `15`. |
| Se usará en todas las fichas de `A2` | Se aplicará íntegro a las `4` fichas de `02-fichas-tecnicas.md` (2 de software/servicio y 2 de hardware/infraestructura). |

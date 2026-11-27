# B7 · Lista de Chequeo de Verificación y Registro de Hallazgos (`G2-P1` + `G2-P2`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593102`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Alcance evaluado:** Artefactos de diseño de [`G2-P1-fotocopiadora-syp`](../G2-P1-fotocopiadora-syp/README.md) (`A1`–`A7`) y modelo de datos/seguridad de `G2-P2-fotocopiadora-syp` (`B1`–`B6`).

---

## 1. Lista de Chequeo (`24` Criterios Medibles — Estado Día 1)

| ID | Artefacto | Criterio de aceptación medible | Severidad | Resultado | Evidencia verificable en el repositorio |
| :- | :--- | :--- | :---: | :---: | :--- |
| **LC-01** | `A1` Ficha | Contiene `≥ 8 RF` y `≥ 3 RNF` con su ID del SRS propio, actores y restricciones | Mayor | **Sí** | `G2-P1/01-ficha-interpretacion-y-plataforma.md` lista `12 RF`, `8 RNF` y `5` actores de `G1-P1`. |
| **LC-02** | `A1` Plataforma | Justifica lenguaje OO y tipo de BD con `≥ 3` condiciones concretas del caso | Mayor | **Sí** | `G2-P1/01-ficha...` §2 presenta `4` condiciones reales para Python/FastAPI y BD relacional. |
| **LC-03** | `A2` Clases | Define `≥ 8` clases con visibilidad, atributos tipados, métodos y parámetros | Crítico | **Sí** | `G2-P1/02-diagrama-clases-y-patrones.md` y `.svg` modelan `24` elementos (`21` clases + `3` interfaces). |
| **LC-04** | `A2` Relaciones | Incluye multiplicidades en el 100 % de las asociaciones, herencia, agregación y composición | Mayor | **Sí** | Herencia (`Persona`), `2` agregaciones (`Categoria`, `CarritoCompra`) y `3` composiciones (`Pedido`, `Cotizacion`, `Notificacion`). |
| **LC-05** | `A2` Cohesión | Ninguna clase mezcla UI, negocio, persistencia ni exportación CSV | Crítico | **Sí** | `IRepositorioComercial` y `ExportadorCsvSeguro` aislados de las entidades de dominio. |
| **LC-06** | `A3` Patrones GoF | Aplica `≥ 2` patrones GoF distintos reflejados en el diagrama (al menos 1 ≠ Singleton) | Crítico | **Sí** | **Comando** (`IComandoOperacion`) y **Fábrica Abstracta** (`IFabricaEntregaComercial`), ninguno Singleton. |
| **LC-07** | `A4` Arquitectura | Estilo definido con diagrama, flujo sin saltos de capa y alternativa descartada | Mayor | **Sí** | `G2-P1/03-arquitectura-software.*`: Hexagonal con puertos entrada/salida y `2` alternativas descartadas. |
| **LC-08** | `A4` Tabla RNF | Cubre `≥ 3` RNF con decisión arquitectónica concreta | Mayor | **Sí** | Tabla §2 cubre los `8` RNF (`RNF-01`–`RNF-08`) con decisiones verificables. |
| **LC-09** | `A5` Componentes | Define `≥ 5` componentes con interfaces provistas y requeridas nombradas | Crítico | **Sí** | `G2-P1/04-vista-componentes.*`: `7` componentes e interfaces provistas/requeridas nombradas. |
| **LC-10** | `A6` Despliegue | Modela `≥ 3` nodos con artefactos, puertos/protocolos y relación con RNF | Mayor | **Sí** | `G2-P1/05-vista-despliegue.*`: `5` nodos conectados por `HTTPS 443 (TLS 1.3)` y `TCP 5432` privado. |
| **LC-11** | `A7` Trazabilidad | Cubre el `100 %` de los RF sin clases huérfanas | Mayor | **Sí** | `G2-P1/06-matriz-trazabilidad-diseno.md`: `12/12 RF` y `24/24` clases mapeadas (`0` huérfanas). |
| **LC-12** | `P1` Editables | Todos los diagramas de `G2-P1` poseen archivo `.drawio` editable y `.svg` | Mayor | **Sí** | Archivos `02` a `05` en `.drawio` + `.svg`. |
| **LC-13** | `B1` Conceptual | Modela `≥ 6` entidades con identificador, verbos, cardinalidad mín/máx, `N:M` y `1:N` | Crítico | **Sí** | `G2-P2/01-modelo-conceptual.*`: `11` entidades en Crow's Foot, `2` `N:M`, recursiva y entidad débil. |
| **LC-14** | `B2` Lógico | Contiene `≥ 8` tablas con PK/FK, `N:M` en tablas intermedias y cuadro de reglas | Crítico | **Sí** | `G2-P2/02-modelo-logico-y-transformacion.md`: `12` tablas y `7` reglas aplicadas. |
| **LC-15** | `B3` Normalización | Lleva `≥ 2` tablas propias `0FN → 3FN` con DF escritas (1 llave compuesta + 1 transitiva) | Crítico | **Sí** | `G2-P2/03-normalizacion.md`: `planilla_cotizacion_bruta` (compuesta) y `registro_servicio_tecnico_bruto` (transitiva). |
| **LC-16** | `B4` Diccionario | Documenta el `100 %` de tablas/columnas con estándar, tipo, tamaño, dominio y restricciones | Mayor | **Sí** | `G2-P2/04-diccionario-datos.md`: cubre las `12` tablas idénticas al script SQL. |
| **LC-17** | `B5` DDL y FK | Script SQL crea el `100 %` de tablas con PK, FK (`ON DELETE` en `≥ 3` FK), `UNIQUE` y `≥ 3 CHECK` | Crítico | **Sí** | `05-script-creacion.sql`: `12` tablas, `12` PK, `12` FK con `ON DELETE`, `7` índices/UNIQUE implícitos-explícitos y `33` `CHECK`. |
| **LC-18** | `B5` Ejecución SQL | Evidencia real de ejecución sin errores y pruebas negativas en motor SQL | Crítico | **Sí** | `05-evidencia-ejecucion-sql.md` + `05-log-ejecucion-sqlite.txt` (`ExitCode = 0`, `12/12` tablas, `4/4` `IntegrityError`). |
| **LC-19** | `B6` Seguridad | Define `≥ 6` políticas (`≥ 2` por principio) con hash+sal (`BCrypt`), `TLS`, Ley 1581 y respaldo | Crítico | **Sí** | `G2-P2/06-politicas-seguridad-datos.md` §1: `9` políticas concretas (`3` por principio). |
| **LC-20** | `B6` Roles | Matriz de permisos de `≥ 3` roles frente a todas las tablas del modelo | Mayor | **Sí** | `G2-P2/06-politicas-seguridad-datos.md` §2: `4` roles frente a las `12` tablas. |
| **LC-21** | `P1`–`P2` Privacidad | Repositorio público sin datos personales reales de terceros ni credenciales reales | Crítico | **Sí** | Verificado con escáner automático en `G1`–`G2` (`0` PII real; solo ejemplos `.invalid`). |
| **LC-22** | `P1`–`P2` Autoría | Artefactos diferenciados y trazables al análisis propio sin copiar otros forks | Crítico | **Sí** | GoF propios (`Comando` + `Fábrica Abstracta`), arquitectura Hexagonal y `12` tablas propias. |
| **LC-23** | `P2` Consistencia | Coincidencia exacta de nombres de tablas/columnas entre `B2`, `B4` y `B5` | Mayor | **Sí** | Cruzadas las `12` tablas y todas sus columnas entre modelo lógico, diccionario y DDL. |
| **LC-24** | `P1 ↔ P2` Trazabilidad | Auditoría cruzada explícita `P1 ↔ P2` (componentes/clases contra tablas y políticas `POL-*`) | Menor | **Parcial *(Día 2)*** | **Hallazgo `H-04`:** se programa sección de auditoría cruzada `P1 ↔ P2` en `G2-P1/06-matriz-trazabilidad-diseno.md` para el cierre Día 2 (`2026-11-28` antes `06:00 a. m.`). |

---

## 2. Registro de Hallazgos y Correcciones (`4` Hallazgos)

| ID | Artefacto | Hallazgo detectado | Severidad | Corrección realizada / Estado |
| :- | :--- | :--- | :---: | :--- |
| **`H-01`** | `G2-P1/02-diagrama-clases` | Faltaba separar el exportador CSV con neutralización de fórmulas respecto a las entidades `Pedido` y `Cotizacion`. | Mayor | **Cerrado (`2026-11-27`):** se aisló la clase `ExportadorCsvSeguro` dentro del componente `NucleoNotificacionesExport`. |
| **`H-02`** | `G2-P2/05-script-creacion.sql` | Una cotización o pedido puede provenir de un visitante invitado sin cuenta (`id_usuario IS NULL`). | Crítico | **Cerrado (`2026-11-27`):** se definieron anulables `pedido.id_usuario`, `cotizacion.id_usuario` y `solicitud_servicio.id_usuario` con `ON DELETE SET NULL`. |
| **`H-03`** | `G2-P2/02-modelo-logico` y `B5` | La asociación recursiva `PRODUCTO ↔ PRODUCTO` requería impedir auto-referencias de un producto consigo mismo. | Mayor | **Cerrado (`2026-11-27`):** se creó `compatibilidad_producto(id_equipo, id_insumo)` con `CONSTRAINT ck_comp_distintos CHECK (id_equipo <> id_insumo)`. |
| **`H-04`** | `G2-P1/A7` ↔ `G2-P2/B6` | Añadir tabla de verificación cruzada directa que conecte los `7` componentes y `24` clases de `P1` contra las `12` tablas y `9` políticas `POL-*` de `P2`. | Menor | **Abierto para Día 2 (`2026-11-28 < 06:00 a. m.`):** cerrar junto con el segundo `push` de calendario de G2. |

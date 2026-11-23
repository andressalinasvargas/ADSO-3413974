# A1 · Ficha de Interpretación del Análisis y Plataforma Tecnológica

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-23`  
**Insumo de análisis en este fork:** [00-insumo-srs-base.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-sena/00-insumo-srs-base.md) · [10-informe-analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-sena/10-informe-analisis.md)

---

## 1. Ficha de Interpretación del Análisis

| Elemento | Contenido en el proyecto `asistencia-sena` |
| :--- | :--- |
| **Caso elegido** | Sistema Web de Control de Asistencia SENA (`asistencia-sena`) — Ficha `3413974` |
| **Actores identificados** | **Primarios:** Instructor, Aprendiz, Coordinador Académico. **Secundarios:** Servicio de Geolocalización (GPS del navegador), Temporizador del Sistema. |
| **Restricciones del entorno** | **1. Operación institucional:** debe desplegarse en contenedor ligero Docker o pila estándar Apache/XAMPP sin dependencias pagas.<br>**2. Presupuesto acotado:** uso exclusivo de tecnologías de código abierto sin licenciamiento comercial.<br>**3. Dispositivos heterogéneos:** interfaz móvil responsiva desde `390 px` para aprendices y compatibilidad con cámara o respaldo manual.<br>**4. Marco legal colombiano:** cumplimiento obligatorio de la **Ley Estatutaria 1581 de 2012** y **Decreto 1377 de 2013** (autorización previa, finalidad explícita y borrado lógico).<br>**5. Autoría:** trabajo de diseño individual trazable desde los artefactos de Guía 1. |
| **Entregables de diseño planificados** | **P1:** `A1` Ficha de interpretación y plataforma · `A2` Diagrama de clases (`19` clases/interfaces) · `A3` Patrones GoF (`Estrategia`, `Fachada`) · `A4` Arquitectura 3 capas · `A5` Vista de componentes (`8` componentes) · `A6` Vista de despliegue (`4` nodos) · `A7` Matriz de trazabilidad.<br>**P2:** `B1` Modelo conceptual (`9` entidades) · `B2` Modelo lógico (`10` tablas y reglas) · `B3` Normalización `0FN → 3FN` (`2` casos) · `B4` Diccionario de datos · `B5` Script DDL SQL ejecutado · `B6` Políticas de seguridad y matriz de `4` roles · `B7` Lista de chequeo (`24` criterios) y hallazgos. |

---

## 2. Requisitos Seleccionados del SRS

### 2.1 Requisitos Funcionales (`RF-01` a `RF-12` — Cobertura 100 %)

| ID | Nombre | Descripción corta verificable |
| :--- | :--- | :--- |
| **RF-01** | Autenticación administrativa | Autenticar instructores y coordinadores con usuario y clave personal protegida con hash y sal (`BCrypt`), restringiendo acceso según rol. |
| **RF-02** | Gestión de fichas y aprendices | Crear aprendices con documento único, asignar ficha, emitir token QR individual (`SENA-...`) y aplicar activación/inactivación lógica. |
| **RF-03** | Apertura de sesión de asistencia | Iniciar sesión vinculada a una ficha con hora de inicio, tolerancia configurable, vigencia (+20 min), token QR rotativo y código de 6 dígitos. |
| **RF-04** | Validación de vigencia y ficha | Comprobar en todo canal que la sesión esté activa/vigente, el aprendiz esté activo y pertenezca a la ficha convocada. |
| **RF-05** | Autorregistro móvil del aprendiz | Permitir registro autónomo desde el celular mediante enlace QR rotativo o código de 6 dígitos + número de documento. |
| **RF-06** | Validación de ubicación y consentimiento | Exigir consentimiento previo Ley 1581 y validar distancia Haversine frente a la sede con precisión GPS `≤ 100 m` (cuando aplique). |
| **RF-07** | Prevención de registros duplicados | Garantizar unicidad por par `(aprendiz, sesión)` impidiendo doble registro entre canales móvil, escáner y manual. |
| **RF-08** | Escáner de credencial QR | Leer credencial individual del aprendiz mediante cámara (`BarcodeDetector`) o token ingresado por el instructor en sesión activa. |
| **RF-09** | Registro manual y contingencia | Permitir al instructor propietario registrar asistencia por documento y documentar novedades de contingencia ante fallas o impedimentos. |
| **RF-10** | Cálculo automático de tardanza | Calcular minutos de retraso respecto a `inicia_en + tolerancia_minutos` de forma uniforme en todos los canales. |
| **RF-11** | Cierre manual y automático | Permitir cierre anticipado con protección CSRF/autoría y bloqueo automático tras vencer `vence_en`. |
| **RF-12** | Consulta histórica y reportes | Mostrar lista en vivo, historial filtrable por fecha/ficha/aprendiz, tardanzas, estado de red y exportación de reportes. |

### 2.2 Requisitos No Funcionales (`RNF-01` a `RNF-06`)

| ID | Categoría | Métrica / Criterio verificable |
| :--- | :--- | :--- |
| **RNF-01** | Seguridad y Control de Acceso | `100 %` de módulos administrativos protegidos por sesión, verificación de propietario en cierre/contingencia, tokens CSRF y sentencias preparadas nativas. |
| **RNF-02** | Cumplimiento Legal (Habeas Data) | `100 %` de autorregistros móviles exigen aceptación previa (`consentimiento_datos = 1`), política visible y preservación histórica mediante borrado lógico. |
| **RNF-03** | Rendimiento y Respuesta | Respuesta `≤ 2 s` en validación de registro y consultas en red local con concurrencia de inicio de jornada (`30+` aprendices). |
| **RNF-04** | Usabilidad Móvil | Flujo del aprendiz completado en `≤ 3 pasos` y adaptable sin desbordamiento horizontal desde `390 px` de ancho. |
| **RNF-05** | Disponibilidad y Contingencia | Disponibilidad continua de canales de respaldo (código de 6 dígitos y registro manual con novedad) cuando falle GPS o cámara. |
| **RNF-06** | Integridad y Trazabilidad de Auditoría | Registro inmutable de `fecha_hora`, `canal_registro`, `tarde_minutos`, `ip_origen`, `estado_red` y geolocalización por asistencia. |

---

## 3. Selección y Justificación de la Plataforma Tecnológica

### 3.1 Lenguaje Orientado a Objetos: **PHP 8.3 (POO con tipado estricto e interfaces)**

Justificación basada en **4 condiciones concretas del caso `asistencia-sena`**:
1. **Alineación con infraestructura SENA existente (`A6`, `RNF-05`):** corre nativamente sobre `Apache 2.4` en contenedor Docker ligero o entornos de formación XAMPP/WAMP sin procesos complejos de compilación ni sobrecarga de memoria.
2. **Soporte completo de diseño orientado a objetos (`A2`, `A3`):** PHP 8.3 soporta clases abstractas (`Persona`), interfaces (`IEstrategiaRegistro`, `IRepositorioAsistencia`), tipado estricto en atributos/parámetros/retornos, tipos anulables (`?float`, `?DateTimeImmutable`) y polimorfismo para desacoplar los 3 canales de registro.
3. **Seguridad criptográfica y acceso seguro nativo (`RNF-01`, `RNF-02`):** incluye `password_hash()`/`password_verify()` con algoritmo `BCrypt` (hash + sal automática), `random_bytes()` CSPRNG para tokens QR/sesión, `hash_equals()` contra ataques de temporización en CSRF y extensión **PDO nativa** con `ATTR_EMULATE_PREPARES => false` contra inyección SQL.
4. **Latencia baja en peticiones transaccionales (`RNF-03`):** el modelo petición-respuesta sin carga de máquina virtual pesada permite validar asistencia y responder JSON o HTML en milisegundos, cumpliendo el umbral de `≤ 2 s`.

### 3.2 Tipo de Base de Datos: **Relacional — MariaDB 10.11 / MySQL (Motor `InnoDB`)**

Justificación basada en **4 condiciones concretas del caso `asistencia-sena`**:
1. **Estructura relacional fija y altamente vinculada (`B1`, `B2`):** las entidades del dominio (`programa_formacion`, `sede`, `ficha`, `usuario_sistema`, `aprendiz`, `sesion_asistencia`, `registro_asistencia`, `novedad_contingencia`) tienen relaciones `1:N` y `N:M` estables que requieren llaves foráneas explícitas.
2. **Garantía de unicidad e idempotencia en motor (`RF-07`):** la restricción compuesta `UNIQUE (id_aprendiz, id_sesion)` en `registro_asistencia` impide duplicados incluso ante envíos simultáneos desde móvil y escáner en la misma clase.
3. **Integridad referencial y restricciones de dominio (`RNF-06`):** `InnoDB` soporta acciones `ON DELETE RESTRICT / SET NULL / CASCADE` y restricciones `CHECK` en coordenadas GPS, tolerancias y tardanzas, impidiendo datos huérfanos o inconsistentes.
4. **Concurrencia transaccional ACID (`RNF-03`):** el bloqueo a nivel de fila de `InnoDB` soporta ráfagas simultáneas de registros al comienzo de cada formación sin bloquear toda la tabla de asistencias ni corromper auditorías históricas.

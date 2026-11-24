# A7 · Matriz de Trazabilidad Completa: Análisis → Diseño

**Proyecto:** Sistema Web de Control de Asistencia SENA (`asistencia-sena`)  
**Producto:** G2-P1 · Artefactos de diseño (`RAP 593103`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-24` *(Actualizada con trazabilidad cruzada P1 ↔ P2 en Día 2)*  
**Cobertura verificada:** **12 / 12 RF (100 %)** · **6 / 6 RNF (100 %)** · **19 / 19 Clases/Interfaces trazadas (0 huérfanas)**.

---

## 1. Trazabilidad Hacia Adelante (Requisitos → Clases, Tablas, Componentes y Decisiones)

| Requisito | Clase(s) / Interfaz(ces) (`A2`) | Tabla(s) (`G2-P2 / B2`) | Componente(s) (`A5`) | Decisión / Patrón (`A3`, `A4`, `A6`) |
| :--- | :--- | :--- | :--- | :--- |
| **RF-01** Autenticación administrativa | `Persona`, `UsuarioSistema`, `IRepositorioAsistencia` | `usuario_sistema` | `WebAppInstructor`, `ModuloAutenticacion`, `ModuloPersistenciaPDO` | Herencia `Persona` + `BCrypt` (`password_hash` con sal) + sesión `HttpOnly` |
| **RF-02** Gestión de fichas y aprendices | `Persona`, `Aprendiz`, `ProgramaFormacion`, `SedeFormacion`, `FichaFormacion`, `AsignacionInstructor` | `programa_formacion`, `sede`, `ficha`, `aprendiz`, `telefono_aprendiz`, `asignacion_instructor_ficha` | `WebAppInstructor`, `ModuloGestionAcademica`, `ModuloPersistenciaPDO` | Agregación `FichaFormacion o-- Aprendiz` + borrado lógico (`activo = 0`) + token QR CSPRNG |
| **RF-03** Apertura de sesión de asistencia | `UsuarioSistema`, `FichaFormacion`, `SesionAsistencia`, `FachadaControlAsistencia` | `sesion_asistencia` | `WebAppInstructor`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Patrón **Fachada** (`abrirSesion`) + token 40 hex + código 6 dígitos + vigencia |
| **RF-04** Validación de vigencia y pertenencia a ficha | `FachadaControlAsistencia`, `SesionAsistencia`, `Aprendiz`, `FichaFormacion`, `IRepositorioAsistencia` | `sesion_asistencia`, `aprendiz`, `ficha` | `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Validación uniforme previa al registro en los 3 canales dentro de la fachada |
| **RF-05** Autorregistro móvil del aprendiz | `FachadaControlAsistencia`, `IEstrategiaRegistro`, `EstrategiaMovilQr`, `RegistroAsistencia`, `Aprendiz` | `sesion_asistencia`, `aprendiz`, `registro_asistencia` | `WebAppMovilAprendiz`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Patrón **Estrategia** (`EstrategiaMovilQr`) + interfaz responsiva móvil `≤ 3 pasos` |
| **RF-06** Validación de ubicación y consentimiento | `EstrategiaMovilQr`, `ValidadorGeocerca`, `SedeFormacion`, `RegistroAsistencia` | `sede`, `registro_asistencia` | `WebAppMovilAprendiz`, `ModuloValidacionGeoRed`, `ModuloControlAsistencia` | Fórmula Haversine + precisión `≤ 100 m` + aceptación previa Ley 1581 + `HTTPS 443` |
| **RF-07** Prevención de registros duplicados | `FachadaControlAsistencia`, `IRepositorioAsistencia`, `SesionAsistencia`, `RegistroAsistencia` | `registro_asistencia` (`UNIQUE (id_aprendiz, id_sesion)`) | `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Composición `SesionAsistencia *-- RegistroAsistencia` + llave única en `InnoDB` (`SQLSTATE 23000`) |
| **RF-08** Registro por escáner QR del instructor | `FachadaControlAsistencia`, `IEstrategiaRegistro`, `EstrategiaEscanerQr`, `Aprendiz`, `RegistroAsistencia` | `aprendiz`, `sesion_asistencia`, `registro_asistencia` | `WebAppInstructor`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Patrón **Estrategia** (`EstrategiaEscanerQr`) + API `BarcodeDetector` en `Cliente Escritorio` + `escHtml()` |
| **RF-09** Registro manual y novedades de contingencia | `FachadaControlAsistencia`, `IEstrategiaRegistro`, `EstrategiaManualContingencia`, `RegistroAsistencia`, `NovedadContingencia` | `registro_asistencia`, `novedad_contingencia` | `WebAppInstructor`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Patrón **Estrategia** (`EstrategiaManualContingencia`) + composición `RegistroAsistencia *-- NovedadContingencia` + verificación propietario |
| **RF-10** Cálculo automático de tardanza | `FachadaControlAsistencia`, `CalculadorTardanza`, `SesionAsistencia`, `RegistroAsistencia` | `sesion_asistencia`, `registro_asistencia` | `ModuloControlAsistencia` | Servicio cohesivo `CalculadorTardanza` invocado por la fachada en los 3 canales |
| **RF-11** Cierre manual y automático de sesión | `FachadaControlAsistencia`, `SesionAsistencia`, `UsuarioSistema`, `IRepositorioAsistencia` | `sesion_asistencia` | `WebAppInstructor`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | Validación `check_csrf()` + propiedad (`id_usuario`) + expiración por `vence_en` |
| **RF-12** Consulta histórica y reportes | `ServicioReportes`, `IRepositorioAsistencia`, `FichaFormacion`, `RegistroAsistencia`, `NovedadContingencia` | `ficha`, `aprendiz`, `sesion_asistencia`, `registro_asistencia`, `novedad_contingencia` | `WebAppInstructor`, `ModuloReportesAuditoria`, `ModuloPersistenciaPDO` | Separación de reportes en `ServicioReportes` (no contamina clases de dominio ni persistencia) |
| **RNF-01** Seguridad y Control de Acceso | `UsuarioSistema`, `FachadaControlAsistencia`, `IRepositorioAsistencia`, `ValidadorGeocerca` | `usuario_sistema`, `sesion_asistencia`, `registro_asistencia` | `ModuloAutenticacion`, `ModuloControlAsistencia`, `ModuloPersistenciaPDO` | 3 capas estrictas + PDO nativo (`ATTR_EMULATE_PREPARES => false`) + `.htaccess 403` + `TLS 1.3` |
| **RNF-02** Cumplimiento Legal (Habeas Data) | `Aprendiz`, `FichaFormacion`, `EstrategiaMovilQr`, `RegistroAsistencia` | `aprendiz`, `ficha`, `registro_asistencia` | `WebAppMovilAprendiz`, `ModuloGestionAcademica`, `ModuloControlAsistencia` | Aceptación previa obligatoria (`consentimiento_datos = 1`) + borrado lógico (`activo = 0`) |
| **RNF-03** Rendimiento (`≤ 2 s`) | `IRepositorioAsistencia`, `ServicioReportes`, `FachadaControlAsistencia` | Todas (índices PK/UK/FK e índice en `fecha_hora`) | `ModuloPersistenciaPDO`, `ModuloControlAsistencia`, `ModuloReportesAuditoria` | Eliminación de DDL en peticiones HTTP + PDO *singleton* + `InnoDB` con bloqueo por fila |
| **RNF-04** Usabilidad Móvil | `EstrategiaMovilQr`, `ValidadorGeocerca` | `sesion_asistencia`, `registro_asistencia` | `WebAppMovilAprendiz`, `WebAppInstructor` | Vistas responsivas `≥ 390 px`, flujo móvil `≤ 3 pasos`, mensajes claros en español |
| **RNF-05** Disponibilidad y Contingencia | `IEstrategiaRegistro`, `EstrategiaMovilQr`, `EstrategiaEscanerQr`, `EstrategiaManualContingencia`, `NovedadContingencia` | `sesion_asistencia`, `registro_asistencia`, `novedad_contingencia` | `ModuloControlAsistencia`, `WebAppMovilAprendiz`, `WebAppInstructor` | Multicanal polimórfico (código 6 dígitos + escáner + manual) + *healthcheck* Docker |
| **RNF-06** Integridad y Auditoría | `RegistroAsistencia`, `NovedadContingencia`, `ValidadorGeocerca`, `CalculadorTardanza`, `IRepositorioAsistencia` | `registro_asistencia`, `novedad_contingencia`, `sesion_asistencia` | `ModuloControlAsistencia`, `ModuloValidacionGeoRed`, `ModuloPersistenciaPDO` | Restricciones `CHECK` + `ON DELETE` + marca temporal, IP, red y tardanza en servidor |

---

## 2. Trazabilidad Hacia Atrás (Clases / Interfaces → Requisitos)

Verificación de que **ninguna de las 19 clases o interfaces** de `A2` carece de requisito que la justifique:

| # | Clase / Interfaz (`A2`) | Componente que la agrupa (`A5`) | Requisito(s) que justifica(n) su existencia | Estado |
| :- | :--- | :--- | :--- | :---: |
| 1 | `Persona` (`{abstract}`) | `ModuloAutenticacion` | `RF-01`, `RF-02`, `RNF-02` | ✅ Trazada |
| 2 | `UsuarioSistema` | `ModuloAutenticacion` | `RF-01`, `RF-03`, `RF-09`, `RF-11`, `RNF-01` | ✅ Trazada |
| 3 | `Aprendiz` | `ModuloGestionAcademica` | `RF-02`, `RF-04`, `RF-05`, `RF-08`, `RNF-02` | ✅ Trazada |
| 4 | `ProgramaFormacion` | `ModuloGestionAcademica` | `RF-02`, `RF-12` | ✅ Trazada |
| 5 | `SedeFormacion` | `ModuloGestionAcademica` | `RF-02`, `RF-06`, `RNF-06` | ✅ Trazada |
| 6 | `FichaFormacion` | `ModuloGestionAcademica` | `RF-02`, `RF-03`, `RF-04`, `RF-12`, `RNF-02` | ✅ Trazada |
| 7 | `AsignacionInstructor` | `ModuloGestionAcademica` | `RF-02`, `RF-03`, `RNF-01` | ✅ Trazada |
| 8 | `SesionAsistencia` | `ModuloControlAsistencia` | `RF-03`, `RF-04`, `RF-07`, `RF-10`, `RF-11` | ✅ Trazada |
| 9 | `RegistroAsistencia` | `ModuloControlAsistencia` | `RF-05`, `RF-06`, `RF-07`, `RF-08`, `RF-09`, `RF-10`, `RF-12`, `RNF-02`, `RNF-06` | ✅ Trazada |
| 10 | `NovedadContingencia` | `ModuloControlAsistencia` | `RF-09`, `RF-12`, `RNF-05`, `RNF-06` | ✅ Trazada |
| 11 | `IEstrategiaRegistro` (`<<interface>>`) | `ModuloControlAsistencia` | `RF-05`, `RF-08`, `RF-09`, `RNF-05` | ✅ Trazada |
| 12 | `EstrategiaMovilQr` | `ModuloControlAsistencia` | `RF-05`, `RF-06`, `RNF-02`, `RNF-04` | ✅ Trazada |
| 13 | `EstrategiaEscanerQr` | `ModuloControlAsistencia` | `RF-08`, `RNF-05` | ✅ Trazada |
| 14 | `EstrategiaManualContingencia` | `ModuloControlAsistencia` | `RF-09`, `RNF-05`, `RNF-06` | ✅ Trazada |
| 15 | `ValidadorGeocerca` | `ModuloValidacionGeoRed` | `RF-06`, `RNF-01`, `RNF-06` | ✅ Trazada |
| 16 | `CalculadorTardanza` | `ModuloControlAsistencia` | `RF-10`, `RNF-06` | ✅ Trazada |
| 17 | `IRepositorioAsistencia` (`<<interface>>`) | `ModuloPersistenciaPDO` | `RF-01`–`RF-12`, `RNF-01`, `RNF-03`, `RNF-06` | ✅ Trazada |
| 18 | `ServicioReportes` | `ModuloReportesAuditoria` | `RF-12`, `RNF-03`, `RNF-06` | ✅ Trazada |
| 19 | `FachadaControlAsistencia` | `ModuloControlAsistencia` | `RF-03`, `RF-04`, `RF-05`, `RF-07`, `RF-08`, `RF-09`, `RF-10`, `RF-11`, `RNF-01`, `RNF-05` | ✅ Trazada |

---

## 3. Trazabilidad Cruzada `P1 ↔ P2` (Verificación Día 2 · `2026-11-24`)

Comprobación bidireccional entre los **8 componentes** / **19 clases e interfaces** de `G2-P1` y las **10 tablas relacionales** + **9 políticas de seguridad (`POL-*`)** definidas en `G2-P2`:

| Componente (`A5`) | Clases / Interfaces asociadas (`A2`/`A3`) | Tabla(s) en `G2-P2` (`B2`/`B4`/`B5`) | Políticas de seguridad aplicadas (`G2-P2/B6`) | Verificación cruzada |
| :--- | :--- | :--- | :--- | :---: |
| **`WebAppInstructor`** | Controladores UI desktop (consumen `IAutenticacion`, `IGestionAcademica`, `IFachadaAsistencia`, `IReportesAuditoria`) | Indirecto vía lógica; sin acceso directo SQL a tablas | `POL-CON-02` (TLS 1.3, cookies `HttpOnly`), `POL-DIS-03` | ✅ Consistente |
| **`WebAppMovilAprendiz`** | Vistas móviles HTML5 + Geolocation API (consumen `IFachadaAsistencia`) | Indirecto vía `FachadaControlAsistencia` | `POL-CON-02`, `POL-CON-03` (Ley 1581 y consentimiento previo), `POL-DIS-03` | ✅ Consistente |
| **`ModuloAutenticacion`** | `Persona` (`{abstract}`), `UsuarioSistema` | `usuario_sistema` | `POL-CON-01` (hash+sal `BCrypt`/`Argon2id`), `POL-INT-02` (borrado lógico `activo`), `POL-CON-02` | ✅ Consistente |
| **`ModuloGestionAcademica`** | `ProgramaFormacion`, `SedeFormacion`, `FichaFormacion`, `Aprendiz`, `AsignacionInstructor` | `programa_formacion`, `sede`, `ficha`, `aprendiz`, `telefono_aprendiz`, `asignacion_instructor_ficha` | `POL-INT-01` (`FK` y `CHECK` geocerca), `POL-INT-02` (borrado lógico), `POL-CON-03` | ✅ Consistente |
| **`ModuloControlAsistencia`** | `FachadaControlAsistencia`, `SesionAsistencia`, `RegistroAsistencia`, `NovedadContingencia`, `IEstrategiaRegistro`, `EstrategiaMovilQr`, `EstrategiaEscanerQr`, `EstrategiaManualContingencia`, `CalculadorTardanza` | `sesion_asistencia`, `registro_asistencia`, `novedad_contingencia` | `POL-INT-01` (`CHECK` fechas/canal/tardanza, `ON DELETE CASCADE` solo en `novedad_contingencia`), `POL-INT-02` (`uk_reg_aprendiz_sesion`), `POL-INT-03`, `POL-DIS-03` | ✅ Consistente |
| **`ModuloValidacionGeoRed`** | `ValidadorGeocerca` | `sede`, `registro_asistencia` | `POL-INT-01` (`ck_sede_lat`, `ck_sede_lng`, `ck_reg_precision`), `POL-INT-03` (`ip_origen`, `estado_red`), `POL-CON-03` | ✅ Consistente |
| **`ModuloReportesAuditoria`** | `ServicioReportes` | Lectura sobre `programa_formacion`, `sede`, `ficha`, `aprendiz`, `sesion_asistencia`, `registro_asistencia`, `novedad_contingencia` | `POL-INT-03` (registros históricos inmutables), `POL-CON-01` (nunca expone `password_hash`), Matriz 4 roles (`Coordinador`) | ✅ Consistente |
| **`ModuloPersistenciaPDO`** | `IRepositorioAsistencia` | Las `10` tablas en `05-script-creacion.sql` (`InnoDB`) | `POL-INT-01`, `POL-CON-02` (PDO nativo `ATTR_EMULATE_PREPARES => false`), `POL-DIS-01`, `POL-DIS-02` (respaldos `mysqldump` y prueba mensual) | ✅ Consistente |

**Resultado de auditoría Día 2 (`2026-11-24`):** `8/8` componentes, `19/19` clases/interfaces, `10/10` tablas y `9/9` políticas de seguridad (`POL-INT-*`, `POL-CON-*`, `POL-DIS-*`) trazadas sin huérfanos ni saltos de capa (`24/24` criterios cumplidos en [`G2-P2/07-lista-chequeo-verificacion.md`](../G2-P2-asistencia-sena/07-lista-chequeo-verificacion.md)).

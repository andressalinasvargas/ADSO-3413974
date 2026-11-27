# A3 · Referente Técnico y Marco Normativo — Fotocopiadora SyP

> **Fecha de verificación:** `2026-11-27`  
> **Alcance:** Consolidación del marco normativo externo vigente (legal y técnico) aplicable al sistema de información **Fotocopiadora SyP**, separado estrictamente de las `9` políticas internas de seguridad de datos (`POL-INT-01..03`, `POL-CON-01..03` y `POL-DIS-01..03`) definidas en la fase de base de datos ([`06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/06-politicas-seguridad-datos.md)).

---

## 1. Marco normativo externo aplicable (`6` referentes verificados)

| # | Referente normativo / estándar | Ámbito | Disposición clave aplicable a Fotocopiadora SyP | Impacto directo en diseño y contrato |
|---:|---|---|---|---|
| **1** | **Ley 1581 de 2012 y Decreto 1074 de 2015** (Reglamentario del Sector Comercio, Industria y Turismo, Título V) | Legal — Colombia (Hábeas Data) | Regula el tratamiento de datos personales (`usuario`, `solicitud_servicio`, `mensaje_contacto`, `pedido`, `cotizacion`) bajo los principios de finalidad, autorización previa, expresa e informada, seguridad y temporalidad. **Distinción obligatoria entre transmisión y transferencia:** cuando un proveedor de nube, respaldo o mensajería procesa datos por cuenta de Fotocopiadora SyP (como *encargado*), opera una **transmisión** nacional o internacional regulada por contrato de encargo; cuando los datos se entregan a otro *responsable* autónomo, constituye una **transferencia** que exige autorización específica o país con nivel adecuado de protección. | Aviso de privacidad visible en registro/contacto, cláusula de encargo de tratamiento en TdR (`B6`), enmascaramiento `is_owner`, minimización de PII y borrado/desactivación lógica bajo solicitud del titular. |
| **2** | **Ley 23 de 1982** (sobre Derechos de Autor en Colombia) | Legal — Colombia | Protege las obras originales literarias, científicas y de ingeniería de software, garantizando al autor derechos morales (irrenunciables) y derechos patrimoniales (disponibles por cesión escrita). | Exige cláusula expresa de cesión o licencia de derechos patrimoniales sobre código fuente, diagramas, scripts SQL y manuales entregados a Fotocopiadora SyP. |
| **3** | **Decisión Andina 351 de 1993** (Régimen Común sobre Derecho de Autor y Derechos Conexos) | Legal — Comunidad Andina | Equipara expresamente los programas de ordenador (código fuente y código objeto) y su documentación técnica a las obras literarias protegidas, estableciendo la exigencia de transferencia escrita para el ejercicio de derechos patrimoniales. | Sustenta la estrategia de licencia propietaria para el desarrollo a la medida y obliga a mantener inventario limpio de bibliotecas de terceros sin contaminación copyleft (`A4`). |
| **4** | **WCAG 2.2 Nivel AA e ISO/IEC 25010:2023** | Técnico internacional | `WCAG 2.2 AA` define criterios verificables de accesibilidad web (perceptible, operable, comprensible, robusto: contraste mínimo `4.5:1`, navegación completa por teclado, foco visible y etiquetas en formularios de servicio/cotización). `ISO/IEC 25010:2023` estandariza el modelo de calidad del software (adecuación funcional, eficiencia de desempeño, compatibilidad, capacidad de interacción, fiabilidad, seguridad, mantenibilidad y flexibilidad). | Orienta la auditoría visual de interfaz web responsiva (`RNF-02`, `RNF-03`) y fija umbrales cuantificables de latencia (`p95 <= 1,5 s`), disponibilidad (`99,5 %` escenario B) y cobertura de pruebas. |
| **5** | **Ley 527 de 1999** (Comercio Electrónico, Mensajes de Datos y Firmas Digitales) | Legal — Colombia | Otorga equivalencia funcional, validez jurídica y fuerza probatoria a los mensajes de datos, siempre que la información sea accesible para su posterior consulta y conserve integridad. | Respalda la validez de cotizaciones electrónicas (`cotizacion`), órdenes de pedido (`pedido`), notificaciones de estado (`notificacion`) y trazabilidad histórica de precios pactados. |
| **6** | **Ley 1480 de 2011** (Estatuto del Consumidor en Colombia) | Legal — Colombia | Obliga a informar de manera clara, veraz y suficiente los precios totales incluidos impuestos (`COP`), especificaciones técnicas, compatibilidad de consumibles, garantías legales y condiciones de envío o derecho de retracto en ventas electrónicas. | Justifica el desglose explícito de `subtotal`, `iva` (`19 %`), `total`, `vigencia_dias` (`CHECK ck_cot_vig`) y `precio_unitario_pactado` / `precio_unitario_cotizado` (`05-script-creacion.sql`), además de la compatibilidad `compatibilidad_producto`. |

---

## 2. Separación estricta frente a las `9` políticas internas de seguridad (`G2-P2`)

Para evitar confundir regulación pública obligatoria con controles organizacionales propios de Fotocopiadora SyP, los controles técnicos internos se mantienen desacoplados según las `9` políticas definidas en [`06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/06-politicas-seguridad-datos.md):

| Políticas internas (`G2-P2`) | Principio / Naturaleza | Relación con el marco normativo externo |
|---|---|---|
| **`POL-INT-01`, `POL-INT-02`, `POL-INT-03`** *(Integridad en motor, desactivación lógica y recálculo de servidor)* | Controles internos de integridad de datos (`12` FK, `33` `CHECK`, `uk_rep_usuario_eq_mes`, precios recalculados en servidor) | Soportan el cumplimiento práctico de `Ley 1480/2011` (información veraz y precios consistentes al consumidor) y `Ley 527/1999`. |
| **`POL-CON-01`, `POL-CON-02`, `POL-CON-03`** *(`BCrypt` hash+sal, `TLS 1.3`, cookie `HttpOnly` `syp_session`, `is_owner`, CSV seguro)* | Controles internos de confidencialidad y acceso RBAC | Implementan el principio de seguridad, autorización y reserva de datos exigido por `Ley 1581/2012`, `Decreto 1074/2015` e `ISO/IEC 25010:2023`. |
| **`POL-DIS-01`, `POL-DIS-02`, `POL-DIS-03`** *(Respaldo `02:00 COT` `AES-256`, prueba mensual de restauración, contingencia estática `RNF-06`)* | Controles internos de disponibilidad y continuidad | Garantizan accesibilidad íntegra para consulta posterior (`Ley 527/1999`) y resiliencia exigida por `ISO/IEC 25010:2023`. |

---

## 3. Matriz de verificación normativa sobre componentes de Fotocopiadora SyP

| Componente del sistema (`G2-P1`) | Normativa vinculante | Mecanismo concreto de cumplimiento |
|---|---|---|
| **`WebCatalogoPWA` y `PanelAdminWeb`** | `WCAG 2.2 AA`, `Ley 1480/2011`, `RNF-02`, `RNF-03` | Etiquetas semánticas HTML5, contraste `>= 4.5:1`, operación por teclado, formato `es-CO`/`COP` y desglose de `subtotal`, `iva` y `total` antes de confirmar compra. |
| **`NucleoIdentidadAcceso` (`FastAPI`)** | `Ley 1581/2012`, `ISO/IEC 25010:2023`, `POL-CON-01..03` | Validación estricta con Pydantic, hash+sal `BCrypt`, cookie `HttpOnly` `syp_session` sobre `TLS 1.3` y enmascaramiento de PII con control `is_owner`. |
| **`AdaptadorPersistenciaSQL` (`PostgreSQL 16`)** | `Ley 1581/2012`, `Decreto 1074/2015`, `POL-INT-01..02` | Cifrado en reposo, claves foráneas con restricciones `ON DELETE RESTRICT/CASCADE/SET NULL`, unicidad `uk_rep_usuario_eq_mes` y red privada `TCP 5432`. |
| **`NucleoPedidosCotizaciones` (`Pedido` / `Cotizacion`)** | `Ley 527/1999`, `Ley 1480/2011`, `POL-INT-03` | Códigos únicos inmutables (`codigo_pedido`, `codigo_cotizacion`), vigencia `vigencia_dias` (`1..90`) y snapshot histórico de `precio_unitario_pactado` / `precio_unitario_cotizado`. |
| **Código fuente y artefactos de ingeniería** | `Ley 23/1982`, `Decisión Andina 351/1993` | Declaración de autoría moral, cesión escrita de derechos patrimoniales y dependencias exclusivamente con licencias permisivas (`MIT`/`BSD`/`Apache-2.0`). |

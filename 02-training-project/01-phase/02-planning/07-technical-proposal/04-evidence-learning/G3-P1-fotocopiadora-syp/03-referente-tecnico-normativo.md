# A3 · Referente Técnico y Marco Normativo — Fotocopiadora SyP

> **Fecha de verificación:** `2026-11-27`  
> **Alcance:** Consolidación del marco normativo externo vigente (legal y técnico) aplicable al sistema de información **Fotocopiadora SyP**, separado estrictamente de las políticas internas de gobierno de datos (`GOB-SYP-01` a `GOB-SYP-04`) definidas en la fase de base de datos ([`06-politicas-seguridad-datos.md`](../../../06-architecture/04-evidence-learning/G2-P2-fotocopiadora-syp/06-politicas-seguridad-datos.md)).

---

## 1. Marco normativo externo aplicable (`6` referentes verificados)

| # | Referente normativo / estándar | Ámbito | Disposición clave aplicable a Fotocopiadora SyP | Impacto directo en diseño y contrato |
|---:|---|---|---|---|
| **1** | **Ley 1581 de 2012 y Decreto 1074 de 2015** (Reglamentario del Sector Comercio, Industria y Turismo, Título V) | Legal — Colombia (Hábeas Data) | Regula el tratamiento de datos personales (`usuario`, `solicitud_servicio`, `mensaje_contacto`, `pedido`) bajo los principios de finalidad, autorización previa, expresa e informada, seguridad y temporalidad. **Distinción obligatoria entre transmisión y transferencia:** cuando un proveedor de nube, respaldo o mensajería procesa datos por cuenta de Fotocopiadora SyP (como *encargado*), opera una **transmisión** nacional o internacional regulada por contrato de encargo; cuando los datos se entregan a otro *responsable* autónomo, constituye una **transferencia** que exige autorización específica o país con nivel adecuado de protección. | Aviso de privacidad visible en registro/contacto, cláusula de encargo de tratamiento en TdR (`B6`), minimización de PII y borrado/anonimización bajo solicitud del titular. |
| **2** | **Ley 23 de 1982** (sobre Derechos de Autor en Colombia) | Legal — Colombia | Protege las obras originales literarias, científicas y de ingeniería de software, garantizando al autor derechos morales (irrenunciables) y derechos patrimoniales (disponibles por cesión escrita). | Exige cláusula expresa de cesión o licencia de derechos patrimoniales sobre código fuente, diagramas, scripts SQL y manuales entregados a Fotocopiadora SyP. |
| **3** | **Decisión Andina 351 de 1993** (Régimen Común sobre Derecho de Autor y Derechos Conexos) | Legal — Comunidad Andina | Equipara expresamente los programas de ordenador (código fuente y código objeto) y su documentación técnica a las obras literarias protegidas, estableciendo la presunción o exigencia de transferencia escrita para el ejercicio de derechos patrimoniales. | Sustenta la estrategia de licencia propietaria para el desarrollo a la medida y obliga a mantener inventario limpio de bibliotecas de terceros sin contaminación copyleft (`A4`). |
| **4** | **WCAG 2.2 Nivel AA e ISO/IEC 25010:2023** | Técnico internacional | `WCAG 2.2 AA` define criterios verificables de accesibilidad web (perceptible, operable, comprensible, robusto: contraste mínimo `4.5:1`, navegación completa por teclado, etiquetas en formularios de servicio/cotización y texto alternativo en catálogo). `ISO/IEC 25010:2023` estandariza el modelo de calidad del software (adecuación funcional, eficiencia, compatibilidad, interacción, fiabilidad, seguridad, mantenibilidad y flexibilidad). | Orienta la auditoría visual de interfaz web responsiva y fija umbrales cuantificables de latencia (`p95 <= 1,5 s`), disponibilidad (`99,5 %` escenario B) y cobertura de pruebas. |
| **5** | **Ley 527 de 1999** (Comercio Electrónico, Mensajes de Datos y Firmas Digitales) | Legal — Colombia | Otorga equivalencia funcional, validez jurídica y fuerza probatoria a los mensajes de datos, siempre que la información sea accesible para su posterior consulta y conserve integridad. | Respalda la validez de cotizaciones electrónicas (`cotizacion`), órdenes de pedido (`pedido`), notificaciones de estado (`notificacion`) y trazabilidad de aceptación del cliente. |
| **6** | **Ley 1480 de 2011** (Estatuto del Consumidor en Colombia) | Legal — Colombia | Obliga a informar de manera clara, veraz y suficiente los precios totales incluidos impuestos, especificaciones técnicas, compatibilidad de consumibles, garantías legales y condiciones de envío o derecho de retracto en ventas electrónicas. | Justifica el desglose explícito de `subtotal`, `iva`, `total` y `vigencia_hasta` en pedidos/cotizaciones (`05-script-creacion.sql`) y la ficha técnica visible en el catálogo (`producto`). |

---

## 2. Separación estricta frente a políticas internas de gobierno de datos (`G2-P2`)

Para evitar confundir regulación pública obligatoria con controles organizacionales propios de Fotocopiadora SyP, los controles internos permanecen desacoplados como lineamientos de gobierno institucional:

| Política interna (`G2-P2`) | Naturaleza | Relación con el marco normativo externo |
|---|---|---|
| `GOB-SYP-01` (Integridad de precios, stock y compatibilidad de consumibles) | Regla interna de negocio / datos | Soporta cumplimiento práctico de `Ley 1480/2011` (información veraz al consumidor). |
| `GOB-SYP-02` (Control de acceso RBAC y protección de credenciales `bcrypt` / `JWT`) | Política interna de seguridad | Implementa el principio de seguridad y acceso restringido exigido por `Ley 1581/2012` e `ISO/IEC 25010:2023`. |
| `GOB-SYP-03` (Conservación auditable de pedidos, cotizaciones y reportes de contador) | Política interna de retención | Garantiza accesibilidad íntegra para consulta posterior exigida por `Ley 527/1999`. |
| `GOB-SYP-04` (Cero PII en ambientes de prueba y respaldos cifrados) | Política interna de desarrollo y operación | Reduce superficie de riesgo en cumplimiento del principio de seguridad de `Ley 1581/2012`. |

---

## 3. Matriz de verificación normativa sobre componentes de Fotocopiadora SyP

| Componente del sistema (`G2-P1`) | Normativa vinculante | Mecanismo concreto de cumplimiento |
|---|---|---|
| **Interfaz Web Cliente y Portal Admin** | `WCAG 2.2 AA`, `Ley 1480/2011` | Etiquetas semánticas HTML5, contraste AA, desglose transparente de precios e IVA antes de confirmar compra. |
| **API Núcleo Hexagonal (FastAPI)** | `Ley 1581/2012`, `Ley 527/1999`, `ISO/IEC 25010:2023` | Validación estricta con Pydantic, tokens JWT con expiración acotada, registro de eventos con marca temporal UTC. |
| **Base de Datos PostgreSQL 16** | `Ley 1581/2012`, `Decreto 1074/2015` | Cifrado en reposo, claves foráneas con restricciones `ON DELETE RESTRICT/CASCADE`, contraseñas con `bcrypt`. |
| **Módulo de Cotizaciones y Pedidos** | `Ley 527/1999`, `Ley 1480/2011` | Códigos únicos inmutables (`codigo_pedido`, `codigo_cotizacion`), fecha `vigencia_hasta` y snapshot histórico de `precio_unitario`. |
| **Código fuente y artefactos de ingeniería** | `Ley 23/1982`, `Decisión Andina 351/1993` | Declaración de autoría moral, cesión escrita de derechos patrimoniales y dependencias exclusivamente con licencias permisivas. |

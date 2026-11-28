> **Spanish version (official rubric root):** [../04-diccionario-datos.md](../04-diccionario-datos.md)

# B4 · Data Dictionary (`12` Tables — `Fotocopiadora SyP`)

**Project:** Web E-Commerce & Technical Service Platform **Fotocopiadora SyP**  
**Product:** G2-P2 · Data model and verification (`RAP 593101`)  
**Author:** `@andressalinasvargas` · **Date:** `2026-11-27`  
**Declared naming standard:** Singular **`snake_case`** table names (`usuario`, `pedido`), primary keys `id_<table>` (or composite `(id_a, id_b)`), named constraints `pk_*`, `fk_*`, `uk_*`, `ck_*`. 1:1 exact match with [../05-script-creacion.sql](../05-script-creacion.sql).

*(SQL table and column names remain in Spanish as exact schema identifiers; descriptions/domains are given in English).*

---

### 1. Table `usuario`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_usuario` | `INTEGER` | `PRIMARY KEY` | Auto-incrementing positive integer |
| `correo_unico` | `VARCHAR(160)` | `NOT NULL`, `UNIQUE` | Valid unique email per account |
| `clave_hash` | `VARCHAR(255)` | `NOT NULL` | Salted one-way hash (`BCrypt`/`Argon2id`) |
| `nombre_completo` | `VARCHAR(120)` | `NOT NULL` | Non-empty full name |
| `telefono` | `VARCHAR(30)` | `NULL` | Optional contact phone |
| `rol` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_usuario_rol` | `'cliente'` \| `'admin'` |
| `activo` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_usuario_activo` | `0` (inactive) \| `1` (active) |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |
| `ultimo_acceso` | `TEXT` | `NULL` | ISO-8601 timestamp |

### 2. Table `notificacion` *(weak entity)*
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_usuario` | `INTEGER` | `PK`, `FK fk_notificacion_usuario` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Mandatory reference to `usuario(id_usuario)` |
| `id_notificacion` | `INTEGER` | `PK` (composite with `id_usuario`) | Per-user sequential ID `>= 1` |
| `titulo` | `VARCHAR(140)` | `NOT NULL` | Short alert title |
| `mensaje` | `VARCHAR(500)` | `NOT NULL` | Human-readable notification body |
| `tipo` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_notif_tipo` | `'pedido'` \| `'cotizacion'` \| `'servicio'` \| `'sistema'` |
| `enlace_destino` | `VARCHAR(200)` | `NULL` | Internal relative target path |
| `leida` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_notif_leida` | `0` \| `1` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

### 3. Table `categoria`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_categoria` | `INTEGER` | `PRIMARY KEY` | Unique identifier |
| `slug_unico` | `VARCHAR(60)` | `NOT NULL`, `UNIQUE` | URL slug (`fotocopiadoras`, `toners`, etc.) |
| `nombre` | `VARCHAR(80)` | `NOT NULL` | Display name in catalog |
| `orden_visual` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_cat_orden` | Integer `>= 1` |

### 4. Table `producto`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_producto` | `INTEGER` | `PRIMARY KEY` | Unique identifier |
| `id_categoria` | `INTEGER` | `NOT NULL`, `FK fk_producto_categoria` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Reference to `categoria(id_categoria)` |
| `codigo_sku` | `VARCHAR(40)` | `NOT NULL`, `UNIQUE` | Unique commercial SKU |
| `nombre` | `VARCHAR(150)` | `NOT NULL` | Commercial product name |
| `marca` | `VARCHAR(60)` | `NOT NULL` | Manufacturer (`Ricoh`, `Kyocera`, etc.) |
| `precio_cop` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_prod_precio` | COP amount `>= 0` |
| `especificacion` | `VARCHAR(400)` | `NOT NULL` | Summary technical specification |
| `estado_stock` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_prod_stock` | `'in'` \| `'low'` \| `'out'` |
| `activo` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_prod_activo` | `0` \| `1` |
| `velocidad_ppm` | `INTEGER` | `NULL`, `CHECK ck_prod_ppm` | `NULL` or integer `> 0` (pages/min) |
| `rendimiento_toner` | `INTEGER` | `NULL`, `CHECK ck_prod_toner` | `NULL` or integer `> 0` (pages) |

### 5. Table `compatibilidad_producto` *(recursive N:M)*
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_equipo` | `INTEGER` | `PK`, `FK fk_comp_equipo` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Printer/multifunction device (`producto`) |
| `id_insumo` | `INTEGER` | `PK`, `FK fk_comp_insumo` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Compatible supply/spare part (`producto`) |
| `nota_tecnica` | `VARCHAR(200)` | `NULL` | Compatibility note *(rule `ck_comp_distintos`: `id_equipo <> id_insumo`)* |

### 6. Table `pedido`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_pedido` | `INTEGER` | `PRIMARY KEY` | Internal identifier |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_pedido_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Registered owner or `NULL` (guest) |
| `codigo_pedido` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Receipt code (`SYP-PED-...`) |
| `nombre_cliente` | `VARCHAR(120)` | `NOT NULL` | Customer or company name |
| `correo_cliente` | `VARCHAR(160)` | `NOT NULL` | Delivery/confirmation email |
| `telefono_cliente` | `VARCHAR(30)` | `NOT NULL` | Coordination phone |
| `nit_cliente` | `VARCHAR(30)` | `NOT NULL` | Tax ID / document |
| `direccion_entrega` | `VARCHAR(200)` | `NOT NULL` | Delivery street address |
| `ciudad_entrega` | `VARCHAR(80)` | `NOT NULL` | Destination city |
| `subtotal` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_sub` | `>= 0` (COP) |
| `iva` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_iva` | `>= 0` (COP) |
| `total` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_tot` | `>= subtotal` (COP) |
| `metodo_pago` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_ped_metodo` | `'wompi'` \| `'nequi'` \| `'transferencia'` \| `'efectivo'` |
| `estado_pago` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_ped_epago` | `'pendiente'` \| `'pagado'` \| `'rechazado'` |
| `estado_envio` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_ped_eenvio` | `'recibido'` \| `'alistando'` \| `'despachado'` \| `'entregado'` \| `'cancelado'` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

### 7. Table `detalle_pedido`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_pedido` | `INTEGER` | `PK`, `FK fk_dped_pedido` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Reference to `pedido(id_pedido)` |
| `id_producto` | `INTEGER` | `PK`, `FK fk_dped_producto` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Reference to `producto(id_producto)` |
| `cantidad` | `INTEGER` | `NOT NULL`, `CHECK ck_dped_cant` | Integer `>= 1` |
| `precio_unitario_pactado` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dped_precio` | `>= 0` (frozen unit price) |
| `subtotal_linea` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dped_sub` | `>= 0` |
| `especificacion_linea` | `VARCHAR(200)` | `NULL` | Commercial item detail |

### 8. Table `cotizacion`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_cotizacion` | `INTEGER` | `PRIMARY KEY` | Internal identifier |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_cot_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Owner customer or `NULL` |
| `codigo_cotizacion` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Quote code (`COT-SYP-...`) |
| `nombre_cliente` | `VARCHAR(120)` | `NOT NULL` | Requester name |
| `correo_cliente` | `VARCHAR(160)` | `NOT NULL` | Response email |
| `telefono_cliente` | `VARCHAR(30)` | `NOT NULL` | Contact phone |
| `subtotal` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_sub` | `>= 0` (COP) |
| `iva` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_iva` | `>= 0` (COP) |
| `total` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_tot` | `>= subtotal` (COP) |
| `observaciones` | `VARCHAR(400)` | `NULL` | Commercial terms |
| `vigencia_dias` | `INTEGER` | `NOT NULL DEFAULT 15`, `CHECK ck_cot_vig` | `1` to `90` days |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

### 9. Table `detalle_cotizacion`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_cotizacion` | `INTEGER` | `PK`, `FK fk_dcot_cotizacion` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Reference to `cotizacion(id_cotizacion)` |
| `id_producto` | `INTEGER` | `PK`, `FK fk_dcot_producto` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Reference to `producto(id_producto)` |
| `cantidad` | `INTEGER` | `NOT NULL`, `CHECK ck_dcot_cant` | Integer `>= 1` |
| `precio_unitario_cotizado` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dcot_precio` | `>= 0` |
| `subtotal_linea` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dcot_sub` | `>= 0` |
| `especificacion_linea` | `VARCHAR(200)` | `NULL` | Quoted technical detail |

### 10. Table `solicitud_servicio`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_solicitud` | `INTEGER` | `PRIMARY KEY` | Unique identifier |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_serv_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Customer or `NULL` |
| `codigo_seguimiento` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Tracking code (`RES-SYP-...`) |
| `nombre_solicitante` | `VARCHAR(120)` | `NOT NULL` | Requester |
| `telefono_contacto` | `VARCHAR(30)` | `NOT NULL` | Phone |
| `modelo_equipo` | `VARCHAR(100)` | `NOT NULL` | Equipment to service |
| `tipo_servicio` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_serv_tipo` | `'preventivo'` \| `'correctivo'` \| `'renting'` \| `'instalacion'` |
| `fecha_deseada` | `TEXT` | `NOT NULL` | Date `YYYY-MM-DD` |
| `franja_horaria` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_serv_franja` | `'manana'` \| `'tarde'` |
| `descripcion_problema` | `VARCHAR(500)` | `NOT NULL` | Symptom or reported SC fault code |
| `estado_atencion` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_serv_estado` | `'pendiente'` \| `'en_proceso'` \| `'resuelta'` \| `'cancelada'` |
| `notas_admin` | `VARCHAR(400)` | `NULL` | Internal workshop log |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

### 11. Table `reporte_contador`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_reporte` | `INTEGER` | `PRIMARY KEY` | Unique identifier |
| `id_usuario` | `INTEGER` | `NOT NULL`, `FK fk_rep_usuario` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Renting owner customer |
| `modelo_equipo` | `VARCHAR(100)` | `NOT NULL` | Reported equipment |
| `contador_bn` | `INTEGER` | `NOT NULL`, `CHECK ck_rep_bn` | Integer `>= 0` (B/W prints) |
| `contador_color` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_rep_color` | Integer `>= 0` |
| `mes_reportado` | `VARCHAR(7)` | `NOT NULL`, `UNIQUE uk_rep_usuario_eq_mes` (`(id_usuario, modelo_equipo, mes_reportado)`) | Unique `YYYY-MM` period per customer & device |
| `observaciones` | `VARCHAR(300)` | `NULL` | Report notes |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

### 12. Table `mensaje_contacto`
| Column | Type & size | Constraints | Domain / Rule |
| :--- | :--- | :--- | :--- |
| `id_mensaje` | `INTEGER` | `PRIMARY KEY` | Unique identifier |
| `nombre` | `VARCHAR(120)` | `NOT NULL` | Sender name |
| `correo` | `VARCHAR(160)` | `NOT NULL` | Contact email |
| `telefono` | `VARCHAR(30)` | `NOT NULL` | Phone |
| `asunto` | `VARCHAR(140)` | `NOT NULL` | Subject |
| `mensaje` | `VARCHAR(800)` | `NOT NULL` | Message body |
| `leido` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_msg_leido` | `0` \| `1` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | ISO-8601 timestamp |

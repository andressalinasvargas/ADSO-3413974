# B4 · Diccionario de Datos (`12` Tablas — `Fotocopiadora SyP`)

**Proyecto:** Plataforma Web E-commerce y Servicio Técnico **Fotocopiadora SyP**  
**Producto:** G2-P2 · Modelo de datos y verificación (`RAP 593101`)  
**Autor:** `@andressalinasvargas` · **Fecha:** `2026-11-27`  
**Estándar de nombrado declarado:** Tablas en **singular `snake_case`** (`usuario`, `pedido`), llaves primarias `id_<tabla>` (o compuestas `(id_a, id_b)`), restricciones nombradas `pk_*`, `fk_*`, `uk_*`, `ck_*`. Coincidencia exacta 1:1 con [05-script-creacion.sql](05-script-creacion.sql).

---

### 1. Tabla `usuario`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_usuario` | `INTEGER` | `PRIMARY KEY` | Entero positivo auto-incremental |
| `correo_unico` | `VARCHAR(160)` | `NOT NULL`, `UNIQUE` | Correo válido único por cuenta |
| `clave_hash` | `VARCHAR(255)` | `NOT NULL` | Hash unidireccional con sal (`BCrypt`/`Argon2id`) |
| `nombre_completo` | `VARCHAR(120)` | `NOT NULL` | Texto no vacío |
| `telefono` | `VARCHAR(30)` | `NULL` | Teléfono opcional del usuario |
| `rol` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_usuario_rol` | `'cliente'` \| `'admin'` |
| `activo` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_usuario_activo` | `0` (inactivo) \| `1` (activo) |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |
| `ultimo_acceso` | `TEXT` | `NULL` | Marca temporal ISO-8601 |

### 2. Tabla `notificacion` *(entidad débil)*
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_usuario` | `INTEGER` | `PK`, `FK fk_notificacion_usuario` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Referencia obligatoria a `usuario(id_usuario)` |
| `id_notificacion` | `INTEGER` | `PK` (compuesta con `id_usuario`) | Consecutivo por usuario `≥ 1` |
| `titulo` | `VARCHAR(140)` | `NOT NULL` | Asunto corto de la notificación |
| `mensaje` | `VARCHAR(500)` | `NOT NULL` | Cuerpo legible del aviso |
| `tipo` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_notif_tipo` | `'pedido'` \| `'cotizacion'` \| `'servicio'` \| `'sistema'` |
| `enlace_destino` | `VARCHAR(200)` | `NULL` | Ruta relativa interna |
| `leida` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_notif_leida` | `0` \| `1` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

### 3. Tabla `categoria`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_categoria` | `INTEGER` | `PRIMARY KEY` | Identificador único |
| `slug_unico` | `VARCHAR(60)` | `NOT NULL`, `UNIQUE` | Identificador URL (`fotocopiadoras`, `toners`, etc.) |
| `nombre` | `VARCHAR(80)` | `NOT NULL` | Nombre visible en catálogo |
| `orden_visual` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_cat_orden` | Entero `>= 1` |

### 4. Tabla `producto`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_producto` | `INTEGER` | `PRIMARY KEY` | Identificador único |
| `id_categoria` | `INTEGER` | `NOT NULL`, `FK fk_producto_categoria` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Referencia a `categoria(id_categoria)` |
| `codigo_sku` | `VARCHAR(40)` | `NOT NULL`, `UNIQUE` | Referencia comercial única |
| `nombre` | `VARCHAR(150)` | `NOT NULL` | Nombre comercial del producto |
| `marca` | `VARCHAR(60)` | `NOT NULL` | Fabricante (`Ricoh`, `Kyocera`, etc.) |
| `precio_cop` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_prod_precio` | Importe COP `>= 0` |
| `especificacion` | `VARCHAR(400)` | `NOT NULL` | Ficha técnica resumida |
| `estado_stock` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_prod_stock` | `'in'` \| `'low'` \| `'out'` |
| `activo` | `INTEGER` | `NOT NULL DEFAULT 1`, `CHECK ck_prod_activo` | `0` \| `1` |
| `velocidad_ppm` | `INTEGER` | `NULL`, `CHECK ck_prod_ppm` | `NULL` o entero `> 0` (páginas/min) |
| `rendimiento_toner` | `INTEGER` | `NULL`, `CHECK ck_prod_toner` | `NULL` o entero `> 0` (páginas) |

### 5. Tabla `compatibilidad_producto` *(N:M recursiva)*
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_equipo` | `INTEGER` | `PK`, `FK fk_comp_equipo` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Equipo multifuncional/impresora (`producto`) |
| `id_insumo` | `INTEGER` | `PK`, `FK fk_comp_insumo` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Insumo/repuesto compatible (`producto`) |
| `nota_tecnica` | `VARCHAR(200)` | `NULL` | Aclaración de compatibilidad *(regla `ck_comp_distintos`: `id_equipo <> id_insumo`)* |

### 6. Tabla `pedido`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_pedido` | `INTEGER` | `PRIMARY KEY` | Identificador interno |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_pedido_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Cliente titular o `NULL` (invitado) |
| `codigo_pedido` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Código de comprobante (`SYP-PED-...`) |
| `nombre_cliente` | `VARCHAR(120)` | `NOT NULL` | Nombre o razón social |
| `correo_cliente` | `VARCHAR(160)` | `NOT NULL` | Correo de entrega/confirmación |
| `telefono_cliente` | `VARCHAR(30)` | `NOT NULL` | Teléfono de coordinación |
| `nit_cliente` | `VARCHAR(30)` | `NOT NULL` | NIT o documento tributario |
| `direccion_entrega` | `VARCHAR(200)` | `NOT NULL` | Dirección física |
| `ciudad_entrega` | `VARCHAR(80)` | `NOT NULL` | Ciudad/municipio destino |
| `subtotal` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_sub` | `>= 0` (COP) |
| `iva` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_iva` | `>= 0` (COP) |
| `total` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_ped_tot` | `>= subtotal` (COP) |
| `metodo_pago` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_ped_metodo` | `'wompi'` \| `'nequi'` \| `'transferencia'` \| `'efectivo'` |
| `estado_pago` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_ped_epago` | `'pendiente'` \| `'pagado'` \| `'rechazado'` |
| `estado_envio` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_ped_eenvio` | `'recibido'` \| `'alistando'` \| `'despachado'` \| `'entregado'` \| `'cancelado'` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

### 7. Tabla `detalle_pedido`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_pedido` | `INTEGER` | `PK`, `FK fk_dped_pedido` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Referencia a `pedido(id_pedido)` |
| `id_producto` | `INTEGER` | `PK`, `FK fk_dped_producto` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Referencia a `producto(id_producto)` |
| `cantidad` | `INTEGER` | `NOT NULL`, `CHECK ck_dped_cant` | Entero `>= 1` |
| `precio_unitario_pactado` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dped_precio` | `>= 0` (precio congelado) |
| `subtotal_linea` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dped_sub` | `>= 0` |
| `especificacion_linea` | `VARCHAR(200)` | `NULL` | Detalle comercial del ítem |

### 8. Tabla `cotizacion`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_cotizacion` | `INTEGER` | `PRIMARY KEY` | Identificador interno |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_cot_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Cliente titular o `NULL` |
| `codigo_cotizacion` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Código (`COT-SYP-...`) |
| `nombre_cliente` | `VARCHAR(120)` | `NOT NULL` | Nombre del solicitante |
| `correo_cliente` | `VARCHAR(160)` | `NOT NULL` | Correo de respuesta |
| `telefono_cliente` | `VARCHAR(30)` | `NOT NULL` | Teléfono de contacto |
| `subtotal` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_sub` | `>= 0` (COP) |
| `iva` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_iva` | `>= 0` (COP) |
| `total` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_cot_tot` | `>= subtotal` (COP) |
| `observaciones` | `VARCHAR(400)` | `NULL` | Condiciones comerciales |
| `vigencia_dias` | `INTEGER` | `NOT NULL DEFAULT 15`, `CHECK ck_cot_vig` | `1` a `90` días |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

### 9. Tabla `detalle_cotizacion`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_cotizacion` | `INTEGER` | `PK`, `FK fk_dcot_cotizacion` (`ON DELETE CASCADE ON UPDATE CASCADE`) | Referencia a `cotizacion(id_cotizacion)` |
| `id_producto` | `INTEGER` | `PK`, `FK fk_dcot_producto` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Referencia a `producto(id_producto)` |
| `cantidad` | `INTEGER` | `NOT NULL`, `CHECK ck_dcot_cant` | Entero `>= 1` |
| `precio_unitario_cotizado` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dcot_precio` | `>= 0` |
| `subtotal_linea` | `NUMERIC(12,2)` | `NOT NULL`, `CHECK ck_dcot_sub` | `>= 0` |
| `especificacion_linea` | `VARCHAR(200)` | `NULL` | Detalle técnico cotizado |

### 10. Tabla `solicitud_servicio`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_solicitud` | `INTEGER` | `PRIMARY KEY` | Identificador único |
| `id_usuario` | `INTEGER` | `NULL`, `FK fk_serv_usuario` (`ON DELETE SET NULL ON UPDATE CASCADE`) | Cliente o `NULL` |
| `codigo_seguimiento` | `VARCHAR(32)` | `NOT NULL`, `UNIQUE` | Código (`RES-SYP-...`) |
| `nombre_solicitante` | `VARCHAR(120)` | `NOT NULL` | Solicitante |
| `telefono_contacto` | `VARCHAR(30)` | `NOT NULL` | Teléfono |
| `modelo_equipo` | `VARCHAR(100)` | `NOT NULL` | Equipo a intervenir |
| `tipo_servicio` | `VARCHAR(30)` | `NOT NULL`, `CHECK ck_serv_tipo` | `'preventivo'` \| `'correctivo'` \| `'renting'` \| `'instalacion'` |
| `fecha_deseada` | `TEXT` | `NOT NULL` | Fecha `YYYY-MM-DD` |
| `franja_horaria` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_serv_franja` | `'manana'` \| `'tarde'` |
| `descripcion_problema` | `VARCHAR(500)` | `NOT NULL` | Síntoma o código SC reportado |
| `estado_atencion` | `VARCHAR(20)` | `NOT NULL`, `CHECK ck_serv_estado` | `'pendiente'` \| `'en_proceso'` \| `'resuelta'` \| `'cancelada'` |
| `notas_admin` | `VARCHAR(400)` | `NULL` | Bitácora interna de taller |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

### 11. Tabla `reporte_contador`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_reporte` | `INTEGER` | `PRIMARY KEY` | Identificador único |
| `id_usuario` | `INTEGER` | `NOT NULL`, `FK fk_rep_usuario` (`ON DELETE RESTRICT ON UPDATE CASCADE`) | Cliente propietario en renting |
| `modelo_equipo` | `VARCHAR(100)` | `NOT NULL` | Equipo reportado |
| `contador_bn` | `INTEGER` | `NOT NULL`, `CHECK ck_rep_bn` | Entero `>= 0` (blanco y negro) |
| `contador_color` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_rep_color` | Entero `>= 0` |
| `mes_reportado` | `VARCHAR(7)` | `NOT NULL`, `UNIQUE uk_rep_usuario_eq_mes` (`(id_usuario, modelo_equipo, mes_reportado)`) | Periodo `YYYY-MM` único por cliente y equipo |
| `observaciones` | `VARCHAR(300)` | `NULL` | Notas del reporte |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

### 12. Tabla `mensaje_contacto`
| Columna | Tipo y tamaño | Restricciones | Dominio / Regla |
| :--- | :--- | :--- | :--- |
| `id_mensaje` | `INTEGER` | `PRIMARY KEY` | Identificador único |
| `nombre` | `VARCHAR(120)` | `NOT NULL` | Remitente |
| `correo` | `VARCHAR(160)` | `NOT NULL` | Correo de contacto |
| `telefono` | `VARCHAR(30)` | `NOT NULL` | Teléfono |
| `asunto` | `VARCHAR(140)` | `NOT NULL` | Tema de la consulta |
| `mensaje` | `VARCHAR(800)` | `NOT NULL` | Mensaje completo |
| `leido` | `INTEGER` | `NOT NULL DEFAULT 0`, `CHECK ck_msg_leido` | `0` \| `1` |
| `fecha_creacion` | `TEXT` | `NOT NULL` | Marca temporal ISO-8601 |

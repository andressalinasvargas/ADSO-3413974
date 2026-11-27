-- ============================================================================
-- B5 · Script DDL de Creación y Carga Sintética (12 Tablas 3FN)
-- Proyecto: Fotocopiadora SyP — Ficha 3413974 (@andressalinasvargas)
-- Compatible con SQLite 3 (PRAGMA foreign_keys = ON) y PostgreSQL/ANSI SQL
-- ============================================================================

PRAGMA foreign_keys = ON;

CREATE TABLE usuario (
    id_usuario       INTEGER      PRIMARY KEY,
    correo_unico     VARCHAR(160) NOT NULL UNIQUE,
    clave_hash       VARCHAR(255) NOT NULL,
    nombre_completo  VARCHAR(120) NOT NULL,
    telefono         VARCHAR(30)  NULL,
    rol              VARCHAR(20)  NOT NULL,
    activo           INTEGER      NOT NULL DEFAULT 1,
    fecha_creacion   TEXT         NOT NULL,
    ultimo_acceso    TEXT         NULL,
    CONSTRAINT ck_usuario_rol    CHECK (rol IN ('cliente', 'admin')),
    CONSTRAINT ck_usuario_activo CHECK (activo IN (0, 1))
);

CREATE TABLE notificacion (
    id_usuario       INTEGER      NOT NULL,
    id_notificacion  INTEGER      NOT NULL,
    titulo           VARCHAR(140) NOT NULL,
    mensaje          VARCHAR(500) NOT NULL,
    tipo             VARCHAR(30)  NOT NULL,
    enlace_destino   VARCHAR(200) NULL,
    leida            INTEGER      NOT NULL DEFAULT 0,
    fecha_creacion   TEXT         NOT NULL,
    CONSTRAINT pk_notificacion         PRIMARY KEY (id_usuario, id_notificacion),
    CONSTRAINT fk_notificacion_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_notif_tipo           CHECK (tipo IN ('pedido', 'cotizacion', 'servicio', 'sistema')),
    CONSTRAINT ck_notif_leida          CHECK (leida IN (0, 1))
);

CREATE TABLE categoria (
    id_categoria  INTEGER     PRIMARY KEY,
    slug_unico    VARCHAR(60) NOT NULL UNIQUE,
    nombre        VARCHAR(80) NOT NULL,
    orden_visual  INTEGER     NOT NULL DEFAULT 1,
    CONSTRAINT ck_cat_orden CHECK (orden_visual >= 1)
);

CREATE TABLE producto (
    id_producto       INTEGER       PRIMARY KEY,
    id_categoria      INTEGER       NOT NULL,
    codigo_sku        VARCHAR(40)   NOT NULL UNIQUE,
    nombre            VARCHAR(150)  NOT NULL,
    marca             VARCHAR(60)   NOT NULL,
    precio_cop        NUMERIC(12,2) NOT NULL,
    especificacion    VARCHAR(400)  NOT NULL,
    estado_stock      VARCHAR(20)   NOT NULL,
    activo            INTEGER       NOT NULL DEFAULT 1,
    velocidad_ppm     INTEGER       NULL,
    rendimiento_toner INTEGER       NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_prod_precio CHECK (precio_cop >= 0),
    CONSTRAINT ck_prod_stock  CHECK (estado_stock IN ('in', 'low', 'out')),
    CONSTRAINT ck_prod_activo CHECK (activo IN (0, 1)),
    CONSTRAINT ck_prod_ppm    CHECK (velocidad_ppm IS NULL OR velocidad_ppm > 0),
    CONSTRAINT ck_prod_toner  CHECK (rendimiento_toner IS NULL OR rendimiento_toner > 0)
);

CREATE TABLE compatibilidad_producto (
    id_equipo    INTEGER      NOT NULL,
    id_insumo    INTEGER      NOT NULL,
    nota_tecnica VARCHAR(200) NULL,
    CONSTRAINT pk_compatibilidad  PRIMARY KEY (id_equipo, id_insumo),
    CONSTRAINT fk_comp_equipo     FOREIGN KEY (id_equipo)
        REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comp_insumo     FOREIGN KEY (id_insumo)
        REFERENCES producto(id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_comp_distintos  CHECK (id_equipo <> id_insumo)
);

CREATE TABLE pedido (
    id_pedido         INTEGER       PRIMARY KEY,
    id_usuario        INTEGER       NULL,
    codigo_pedido     VARCHAR(32)   NOT NULL UNIQUE,
    nombre_cliente    VARCHAR(120)  NOT NULL,
    correo_cliente    VARCHAR(160)  NOT NULL,
    telefono_cliente  VARCHAR(30)   NOT NULL,
    nit_cliente       VARCHAR(30)   NOT NULL,
    direccion_entrega VARCHAR(200)  NOT NULL,
    ciudad_entrega    VARCHAR(80)   NOT NULL,
    subtotal          NUMERIC(12,2) NOT NULL,
    iva               NUMERIC(12,2) NOT NULL,
    total             NUMERIC(12,2) NOT NULL,
    metodo_pago       VARCHAR(30)   NOT NULL,
    estado_pago       VARCHAR(20)   NOT NULL,
    estado_envio      VARCHAR(20)   NOT NULL,
    fecha_creacion    TEXT          NOT NULL,
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_ped_sub    CHECK (subtotal >= 0),
    CONSTRAINT ck_ped_iva    CHECK (iva >= 0),
    CONSTRAINT ck_ped_tot    CHECK (total >= subtotal),
    CONSTRAINT ck_ped_metodo CHECK (metodo_pago IN ('wompi', 'nequi', 'transferencia', 'efectivo')),
    CONSTRAINT ck_ped_epago  CHECK (estado_pago IN ('pendiente', 'pagado', 'rechazado')),
    CONSTRAINT ck_ped_eenvio CHECK (estado_envio IN ('recibido', 'alistando', 'despachado', 'entregado', 'cancelado'))
);

CREATE TABLE detalle_pedido (
    id_pedido               INTEGER       NOT NULL,
    id_producto             INTEGER       NOT NULL,
    cantidad                INTEGER       NOT NULL,
    precio_unitario_pactado NUMERIC(12,2) NOT NULL,
    subtotal_linea          NUMERIC(12,2) NOT NULL,
    especificacion_linea    VARCHAR(200)  NULL,
    CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_dped_pedido    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_dped_producto  FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_dped_cant   CHECK (cantidad >= 1),
    CONSTRAINT ck_dped_precio CHECK (precio_unitario_pactado >= 0),
    CONSTRAINT ck_dped_sub    CHECK (subtotal_linea >= 0)
);

CREATE TABLE cotizacion (
    id_cotizacion     INTEGER       PRIMARY KEY,
    id_usuario        INTEGER       NULL,
    codigo_cotizacion VARCHAR(32)   NOT NULL UNIQUE,
    nombre_cliente    VARCHAR(120)  NOT NULL,
    correo_cliente    VARCHAR(160)  NOT NULL,
    telefono_cliente  VARCHAR(30)   NOT NULL,
    subtotal          NUMERIC(12,2) NOT NULL,
    iva               NUMERIC(12,2) NOT NULL,
    total             NUMERIC(12,2) NOT NULL,
    observaciones     VARCHAR(400)  NULL,
    vigencia_dias     INTEGER       NOT NULL DEFAULT 15,
    fecha_creacion    TEXT          NOT NULL,
    CONSTRAINT fk_cot_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_cot_sub CHECK (subtotal >= 0),
    CONSTRAINT ck_cot_iva CHECK (iva >= 0),
    CONSTRAINT ck_cot_tot CHECK (total >= subtotal),
    CONSTRAINT ck_cot_vig CHECK (vigencia_dias BETWEEN 1 AND 90)
);

CREATE TABLE detalle_cotizacion (
    id_cotizacion            INTEGER       NOT NULL,
    id_producto              INTEGER       NOT NULL,
    cantidad                 INTEGER       NOT NULL,
    precio_unitario_cotizado NUMERIC(12,2) NOT NULL,
    subtotal_linea           NUMERIC(12,2) NOT NULL,
    especificacion_linea     VARCHAR(200)  NULL,
    CONSTRAINT pk_detalle_cotizacion PRIMARY KEY (id_cotizacion, id_producto),
    CONSTRAINT fk_dcot_cotizacion    FOREIGN KEY (id_cotizacion)
        REFERENCES cotizacion(id_cotizacion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_dcot_producto      FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_dcot_cant   CHECK (cantidad >= 1),
    CONSTRAINT ck_dcot_precio CHECK (precio_unitario_cotizado >= 0),
    CONSTRAINT ck_dcot_sub    CHECK (subtotal_linea >= 0)
);

CREATE TABLE solicitud_servicio (
    id_solicitud         INTEGER      PRIMARY KEY,
    id_usuario           INTEGER      NULL,
    codigo_seguimiento   VARCHAR(32)  NOT NULL UNIQUE,
    nombre_solicitante   VARCHAR(120) NOT NULL,
    telefono_contacto    VARCHAR(30)  NOT NULL,
    modelo_equipo        VARCHAR(100) NOT NULL,
    tipo_servicio        VARCHAR(30)  NOT NULL,
    fecha_deseada        TEXT         NOT NULL,
    franja_horaria       VARCHAR(20)  NOT NULL,
    descripcion_problema VARCHAR(500) NOT NULL,
    estado_atencion      VARCHAR(20)  NOT NULL,
    notas_admin          VARCHAR(400) NULL,
    fecha_creacion       TEXT         NOT NULL,
    CONSTRAINT fk_serv_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_serv_tipo   CHECK (tipo_servicio IN ('preventivo', 'correctivo', 'renting', 'instalacion')),
    CONSTRAINT ck_serv_franja CHECK (franja_horaria IN ('manana', 'tarde')),
    CONSTRAINT ck_serv_estado CHECK (estado_atencion IN ('pendiente', 'en_proceso', 'resuelta', 'cancelada'))
);

CREATE TABLE reporte_contador (
    id_reporte     INTEGER      PRIMARY KEY,
    id_usuario     INTEGER      NOT NULL,
    modelo_equipo  VARCHAR(100) NOT NULL,
    contador_bn    INTEGER      NOT NULL,
    contador_color INTEGER      NOT NULL DEFAULT 0,
    mes_reportado  VARCHAR(7)   NOT NULL,
    observaciones  VARCHAR(300) NULL,
    fecha_creacion TEXT         NOT NULL,
    CONSTRAINT uk_rep_usuario_eq_mes UNIQUE (id_usuario, modelo_equipo, mes_reportado),
    CONSTRAINT fk_rep_usuario        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_rep_bn    CHECK (contador_bn >= 0),
    CONSTRAINT ck_rep_color CHECK (contador_color >= 0)
);

CREATE TABLE mensaje_contacto (
    id_mensaje     INTEGER      PRIMARY KEY,
    nombre         VARCHAR(120) NOT NULL,
    correo         VARCHAR(160) NOT NULL,
    telefono       VARCHAR(30)  NOT NULL,
    asunto         VARCHAR(140) NOT NULL,
    mensaje        VARCHAR(800) NOT NULL,
    leido          INTEGER      NOT NULL DEFAULT 0,
    fecha_creacion TEXT         NOT NULL,
    CONSTRAINT ck_msg_leido CHECK (leido IN (0, 1))
);

-- Carga sintética de verificación (cero datos personales reales)
INSERT INTO usuario VALUES (1, 'cliente.demo@ejemplo.invalid', '$2b$12$SinteticoHashDemoCliente000000000000000000000000000000', 'Cliente Prueba Uno', '3000000001', 'cliente', 1, '2026-11-27T09:00:00-05:00', NULL);
INSERT INTO notificacion VALUES (1, 1, 'Pedido registrado', 'Tu pedido de prueba fue recibido.', 'pedido', '/cotizacion.html', 0, '2026-11-27T09:05:00-05:00');
INSERT INTO categoria VALUES (1, 'fotocopiadoras', 'Fotocopiadoras Multifuncionales', 1);
INSERT INTO producto VALUES (1, 1, 'SKU-EQ-001', 'Multifuncional Monocromo Pro 45', 'Marca Generica A', 4850000.00, '45 ppm duplex red Ethernet', 'in', 1, 45, NULL);
INSERT INTO producto VALUES (2, 1, 'SKU-TN-001', 'Toner Alto Rendimiento 24K', 'Marca Generica A', 290000.00, 'Cartucho negro alto rendimiento', 'in', 1, NULL, 24000);
INSERT INTO compatibilidad_producto VALUES (1, 2, 'Toner estandar verificado en laboratorio');
INSERT INTO pedido VALUES (1, 1, 'SYP-PED-202601', 'Cliente Prueba Uno', 'cliente.demo@ejemplo.invalid', '3000000001', '900000001-0', 'Calle Ficticia 10-20', 'Neiva', 290000.00, 55100.00, 345100.00, 'transferencia', 'pendiente', 'recibido', '2026-11-27T09:10:00-05:00');
INSERT INTO detalle_pedido VALUES (1, 2, 1, 290000.00, 290000.00, 'Cartucho negro alto rendimiento');
INSERT INTO cotizacion VALUES (1, 1, 'COT-SYP-202601', 'Cliente Prueba Uno', 'cliente.demo@ejemplo.invalid', '3000000001', 4850000.00, 921500.00, 5771500.00, 'Cotizacion demostrativa', 15, '2026-11-27T09:15:00-05:00');
INSERT INTO detalle_cotizacion VALUES (1, 1, 1, 4850000.00, 4850000.00, 'Equipo multifuncional demo');
INSERT INTO solicitud_servicio VALUES (1, 1, 'RES-SYP-202601', 'Cliente Prueba Uno', '3000000001', 'Multifuncional Pro 45', 'preventivo', '2026-12-01', 'manana', 'Limpieza de fusor y revision preventiva', 'pendiente', NULL, '2026-11-27T09:20:00-05:00');
INSERT INTO reporte_contador VALUES (1, 1, 'Multifuncional Pro 45', 14500, 0, '2026-11', 'Lectura mensual de prueba', '2026-11-27T09:25:00-05:00');
INSERT INTO mensaje_contacto VALUES (1, 'Visitante Prueba', 'visitante.demo@ejemplo.invalid', '3000000002', 'Consulta cobertura renting', 'Solicitud informativa de prueba sin datos reales.', 0, '2026-11-27T09:30:00-05:00');

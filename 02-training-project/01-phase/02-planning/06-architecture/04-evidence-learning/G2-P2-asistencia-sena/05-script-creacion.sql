-- ============================================================================
-- B5 · Script DDL de Creación y Verificación — Sistema Control Asistencia SENA
-- Proyecto: asistencia-sena (ADSO-3413974) · Autor: @andressalinasvargas
-- Motor destino: MariaDB 10.11 / MySQL 8.0+ (InnoDB, utf8mb4_unicode_ci)
-- Fecha: 2026-11-23
-- ============================================================================

DROP DATABASE IF EXISTS sena_asistencias_diseno;
CREATE DATABASE sena_asistencias_diseno
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE sena_asistencias_diseno;

-- 1. Programa de formación
CREATE TABLE programa_formacion (
  id_programa     INT AUTO_INCREMENT,
  codigo_programa VARCHAR(20)  NOT NULL,
  nombre_programa VARCHAR(150) NOT NULL,
  nivel_formacion VARCHAR(40)  NOT NULL DEFAULT 'Tecnólogo',
  CONSTRAINT pk_programa_formacion PRIMARY KEY (id_programa),
  CONSTRAINT uk_programa_codigo    UNIQUE (codigo_programa),
  CONSTRAINT ck_programa_nivel     CHECK (nivel_formacion IN ('Operario','Auxiliar','Técnico','Tecnólogo','Especialización'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Sede de formación (geocerca)
CREATE TABLE sede (
  id_sede          INT AUTO_INCREMENT,
  nombre_sede      VARCHAR(120)  NOT NULL,
  latitud_sede     DECIMAL(10,7) NOT NULL,
  longitud_sede    DECIMAL(10,7) NOT NULL,
  radio_max_metros INT           NOT NULL DEFAULT 300,
  CONSTRAINT pk_sede       PRIMARY KEY (id_sede),
  CONSTRAINT uk_sede_nombre UNIQUE (nombre_sede),
  CONSTRAINT ck_sede_lat   CHECK (latitud_sede BETWEEN -90.0000000 AND 90.0000000),
  CONSTRAINT ck_sede_lng   CHECK (longitud_sede BETWEEN -180.0000000 AND 180.0000000),
  CONSTRAINT ck_sede_radio CHECK (radio_max_metros > 0 AND radio_max_metros <= 5000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Ficha académica
CREATE TABLE ficha (
  id_ficha     INT AUTO_INCREMENT,
  numero_ficha VARCHAR(30) NOT NULL,
  jornada      VARCHAR(30) NOT NULL DEFAULT 'Diurna',
  activa       TINYINT(1)  NOT NULL DEFAULT 1,
  id_programa  INT         NOT NULL,
  id_sede      INT         NOT NULL,
  CONSTRAINT pk_ficha         PRIMARY KEY (id_ficha),
  CONSTRAINT uk_ficha_numero  UNIQUE (numero_ficha),
  CONSTRAINT ck_ficha_jornada CHECK (jornada IN ('Diurna','Nocturna','Mixta','Fin de semana')),
  CONSTRAINT ck_ficha_activa  CHECK (activa IN (0, 1)),
  CONSTRAINT fk_ficha_programa FOREIGN KEY (id_programa)
    REFERENCES programa_formacion (id_programa)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_ficha_sede FOREIGN KEY (id_sede)
    REFERENCES sede (id_sede)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Usuarios administrativos del sistema (Instructor / Coordinador)
CREATE TABLE usuario_sistema (
  id_usuario    INT AUTO_INCREMENT,
  documento     VARCHAR(30)  NOT NULL,
  nombre        VARCHAR(120) NOT NULL,
  email         VARCHAR(120) NOT NULL,
  usuario       VARCHAR(60)  NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  rol_sistema   VARCHAR(30)  NOT NULL DEFAULT 'Instructor',
  especialidad  VARCHAR(120) NULL,
  activo        TINYINT(1)   NOT NULL DEFAULT 1,
  creado_en     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_usuario_sistema   PRIMARY KEY (id_usuario),
  CONSTRAINT uk_usuario_documento UNIQUE (documento),
  CONSTRAINT uk_usuario_email     UNIQUE (email),
  CONSTRAINT uk_usuario_login     UNIQUE (usuario),
  CONSTRAINT ck_usuario_rol       CHECK (rol_sistema IN ('Instructor','Coordinador')),
  CONSTRAINT ck_usuario_activo    CHECK (activo IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Asignación histórica N:M de instructores a fichas
CREATE TABLE asignacion_instructor_ficha (
  id_usuario   INT         NOT NULL,
  id_ficha     INT         NOT NULL,
  fecha_inicio DATE        NOT NULL,
  fecha_fin    DATE        NULL,
  rol_en_ficha VARCHAR(40) NOT NULL DEFAULT 'Titular',
  CONSTRAINT pk_asignacion_instructor PRIMARY KEY (id_usuario, id_ficha, fecha_inicio),
  CONSTRAINT ck_asig_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
  CONSTRAINT fk_asig_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario_sistema (id_usuario)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_asig_ficha FOREIGN KEY (id_ficha)
    REFERENCES ficha (id_ficha)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Aprendices y credencial QR individual
CREATE TABLE aprendiz (
  id_aprendiz INT AUTO_INCREMENT,
  documento   VARCHAR(30)  NOT NULL,
  nombre      VARCHAR(150) NOT NULL,
  email       VARCHAR(120) NULL,
  qr_token    VARCHAR(64)  NOT NULL,
  activo      TINYINT(1)   NOT NULL DEFAULT 1,
  id_ficha    INT          NULL,
  creado_en   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_aprendiz           PRIMARY KEY (id_aprendiz),
  CONSTRAINT uk_aprendiz_documento UNIQUE (documento),
  CONSTRAINT uk_aprendiz_qr_token  UNIQUE (qr_token),
  CONSTRAINT ck_aprendiz_activo    CHECK (activo IN (0, 1)),
  CONSTRAINT fk_aprendiz_ficha FOREIGN KEY (id_ficha)
    REFERENCES ficha (id_ficha)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Teléfonos multivaluados del aprendiz (1FN)
CREATE TABLE telefono_aprendiz (
  id_telefono     INT AUTO_INCREMENT,
  id_aprendiz     INT         NOT NULL,
  numero_telefono VARCHAR(20) NOT NULL,
  tipo_telefono   VARCHAR(20) NOT NULL DEFAULT 'Móvil',
  CONSTRAINT pk_telefono_aprendiz PRIMARY KEY (id_telefono),
  CONSTRAINT uk_tel_aprendiz_num  UNIQUE (id_aprendiz, numero_telefono),
  CONSTRAINT ck_telefono_tipo     CHECK (tipo_telefono IN ('Móvil','Alterno','Acudiente')),
  CONSTRAINT fk_telefono_aprendiz FOREIGN KEY (id_aprendiz)
    REFERENCES aprendiz (id_aprendiz)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Sesiones de asistencia
CREATE TABLE sesion_asistencia (
  id_sesion          INT AUTO_INCREMENT,
  token              VARCHAR(64) NOT NULL,
  codigo             VARCHAR(8)  NOT NULL,
  id_ficha           INT         NULL,
  id_usuario         INT         NOT NULL,
  inicia_en          DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  vence_en           DATETIME    NOT NULL,
  tolerancia_minutos INT         NOT NULL DEFAULT 10,
  activa             TINYINT(1)  NOT NULL DEFAULT 1,
  CONSTRAINT pk_sesion_asistencia PRIMARY KEY (id_sesion),
  CONSTRAINT uk_sesion_token      UNIQUE (token),
  CONSTRAINT uk_sesion_codigo     UNIQUE (codigo),
  CONSTRAINT ck_sesion_fechas     CHECK (vence_en > inicia_en),
  CONSTRAINT ck_sesion_tolerancia CHECK (tolerancia_minutos >= 0 AND tolerancia_minutos <= 120),
  CONSTRAINT ck_sesion_activa     CHECK (activa IN (0, 1)),
  CONSTRAINT fk_sesion_ficha FOREIGN KEY (id_ficha)
    REFERENCES ficha (id_ficha)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_sesion_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario_sistema (id_usuario)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Registro único de asistencia por aprendiz y sesión
CREATE TABLE registro_asistencia (
  id_registro          BIGINT AUTO_INCREMENT,
  id_aprendiz          INT           NOT NULL,
  id_sesion            INT           NOT NULL,
  fecha_hora           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  canal_registro       VARCHAR(20)   NOT NULL,
  tarde_minutos        INT           NOT NULL DEFAULT 0,
  latitud              DECIMAL(10,7) NULL,
  longitud             DECIMAL(10,7) NULL,
  precision_gps        DECIMAL(8,2)  NULL,
  verificado_gps       TINYINT(1)    NOT NULL DEFAULT 0,
  consentimiento_datos TINYINT(1)    NOT NULL DEFAULT 0,
  ip_origen            VARCHAR(45)   NOT NULL,
  estado_red           VARCHAR(20)   NOT NULL DEFAULT 'permitida',
  detalle_red          VARCHAR(255)  NULL,
  CONSTRAINT pk_registro_asistencia   PRIMARY KEY (id_registro),
  CONSTRAINT uk_reg_aprendiz_sesion   UNIQUE (id_aprendiz, id_sesion),
  CONSTRAINT ck_reg_canal             CHECK (canal_registro IN ('movil_qr','codigo','escaner_qr','manual')),
  CONSTRAINT ck_reg_tarde             CHECK (tarde_minutos >= 0),
  CONSTRAINT ck_reg_precision         CHECK (precision_gps IS NULL OR (precision_gps > 0 AND precision_gps <= 100.00)),
  CONSTRAINT ck_reg_gps_verif         CHECK (verificado_gps IN (0, 1)),
  CONSTRAINT ck_reg_consentimiento    CHECK (consentimiento_datos IN (0, 1)),
  CONSTRAINT ck_reg_estado_red        CHECK (estado_red IN ('permitida','sospechosa','bloqueada')),
  CONSTRAINT fk_reg_aprendiz FOREIGN KEY (id_aprendiz)
    REFERENCES aprendiz (id_aprendiz)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_reg_sesion FOREIGN KEY (id_sesion)
    REFERENCES sesion_asistencia (id_sesion)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX idx_reg_fecha_hora (fecha_hora)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Novedades de contingencia (entidad débil dependiente de registro_asistencia)
CREATE TABLE novedad_contingencia (
  id_registro    BIGINT       NOT NULL,
  numero_novedad INT          NOT NULL,
  tipo_novedad   VARCHAR(40)  NOT NULL,
  observacion    VARCHAR(255) NOT NULL,
  fecha_reporte  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_novedad_contingencia PRIMARY KEY (id_registro, numero_novedad),
  CONSTRAINT ck_nov_numero CHECK (numero_novedad >= 1),
  CONSTRAINT ck_nov_tipo   CHECK (tipo_novedad IN ('sin_movil','falla_camara','falla_gps','falla_red','condicion_especial')),
  CONSTRAINT fk_nov_registro FOREIGN KEY (id_registro)
    REFERENCES registro_asistencia (id_registro)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- Carga controlada con datos sintéticos ficticios para verificar ejecución
-- (Sin datos personales reales de aprendices o instructores)
-- ============================================================================
INSERT INTO programa_formacion (codigo_programa, nombre_programa, nivel_formacion)
VALUES ('228118', 'Análisis y Desarrollo de Software', 'Tecnólogo');

INSERT INTO sede (nombre_sede, latitud_sede, longitud_sede, radio_max_metros)
VALUES ('Sede Formacion Demo', 2.9273000, -75.2818900, 300);

INSERT INTO ficha (numero_ficha, jornada, activa, id_programa, id_sede)
VALUES ('3413974', 'Diurna', 1, 1, 1);

INSERT INTO usuario_sistema (documento, nombre, email, usuario, password_hash, rol_sistema, especialidad, activo)
VALUES ('900000001', 'Instructor Demo', 'instructor.demo@example.invalid', 'instructor_demo',
        '$2y$10$EjemploHashBCryptSinteticoDePruebaParaEsquema000000000', 'Instructor', 'Desarrollo Web', 1);

INSERT INTO asignacion_instructor_ficha (id_usuario, id_ficha, fecha_inicio, fecha_fin, rol_en_ficha)
VALUES (1, 1, '2026-02-01', NULL, 'Titular');

INSERT INTO aprendiz (documento, nombre, email, qr_token, activo, id_ficha)
VALUES ('1000000001', 'Aprendiz Demo Uno', 'aprendiz1.demo@example.invalid', 'SENA-DEMO-0001', 1, 1);

INSERT INTO telefono_aprendiz (id_aprendiz, numero_telefono, tipo_telefono)
VALUES (1, '3000000001', 'Móvil');

INSERT INTO sesion_asistencia (token, codigo, id_ficha, id_usuario, inicia_en, vence_en, tolerancia_minutos, activa)
VALUES ('a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2', '123456', 1, 1,
        '2026-11-23 07:00:00', '2026-11-23 07:20:00', 10, 1);

INSERT INTO registro_asistencia (
  id_aprendiz, id_sesion, fecha_hora, canal_registro, tarde_minutos,
  latitud, longitud, precision_gps, verificado_gps, consentimiento_datos,
  ip_origen, estado_red, detalle_red
) VALUES (
  1, 1, '2026-11-23 07:12:00', 'movil_qr', 2,
  2.9273100, -75.2819000, 15.50, 1, 1,
  '192.0.2.10', 'permitida', 'Registro de verificacion sintetica'
);

INSERT INTO novedad_contingencia (id_registro, numero_novedad, tipo_novedad, observacion, fecha_reporte)
VALUES (LAST_INSERT_ID(), 1, 'condicion_especial', 'Prueba controlada de entidad debil en motor MariaDB', '2026-11-23 07:13:00');

-- Consultas de comprobación estructural
SHOW TABLES;

SELECT CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'sena_asistencias_diseno'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME;

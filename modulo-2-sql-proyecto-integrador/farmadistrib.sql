-- ============================================================
-- PROYECTO INTEGRADOR SQL — MÓDULO 2
-- Curso: Data Analytics — CoderHouse
-- Empresa ficticia: FarmaDistrib S.A.
-- Descripción: Base de datos organizada por esquemas que
-- representa las áreas de negocio de una distribuidora
-- farmacéutica: ventas, logística y analytics.
-- ============================================================

-- ------------------------------------------------------------
-- PASO 1: Crear la base de datos principal
-- ------------------------------------------------------------
CREATE DATABASE farmadistrib;
USE farmadistrib;

-- ------------------------------------------------------------
-- PASO 2: Crear los esquemas por área de negocio
-- ------------------------------------------------------------
CREATE SCHEMA ventas;
CREATE SCHEMA logistica;
CREATE SCHEMA analytics;

-- ------------------------------------------------------------
-- PASO 3: Tablas del esquema VENTAS
-- ------------------------------------------------------------

-- Tabla de clientes (farmacias y distribuidores)
CREATE TABLE ventas.clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    razon_social VARCHAR(150),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_registro DATETIME NOT NULL
);

-- Tabla de pedidos realizados por los clientes
CREATE TABLE ventas.pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES ventas.clientes(id_cliente)
);

-- ------------------------------------------------------------
-- PASO 4: Tablas del esquema LOGISTICA
-- ------------------------------------------------------------

-- Tabla de depósitos desde donde se despachan los envíos
CREATE TABLE logistica.depositos (
    id_deposito INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    capacidad_m3 DECIMAL(10,2),
    fecha_habilitacion DATE NOT NULL
);

-- Tabla de envíos generados a partir de los pedidos
CREATE TABLE logistica.envios (
    id_envio INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_deposito INT NOT NULL,
    destino VARCHAR(200) NOT NULL,
    fecha_envio DATETIME NOT NULL,
    fecha_entrega_estimada DATE,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_deposito) REFERENCES logistica.depositos(id_deposito)
);

-- ------------------------------------------------------------
-- PASO 5: Tabla del esquema ANALYTICS
-- ------------------------------------------------------------

-- Tabla de reportes generados por el área de datos
CREATE TABLE analytics.reportes (
    id_reporte INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    area_origen VARCHAR(50) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    fecha_actualizacion DATETIME
);

-- ------------------------------------------------------------
-- PASO 6: Creación de usuarios y asignación de permisos
-- ------------------------------------------------------------

-- Usuario del área de ventas: acceso completo solo a ventas
CREATE USER 'usuario_ventas'@'localhost' IDENTIFIED BY 'Ventas2024#';
GRANT SELECT, INSERT, UPDATE ON ventas.* TO 'usuario_ventas'@'localhost';

-- Usuario del área de logística: acceso completo solo a logistica
CREATE USER 'usuario_logistica'@'localhost' IDENTIFIED BY 'Logistica2024#';
GRANT SELECT, INSERT, UPDATE ON logistica.* TO 'usuario_logistica'@'localhost';

-- Usuario de analytics: lectura de todos los esquemas
-- (necesita consultar datos de todas las áreas para generar reportes)
CREATE USER 'usuario_analytics'@'localhost' IDENTIFIED BY 'Analytics2024#';
GRANT SELECT ON analytics.* TO 'usuario_analytics'@'localhost';
GRANT SELECT ON ventas.* TO 'usuario_analytics'@'localhost';
GRANT SELECT ON logistica.* TO 'usuario_analytics'@'localhost';

-- Aplicar todos los cambios de permisos
FLUSH PRIVILEGES;

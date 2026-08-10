-- ═════════════════════════════════════════════════════
-- TechStore — Ventas_Tech_DB
-- Pre-entrega 3: Script SQL de Ingeniería de Datos
-- Autor: Tiziana Heinze
-- Fecha: 10/08/2026
-- ═════════════════════════════════════════════════════


-- ═════════════════════════════════════════════════════
-- CREACIÓN DE LA BASE DE DATOS
-- ═════════════════════════════════════════════════════

-- Crea la base de datos solamente si todavía no existe.
IF DB_ID('Ventas_Tech_DB') IS NULL
BEGIN
    CREATE DATABASE Ventas_Tech_DB;
END;
GO

-- Selecciona la base de datos sobre la que trabajará el script.
USE Ventas_Tech_DB;
GO


-- ═════════════════════════════════════════════════════
-- SECCIÓN DDL
-- Definición de estructura
-- ═════════════════════════════════════════════════════


-- ── DROP TABLES ──────────────────────────────────────
-- Se eliminan en orden inverso de dependencias.
-- Primero las tablas que contienen Foreign Keys.

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- ── CREATE TABLE: categorias ─────────────────────────

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,

    -- VARCHAR(50) permite almacenar nombres de categorías.
    -- NOT NULL garantiza que toda categoría tenga nombre.
    nombre_categoria VARCHAR(50) NOT NULL,

    descripcion VARCHAR(200)
);


-- ── CREATE TABLE: clientes ───────────────────────────

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,

    -- El nombre es un dato obligatorio para identificar al cliente.
    nombre VARCHAR(100) NOT NULL,

    -- UNIQUE evita registrar dos clientes con el mismo email.
    email VARCHAR(100) UNIQUE,

    ciudad VARCHAR(50),

    -- DATE permite almacenar la fecha sin información de hora.
    fecha_registro DATE NOT NULL
);


-- ── CREATE TABLE: productos ──────────────────────────

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,

    nombre_producto VARCHAR(100) NOT NULL,

    -- Relaciona cada producto con una categoría existente.
    id_categoria INT,

    -- DECIMAL(10,2) permite almacenar importes monetarios
    -- sin los problemas de precisión de FLOAT.
    precio DECIMAL(10,2) NOT NULL,

    -- Si no se informa stock, se asigna 0 automáticamente.
    stock INT DEFAULT 0,

    -- SQL Server utiliza TINYINT sin "(1)".
    -- 1 representa activo y 0 inactivo.
    activo TINYINT DEFAULT 1,

    CONSTRAINT FK_productos_categorias
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);


-- ── CREATE TABLE: ventas ─────────────────────────────

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,

    -- Identifica qué cliente realizó la compra.
    id_cliente INT,

    -- Identifica qué producto fue vendido.
    id_producto INT,

    cantidad INT NOT NULL,

    -- Se conserva el precio de la unidad en el momento de la venta.
    precio_unitario DECIMAL(10,2) NOT NULL,

    fecha_venta DATE NOT NULL,

    CONSTRAINT FK_ventas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT FK_ventas_productos
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);


-- ═════════════════════════════════════════════════════
-- SECCIÓN DML
-- Carga inicial de datos
-- ═════════════════════════════════════════════════════


-- ── INSERT: categorias ───────────────────────────────

INSERT INTO categorias
    (id_categoria, nombre_categoria, descripcion)
VALUES
    (1, 'Computación', 'Laptops, PCs y monitores'),
    (2, 'Accesorios', 'Periféricos y complementos'),
    (3, 'Audio', 'Auriculares y parlantes'),
    (4, 'Almacenamiento', 'Discos y memorias');


-- ── INSERT: clientes ─────────────────────────────────

INSERT INTO clientes
    (id_cliente, nombre, email, ciudad, fecha_registro)
VALUES
    (1, 'María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
    (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
    (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01'),
    (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
    (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');


-- ── INSERT: productos ────────────────────────────────

INSERT INTO productos
    (id_producto, nombre_producto, id_categoria, precio, stock, activo)
VALUES
    (1, 'Laptop Pro 15', 1, 1200.00, 15, 1),
    (2, 'Mouse Inalámbrico', 2, 28.00, 80, 1),
    (3, 'Monitor 4K 27"', 1, 450.00, 12, 1),
    (4, 'Auriculares BT Pro', 3, 120.00, 35, 1),
    (5, 'SSD Externo 1TB', 4, 130.00, 18, 1),
    (6, 'Teclado Mecánico', 2, 95.00, 40, 1);


-- ── INSERT: ventas ───────────────────────────────────

INSERT INTO ventas
    (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES
    (1, 1, 1, 2, 1200.00, '2024-03-05'),
    (2, 2, 2, 5, 28.00, '2024-03-06'),
    (3, 3, 3, 1, 450.00, '2024-03-07'),
    (4, 1, 4, 2, 120.00, '2024-03-08'),
    (5, 4, 5, 3, 130.00, '2024-03-10'),
    (6, 2, 6, 4, 95.00, '2024-03-11'),
    (7, 5, 1, 1, 1200.00, '2024-03-12'),
    (8, 3, 2, 8, 28.00, '2024-03-13'),
    (9, 4, 4, 1, 120.00, '2024-03-14'),
    (10, 5, 3, 2, 450.00, '2024-03-15');


-- ═════════════════════════════════════════════════════
-- VALIDACIÓN DE DATOS
-- ═════════════════════════════════════════════════════

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

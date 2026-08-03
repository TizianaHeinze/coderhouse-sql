-- La tabla clientes almacena la información básica de cada cliente.
CREATE TABLE clientes (
    -- INTEGER se utiliza porque el identificador será un número entero.
    id_cliente INTEGER,

    -- VARCHAR(100) permite guardar nombres de hasta 100 caracteres.
    nombre VARCHAR(100),

    -- TEXT permite almacenar una biografía o notas de longitud variable.
    perfil_bio TEXT,

    -- DATE guarda solamente la fecha, sin incluir la hora.
    fecha_registro DATE
);

-- La tabla productos almacena la información de los productos disponibles.
CREATE TABLE productos (
    -- INTEGER se utiliza porque el identificador será un número entero.
    id_producto INTEGER,

    -- VARCHAR(255) permite guardar una descripción de hasta 255 caracteres.
    descripcion VARCHAR(255),

    -- DECIMAL(10,2) permite guardar valores monetarios con dos decimales.
    precio DECIMAL(10,2),

    -- SMALLINT permite representar el estado con 1 para activo y 0 para inactivo.
    esta_activo SMALLINT
);

SELECT * FROM clientes

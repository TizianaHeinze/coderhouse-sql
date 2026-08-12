-- Consulta 1 - Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio agrupados por mes

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2 - Ranking de productos
-- Top 5 productos por total facturado

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3 - Clientes recurrentes
-- Clientes que realizaron más de un pedido

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4 - Meses por encima o por debajo del promedio
-- Compara la facturación de cada mes con el promedio mensual general

WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_facturado)
            FROM ventas_mensuales
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales
ORDER BY mes;

-- =========================================================
-- BLOQUE DE CIERRE - HALLAZGOS
-- =========================================================

-- Hallazgo 1: En marzo se registraron 10 pedidos, con una
-- facturación total de $6.444 y un ticket promedio de $644,40.

-- Hallazgo 2: El producto 1 fue el de mayor facturación,
-- generando $3.600 con solo 3 unidades vendidas.

-- Hallazgo 3: Todos los clientes registrados realizaron 2 pedidos,
-- pero el gasto total varía considerablemente entre ellos:
-- el cliente 1 gastó $2.640, mientras que el cliente 4 gastó $510.
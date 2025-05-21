{{ config(materialized='view') }}

SELECT
  region,
  canal_venta,
  COUNT(*) AS total_ventas,
  SUM(total_venta) AS monto_total,
  ROUND(AVG(total_venta), 2) AS ticket_promedio,
  MIN(total_venta) AS venta_minima,
  MAX(total_venta) AS venta_maxima
FROM {{ source('avivaDataSet', 'ventas') }}
GROUP BY region, canal_venta
QUALIFY RANK() OVER (ORDER BY COUNT(*) DESC) = 1


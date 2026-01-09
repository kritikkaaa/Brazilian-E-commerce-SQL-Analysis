/*
Project: Brazilian E-commerce Operations Analysis
Tool: Google BigQuery
Description:
This file contains SQL queries used to analyze order trends,
customer distribution, payment behavior, freight costs, and
delivery performance.
*/

------------------------------------------------------------
-- 1. Data Exploration
------------------------------------------------------------

-- Sample data from orders table
SELECT *
FROM target_sql.orders
LIMIT 10;

-- Sample data from customers table
SELECT *
FROM target_sql.customers
LIMIT 10;

-- Sample data from products table
SELECT *
FROM target_sql.products
LIMIT 10;

------------------------------------------------------------
-- 2. Order Time Range Analysis
------------------------------------------------------------

-- Time range during which orders were placed
SELECT
  MIN(order_purchase_timestamp) AS start_time,
  MAX(order_purchase_timestamp) AS end_time
FROM target_sql.orders;

------------------------------------------------------------
-- 3. Customer Geography (Jan–Mar 2018)
------------------------------------------------------------

-- Total number of cities and states with orders
SELECT
  COUNT(DISTINCT c.customer_city) AS total_num_of_cities,
  COUNT(DISTINCT c.customer_state) AS total_num_of_states
FROM target_sql.customers AS c
JOIN target_sql.orders AS o
  ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
  AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 3;

-- City and state details with order time
SELECT
  c.customer_state,
  c.customer_city,
  o.order_purchase_timestamp
FROM target_sql.customers AS c
JOIN target_sql.orders AS o
  ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
  AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 3;

------------------------------------------------------------
-- 4. Order Seasonality Analysis
------------------------------------------------------------

-- Monthly order distribution to check seasonality
SELECT
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  COUNT(order_id) AS orders_per_month
FROM target_sql.orders
GROUP BY month
ORDER BY orders_per_month DESC;

------------------------------------------------------------
-- 5. Order Trend Analysis
------------------------------------------------------------

-- Year-month order trend
SELECT
  FORMAT_DATE('%Y-%m', DATE(order_purchase_timestamp)) AS year_month,
  COUNT(order_id) AS orders
FROM target_sql.orders
GROUP BY year_month
ORDER BY year_month;

-- Yearly order trend
SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  COUNT(order_id) AS orders_per_year
FROM target_sql.orders
GROUP BY year
ORDER BY year;

------------------------------------------------------------
-- 6. Time of Day Analysis
------------------------------------------------------------

-- Time of day when most orders are placed
SELECT
  EXTRACT(HOUR FROM order_purchase_timestamp) AS hour_of_day,
  COUNT(order_id) AS num_of_orders
FROM target_sql.orders
GROUP BY hour_of_day
ORDER BY num_of_orders DESC;

------------------------------------------------------------
-- 7. Monthly Orders by State
------------------------------------------------------------

SELECT
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
  c.customer_state AS state,
  COUNT(o.order_id) AS num_of_orders
FROM target_sql.orders AS o
JOIN target_sql.customers AS c
  ON o.customer_id = c.customer_id
GROUP BY year, month, state
ORDER BY year, month, num_of_orders;

------------------------------------------------------------
-- 8. Customer Distribution by State
------------------------------------------------------------

SELECT
  customer_state,
  COUNT(customer_unique_id) AS customer_count
FROM target_sql.customers
GROUP BY customer_state
ORDER BY customer_count DESC;

------------------------------------------------------------
-- 9. Year-over-Year Payment Growth (Jan–Aug)
------------------------------------------------------------

WITH yearly_totals AS (
  SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    SUM(p.payment_value) AS total_payment
  FROM target_sql.payments AS p
  JOIN target_sql.orders AS o
    ON p.order_id = o.order_id
  WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) IN (2017, 2018)
    AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
  GROUP BY year
),
yearly_comparisons AS (
  SELECT
    year,
    total_payment,
    LEAD(total_payment) OVER (ORDER BY year DESC) AS prev_year_payment
  FROM yearly_totals
)
SELECT
  ROUND(
    (total_payment - prev_year_payment) / prev_year_payment * 100,
    2
  ) AS increased_sales_percentage
FROM yearly_comparisons;

------------------------------------------------------------
-- 10. Order Price and Freight Analysis by State
------------------------------------------------------------

SELECT
  COUNT(o.order_id) AS num_of_orders,
  c.customer_state,
  ROUND(SUM(oi.price), 2) AS total_order_price,
  ROUND(AVG(oi.price), 2) AS average_order_price,
  ROUND(SUM(oi.freight_value), 2) AS total_freight_value,
  ROUND(AVG(oi.freight_value), 2) AS average_freight_value
FROM target_sql.order_items AS oi
JOIN target_sql.orders AS o
  ON o.order_id = oi.order_id
JOIN target_sql.customers AS c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY num_of_orders DESC;

------------------------------------------------------------
-- 11. Delivery Time Analysis
------------------------------------------------------------

-- Days taken to deliver each order
SELECT
  order_id,
  DATE_DIFF(
    DATE(order_delivered_customer_date),
    DATE(order_purchase_timestamp),
    DAY
  ) AS days_taken_to_deliver
FROM target_sql.orders;

-- Difference between estimated and actual delivery date
SELECT
  order_id,
  DATE_DIFF(
    DATE(order_delivered_customer_date),
    DATE(order_estimated_delivery_date),
    DAY
  ) AS delivery_estimation_difference
FROM target_sql.orders;

------------------------------------------------------------
-- 12. Freight Cost Extremes by State
------------------------------------------------------------

-- Top 5 states with highest average freight value
SELECT
  c.customer_state,
  COUNT(o.order_id) AS num_of_orders,
  AVG(oi.freight_value) AS average_freight_value
FROM target_sql.order_items AS oi
JOIN target_sql.orders AS o
  ON oi.order_id = o.order_id
JOIN target_sql.customers AS c
  ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY average_freight_value DESC
LIMIT 5;

-- Top 5 states with lowest average freight value
SELECT
  c.customer_state,
  COUNT(o.order_id) AS num_of_orders,
  AVG(oi.freight_value) AS average_freight_value
FROM target_sql.order_items AS oi
JOIN target_sql.orders AS o
  ON oi.order_id = o.order_id
JOIN target_sql.customers AS c
  ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY average_freight_value
LIMIT 5;

------------------------------------------------------------
-- 13. Average Delivery Time by State
------------------------------------------------------------

-- States with highest average delivery time
SELECT
  c.customer_state,
  AVG(
    DATE(order_delivered_customer_date)
    - DATE(order_purchase_timestamp)
  ) AS avg_delivery_time_taken
FROM target_sql.orders AS o
JOIN target_sql.customers AS c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY avg_delivery_time_taken DESC
LIMIT 5;

-- States with lowest average delivery time
SELECT
  c.customer_state,
  AVG(
    DATE(order_delivered_customer_date)
    - DATE(order_purchase_timestamp)
  ) AS avg_delivery_time_taken
FROM target_sql.orders AS o
JOIN target_sql.customers AS c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY avg_delivery_time_taken ASC
LIMIT 5;

------------------------------------------------------------
-- 14. Payment Method Trends
------------------------------------------------------------

-- Month-on-month orders by payment type
SELECT
  p.payment_type,
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
  COUNT(DISTINCT o.order_id) AS num_of_orders
FROM target_sql.payments AS p
JOIN target_sql.orders AS o
  ON o.order_id = p.order_id
GROUP BY payment_type, year, month
ORDER BY payment_type, year, month;

------------------------------------------------------------
-- 15. Orders by Payment Installments
------------------------------------------------------------

SELECT
  payment_installments,
  COUNT(DISTINCT order_id) AS num_of_orders
FROM target_sql.payments
GROUP BY payment_installments
ORDER BY payment_installments;

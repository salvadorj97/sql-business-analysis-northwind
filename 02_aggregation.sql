-- =====================================================================
-- 02 – AGGREGATION: building KPIs (GROUP BY / HAVING)
-- Rule I follow: "per X" in the question = GROUP BY X
-- =====================================================================


-- Q1. Business question:
-- "What is the total revenue per customer? Who are our top 5 customers?"
SELECT  c.company,
        ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue
FROM    customers c
JOIN    orders o         ON o.customer_id = c.id
JOIN    order_details od ON od.order_id   = o.id
GROUP BY c.company
ORDER BY revenue DESC
LIMIT 5;
-- Finding:


-- Q2. Business question:
-- "How many orders did each employee handle, and what is their average order value?"
SELECT  CONCAT(e.first_name, ' ', e.last_name)                       AS employee,
        COUNT(DISTINCT o.id)                                         AS nb_orders,
        ROUND(SUM(od.quantity * od.unit_price) / COUNT(DISTINCT o.id), 2) AS avg_order_value
FROM    employees e
JOIN    orders o         ON o.employee_id = e.id
JOIN    order_details od ON od.order_id   = o.id
GROUP BY employee
ORDER BY nb_orders DESC;
-- Finding:


-- Q3. Business question:
-- "Revenue by product category: where does our business come from?"
SELECT  p.category,
        SUM(od.quantity)                           AS units_sold,
        ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue
FROM    products p
JOIN    order_details od ON od.product_id = p.id
GROUP BY p.category
ORDER BY revenue DESC;
-- Finding:


-- Q4. Business question:
-- "Monthly revenue trend" (input for a Power BI line chart)
SELECT  YEAR(o.order_date)                         AS year,
        MONTH(o.order_date)                        AS month,
        ROUND(SUM(od.quantity * od.unit_price), 2) AS revenue
FROM    orders o
JOIN    order_details od ON od.order_id = o.id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;
-- Finding:


-- Q5. Business question:
-- "Which customers ordered more than 3 times?" (loyal customers)
-- WHERE filters rows BEFORE grouping, HAVING filters groups AFTER.
SELECT  c.company,
        COUNT(o.id) AS nb_orders
FROM    customers c
JOIN    orders o ON o.customer_id = c.id
GROUP BY c.company
HAVING  COUNT(o.id) > 3
ORDER BY nb_orders DESC;
-- Finding:

-- =====================================================================
-- 01 – JOINS: linking facts (orders) to dimensions (customers, products)
-- Database: Northwind (MySQL)
-- =====================================================================


-- Q1. Business question:
-- "For each order, which customer placed it and which employee handled it?"
SELECT  o.id                                   AS order_id,
        o.order_date,
        c.company                              AS customer,
        CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM    orders o
JOIN    customers c ON o.customer_id = c.id
JOIN    employees e ON o.employee_id = e.id
ORDER BY o.order_date;
-- Finding:


-- Q2. Business question:
-- "Show the detail of each order line: product, quantity and line amount."
SELECT  od.order_id,
        p.product_name,
        od.quantity,
        od.unit_price,
        ROUND(od.quantity * od.unit_price, 2) AS line_amount
FROM    order_details od
JOIN    products p ON od.product_id = p.id
ORDER BY od.order_id;
-- Finding:


-- Q3. Business question:
-- "Which customers have never placed an order?" (commercial follow-up list)
-- LEFT JOIN keeps every customer; customers without orders get NULL.
SELECT  c.id,
        c.company
FROM    customers c
LEFT JOIN orders o ON o.customer_id = c.id
WHERE   o.id IS NULL;
-- Finding:


-- Q4. Business question:
-- "Which products have never been sold?" (candidates for catalogue review)
SELECT  p.id,
        p.product_name,
        p.category
FROM    products p
LEFT JOIN order_details od ON od.product_id = p.id
WHERE   od.id IS NULL;
-- Finding:

-- =====================================================================
-- 03 – SUBQUERIES: comparing against a benchmark
-- =====================================================================


-- Q1. Business question:
-- "Which products are priced above the catalogue average?"
SELECT  product_name,
        list_price
FROM    products
WHERE   list_price > (SELECT AVG(list_price) FROM products)
ORDER BY list_price DESC;
-- Finding:


-- Q2. Business question:
-- "Which customers have at least one order shipped to a different city than their address?"
-- EXISTS: I only need to know IF a matching order exists.
SELECT  c.company,
        c.city
FROM    customers c
WHERE   EXISTS (SELECT 1
                FROM   orders o
                WHERE  o.customer_id = c.id
                  AND  o.ship_city  <> c.city);
-- Finding:


-- Q3. Business question:
-- "Which customers spend more than the average customer?"
-- Derived table: first revenue per customer, then compare with the average.
SELECT  t.company,
        t.revenue
FROM   (SELECT  c.company,
                SUM(od.quantity * od.unit_price) AS revenue
        FROM    customers c
        JOIN    orders o         ON o.customer_id = c.id
        JOIN    order_details od ON od.order_id   = o.id
        GROUP BY c.company) AS t
WHERE   t.revenue > (SELECT AVG(x.revenue)
                     FROM  (SELECT SUM(od2.quantity * od2.unit_price) AS revenue
                            FROM   orders o2
                            JOIN   order_details od2 ON od2.order_id = o2.id
                            GROUP BY o2.customer_id) AS x)
ORDER BY t.revenue DESC;
-- Finding:


-- Q4. Business question:
-- "When did each customer place their last order?" (churn risk)
-- Correlated subquery: the inner query is re-run for each customer.
SELECT  c.company,
        (SELECT MAX(o.order_date)
         FROM   orders o
         WHERE  o.customer_id = c.id) AS last_order_date
FROM    customers c
ORDER BY last_order_date;
-- Finding: customers at the top (oldest date or NULL) = at risk of churn.

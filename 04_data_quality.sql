-- =====================================================================
-- 04 – DATA QUALITY: controlling data before it reaches a report
-- In my experience, a dashboard is only as reliable as the data behind it.
-- =====================================================================


-- Q1. Control: "Are there orders not yet shipped, and how late are they?"
SELECT  o.id,
        o.order_date,
        o.shipped_date,
        CASE
            WHEN o.shipped_date IS NULL THEN 'Not shipped'
            WHEN DATEDIFF(o.shipped_date, o.order_date) > 7 THEN 'Late (> 7 days)'
            ELSE 'On time'
        END AS shipping_status
FROM    orders o
ORDER BY shipping_status;
-- Finding:


-- Q2. Control: "How many orders per shipping status?" (KPI for the logistics team)
SELECT  CASE
            WHEN shipped_date IS NULL THEN 'Not shipped'
            WHEN DATEDIFF(shipped_date, order_date) > 7 THEN 'Late (> 7 days)'
            ELSE 'On time'
        END      AS shipping_status,
        COUNT(*) AS nb_orders
FROM    orders
GROUP BY shipping_status;
-- Finding:


-- Q3. Control: "Customers with missing contact data" (to fix before a CRM migration)
SELECT  id,
        company,
        COALESCE(email_address, 'MISSING') AS email,
        COALESCE(city, 'MISSING')          AS city
FROM    customers
WHERE   email_address IS NULL
   OR   city IS NULL;
-- Finding:


-- Q4. Standardisation: "Extract the email domain of each customer contact"
SELECT  company,
        LOWER(email_address)                     AS email,
        SUBSTRING_INDEX(email_address, '@', -1)  AS email_domain
FROM    customers
WHERE   email_address IS NOT NULL;
-- Finding:

# SQL for Business Analysis – Northwind

Business questions answered with SQL (MySQL) on the **Northwind** sample database
(a fictional food distributor: customers, orders, products, suppliers, employees).

I am a Business Analyst profile: I start from the **business question**, not from the code.
Each query below is written the way I work with stakeholders:

1. **Business question** – what the manager actually wants to know
2. **Query** – how I get the answer from the data
3. **Finding** – what the result means for the business

## Data model

Star-like structure: `orders` and `order_details` are the **fact** tables,
the others are **dimensions**.

```
customers.id  ──<  orders.customer_id
employees.id  ──<  orders.employee_id
orders.id     ──<  order_details.order_id
products.id   ──<  order_details.product_id
suppliers.id  ──<  products.supplier_ids
```

## Contents

| File | Topic | Skills shown |
|---|---|---|
| [01_joins.sql](/01_joins.sql) | Linking orders to customers, employees, products | `INNER JOIN`, `LEFT JOIN`, finding missing data |
| [02_aggregation.sql](/02_aggregation.sql) | Sales KPIs per customer, product, employee, month | `GROUP BY`, `HAVING`, `SUM`, `COUNT`, `AVG` |
| [03_subqueries.sql](/03_subqueries.sql) | Comparing against averages, top performers | subqueries, `EXISTS`, correlated subqueries |
| [04_data_quality.sql](/04_data_quality.sql) | Cleaning and controlling data before reporting | `CASE`, `COALESCE`, text and date functions |

## Why this matters for a Business Analyst

- **Answering business questions directly** without waiting for a data team
- **Checking data quality** before it goes into a Power BI report
- **Writing precise functional specs**: knowing how tables link makes requirements clearer for developers
- **Testing (recette)**: comparing what a system shows with what the database contains

## Related projects

- [personal-investment-dashboard](https://github.com/salvadorj97/personal-investment-dashboard) – Power BI star schema, DAX, multi-currency
- [power-bi-real-estate-risk-dashboard](https://github.com/salvadorj97/power-bi-real-estate-risk-dashboard) – Power Query M, risk monitoring
- [power-automate-file-naming](https://github.com/salvadorj97/power-automate-file-naming) – SharePoint automation

---
Salvador Jiménez-Juárez · [LinkedIn](https://www.linkedin.com/in/salvador-jimenez97mx) · [Medium](https://medium.com/@salvador.jimenez-juarez)

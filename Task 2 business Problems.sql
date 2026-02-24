Select *from fmcg_sales;
use fmcg_db;
-- Q1: What are the top 5 product categories by total revenue?

SELECT category,
       ROUND(SUM(total_amount), 2) AS total_revenue,
       ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM fmcg_sales), 2) AS pct_share
FROM fmcg_sales
WHERE invoice_status = 'Invoiced'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;


-- Q2: Who are the top 10 customers by purchase value?

SELECT customer_name,
       customer_code,
       COUNT(DISTINCT invoice_no) AS total_invoices,
       ROUND(SUM(total_amount), 2) AS total_spend,
       ROUND(AVG(total_amount), 2) AS avg_invoice_value
FROM fmcg_sales
WHERE invoice_status = 'Invoiced'
GROUP BY customer_code, customer_name
ORDER BY total_spend DESC
LIMIT 10;

-- Q3: Which salesman generated the highest revenue?
SELECT salesman,
       salesman_type,
       COUNT(DISTINCT invoice_no) AS total_invoices,
       COUNT(DISTINCT customer_code) AS unique_customers,
       ROUND(SUM(total_amount), 2) AS total_revenue,
       ROUND(AVG(total_amount), 2) AS avg_per_line
FROM fmcg_sales
WHERE invoice_status = 'Invoiced'
GROUP BY salesman, salesman_type
ORDER BY total_revenue DESC
LIMIT 10;


-- Q4: What is the discount pattern by category?

SELECT category,
       ROUND(SUM(gross_amount), 2) AS gross_revenue,
       ROUND(SUM(discount_amt), 2) AS total_discount,
       ROUND(SUM(total_amount), 2) AS net_revenue,
       ROUND(SUM(discount_amt) * 100.0 / SUM(gross_amount), 3) AS discount_pct
FROM fmcg_sales
WHERE invoice_status = 'Invoiced'
GROUP BY category
ORDER BY discount_pct DESC;



-- Q5: What is the product-level SKU performance? (Top 10 by revenue)

SELECT sku,
       item_desc,
       category,
       ROUND(SUM(invoice_qty), 0) AS total_units_sold,
       ROUND(SUM(total_amount), 2) AS total_revenue,
       ROUND(AVG(invoice_rate), 2) AS avg_selling_price
FROM fmcg_sales
WHERE invoice_status = 'Invoiced'
GROUP BY sku, item_desc, category
ORDER BY total_revenue DESC
LIMIT 10;


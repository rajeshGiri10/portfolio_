/* Range of date and total records */
 
SELECT 
    COUNT(*) AS total_records,
    MIN(ORDERDATE) AS first_order,
    MAX(ORDERDATE) AS last_order
FROM sales_data_sample_messy;


/* revenue and avg order value */
SELECT 
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_revenue,
    ROUND(AVG(PRICEEACH * QUANTITYORDERED), 2) AS avg_order_value
FROM sales_data_sample_messy;


/* revenue by country */
SELECT 
    COUNTRY,
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_revenue
FROM sales_data_sample_messy
GROUP BY country
ORDER BY total_revenue DESC;


/* monthly sales trend */
SELECT 
    date_format(ORDERDATE, '%Y-%m') AS month,
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS monthly_revenue
FROM sales_data_sample_messy
GROUP BY DATE_FORMAT(ORDERDATE, '%Y-%m')
ORDER BY month;

/* top 10 customer by revenue */
SELECT 
    CUSTOMERNAME,
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_spent
FROM sales_data_sample_messy
GROUP BY CUSTOMERNAME
ORDER BY total_spent DESC
LIMIT 10;


/* top products */
SELECT PRODUCTLINE,SUM(QUANTITYORDERED) AS total_quantity
FROM sales_data_sample_messy
GROUP BY productline
ORDER BY total_quantity DESC
LIMIT 10;

/* revenue by dealsize */
SELECT 
    dealsize,
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_revenue
FROM sales_data_sample_messy
GROUP BY DEALSIZE
ORDER BY total_revenue DESC;


/* sales by days in week */
SELECT 
    DAYNAME(orderdate) AS day_name,
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_revenue
FROM sales_data_sample_messy
GROUP BY DAYNAME(orderdate)
ORDER BY total_revenue DESC;


/* KPI summary */
SELECT
    ROUND(SUM(PRICEEACH * QUANTITYORDERED), 2) AS total_revenue,
    ROUND(AVG(PRICEEACH * QUANTITYORDERED), 2) AS avg_order_value,
    COUNT(DISTINCT customername) AS unique_customers,
    COUNT(DISTINCT productline) AS unique_products
FROM sales_data_sample_messy;


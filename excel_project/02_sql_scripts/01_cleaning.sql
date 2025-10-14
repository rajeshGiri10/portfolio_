/* inspecting the data */
SELECT * FROM sales_data_sample_messy LIMIT 10;

SELECT COUNT(*) AS total_rows FROM sales_data_sample_messy;

SELECT
  SUM(CASE WHEN SALES IS NULL OR SALES = '' THEN 1 ELSE 0 END) AS missing_sales,
  SUM(CASE WHEN PRICEEACH IS NULL OR PRICEEACH = '' THEN 1 ELSE 0 END) AS missing_price,
  SUM(CASE WHEN COUNTRY IS NULL OR COUNTRY = '' THEN 1 ELSE 0 END) AS missing_country
FROM sales_data_sample_messy;


/* cleaning the data */

UPDATE sales_data_sample_messy
SET COUNTRY = TRIM(COUNTRY),
    CUSTOMERNAME = TRIM(CUSTOMERNAME),
    PRODUCTLINE = TRIM(PRODUCTLINE),
    DEALSIZE = TRIM(DEALSIZE);

UPDATE sales_data_sample_messy
SET ORDERDATE =
  CASE
    WHEN ORDERDATE LIKE '%/%/%' THEN STR_TO_DATE(ORDERDATE, '%d/%m/%Y')
    WHEN ORDERDATE LIKE '%-%-%' THEN STR_TO_DATE(ORDERDATE, '%Y-%m-%d')
    ELSE NULL
  END;

UPDATE sales_data_sample_messy
SET COUNTRY = 'UNKNOWN'
WHERE COUNTRY IS NULL OR COUNTRY = '';

UPDATE sales_data_sample_messy s
JOIN (
    SELECT PRODUCTLINE, AVG(PRICEEACH) AS avg_price
    FROM sales_data_sample_messy
    WHERE PRICEEACH IS NOT NULL
    GROUP BY PRODUCTLINE
) p ON s.PRODUCTLINE = p.PRODUCTLINE
SET s.PRICEEACH = p.avg_price
WHERE s.PRICEEACH IS NULL;

UPDATE sales_data_sample_messy
SET SALES = PRICEEACH * QUANTITYORDERED
WHERE SALES IS NULL OR SALES = 0;

ALTER TABLE sales_data_sample_messy ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

DELETE t1 FROM sales_data_sample_messy t1
JOIN sales_data_sample_messy t2
ON t1.ORDERNUMBER = t2.ORDERNUMBER
AND t1.PRODUCTCODE = t2.PRODUCTCODE
AND t1.id > t2.id;

UPDATE sales_data_sample_messy
SET SALES = (SELECT AVG(SALES) FROM sales_data_sample)
WHERE SALES > 100000;








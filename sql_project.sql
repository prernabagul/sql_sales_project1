CREATE DATABASE sql_project_1;
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             (
                transactions_id	INT PRIMARY KEY,
                sale_date DATE,
                sale_time TIME,
                customer_id	INT,
                gender VARCHAR(20),
                age	INT,
                category VARCHAR(20),	
                quantiy	INT,
                price_per_unit FLOAT,
                cogs FLOAT,
                total_sale FLOAT
			 );

select * from retail_sales
limit 10

SELECT 
    COUNT (*)
FROM retail_sales

select * from retail_sales
where transactions_id is NULL

select * from retail_sales
where sale_date is NULL

select * from retail_sales
where
      transactions_id is NULL
      OR
	  sale_date is NULL
	  OR
	  sale_time IS NULL
	  OR
	  gender IS NULL
	  OR 
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;


DELETE from retail_sales
where
      transactions_id is NULL
      OR
	  sale_date is NULL
	  OR
	  sale_time IS NULL
	  OR
	  gender IS NULL
	  OR 
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

-- data EXPLORATION
--how many sales we have
SELECT COUNT(*) AS total_sale FROM retail_sales

--how many customers we have
SELECT COUNT(DISTiNCT customer_id) AS total_sale FROM retail_sales


SELECT DISTiNCT category FROM retail_sales

-- DATA ANALYSIS
--1
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

---2
SELECT 
  *
FROM retail_sales
WHERE category = 'Clothing'
      AND 
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  AND
	  quantiy >= 4

--3

SELECT 
     category,
	 sum(total_sale) AS net_sale,
	 COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1

--4

SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
where category = 'Beauty'

--5

SELECT * FROM retail_sales
where total_sale > 1000

--6

SELECT 
     category,
	 gender,
	 count(*) AS total_trans
FROM retail_sales
group by
      category,
	  gender
ORDER BY 1

--7
select * FROM
(
SELECT 
     EXTRACT(YEAR FROM sale_date) AS year,
	 EXTRACT(MONTH FROM sale_date) AS month,
	 AVG(total_sale) AS avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
from retail_sales
GROUP BY 1, 2
) AS t1 
WHERE rank = 1
-- order by 1, 3 desc

--8 

SELECT
      customer_id,
	  sum(total_sale) AS total_sales
FROM RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9

WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

-- end of project
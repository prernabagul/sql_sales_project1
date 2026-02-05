1. **Retrieve sales made on a specific date**:
   ```sql
   SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
   ```

2. **Filter transactions based on category and quantity sold**:
   ```sql
   SELECT * FROM retail_sales 
   WHERE category = 'Clothing' AND quantity > 10 AND 
         EXTRACT(MONTH FROM sale_date) = 11 AND 
         EXTRACT(YEAR FROM sale_date) = 2022;
   ```

3. **Calculate total sales per category**:
   ```sql
   SELECT category, SUM(total_sale) AS total_sales 
   FROM retail_sales 
   GROUP BY category;
   ```

4. **Find the average age of customers by category**:
   ```sql
   SELECT AVG(age) AS average_age 
   FROM retail_sales 
   WHERE category = 'Beauty';
   ```

5. **Identify high-value transactions**:
   ```sql
   SELECT * FROM retail_sales 
   WHERE total_sale > 1000;
   ```

6. **Transactions by gender and category**:
   ```sql
   SELECT category, gender, COUNT(transactions_id) AS total_transactions 
   FROM retail_sales 
   GROUP BY category, gender;
   ```

7. **Average sales per month and identify the best-selling month**:
   ```sql
   SELECT EXTRACT(MONTH FROM sale_date) AS month, 
          EXTRACT(YEAR FROM sale_date) AS year, 
          AVG(total_sale) AS average_sales
   FROM retail_sales 
   GROUP BY year, month;
   ```

8. **Top 5 customers by total sales**:
   ```sql
   SELECT customer_id, SUM(total_sale) AS total_spent 
   FROM retail_sales 
   GROUP BY customer_id 
   ORDER BY total_spent DESC 
   LIMIT 5;
   ```

9. **Unique customers per category**:
   ```sql
   SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
   FROM retail_sales 
   GROUP BY category;
   ```

10. **Order analysis by shift (Morning, Afternoon, Evening)**:
    ```sql
    SELECT 
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening' 
        END AS shift,
        COUNT(transactions_id) AS total_orders
    FROM retail_sales 
    GROUP BY shift;
    ```
1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
```

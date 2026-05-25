CREATE TABLE retail_sales (
    transaction_id INT,
    date DATE,
    customer_id VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);

SELECT * FROM retail_sales;

-- Customer Demographics--
-- What is the gender breakdown of customers?
SELECT gender, COUNT(gender) AS gender_count FROM retail_sales
GROUP BY gender;

-- What is the average age of customers per product category?
SELECT product_category, ROUND(AVG(age), 2) AS average_age  FROM retail_sales
GROUP BY product_category;

-- Which gender spends more on average per transaction?
SELECT gender, ROUND(AVG(total_amount), 2) AS average_transaction FROM retail_sales
GROUP BY gender
ORDER BY average_transaction DESC


-- Which age group generates the most revenue?
SELECT 
	CASE
		WHEN age BETWEEN 18 AND 30 THEN '18-30'
		WHEN age BETWEEN 31 AND 45 THEN '31-45'
		WHEN age BETWEEN 46 AND 60 THEN '46-60'
		ELSE '60+'
	END AS age_group, 
	SUM (total_amount) AS total_revenue 
FROM retail_sales
GROUP BY age_group
ORDER BY total_revenue DESC;

--Sales Trends--

-- What is the monthly revenue trend over time?
SELECT 
	EXTRACT(YEAR from date) AS year,
	EXTRACT(MONTH from date) AS month,
	SUM(total_amount) AS monthly_revenue
FROM retail_sales
	GROUP BY year, month
	ORDER BY year, month;

-- Which month has the highest number of transactions?
SELECT
	EXTRACT(YEAR from date) AS year,
	EXTRACT(MONTH from date) AS month,
	COUNT(transaction_id) AS transaction_counts
FROM retail_sales
	GROUP BY year, month
	ORDER BY transaction_counts DESC
	LIMIT 1;

-- Are there specific months where certain product categories sell more?
SELECT 
	EXTRACT(MONTH from date) AS month,
	product_category, 
	COUNT(product_category) AS product_count
FROM retail_sales
	GROUP BY month, product_category
	ORDER BY month, product_count DESC;

--Product Performance--

--Which product category generates the most revenue?
SELECT product_category, SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY product_category
ORDER BY revenue DESC;

--Which product category has the highest average price per unit?
SELECT product_category, ROUND(AVG(price_per_unit), 2) AS average_price
FROM retail_sales
GROUP BY product_category
ORDER BY average_price DESC;

--Which product category is purchased in the highest quantities?
SELECT product_category, SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity DESC;

--What is the revenue contribution (percentage) of each product category?
SELECT product_category,
    ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM retail_sales), 2) AS revenue_contribution
FROM retail_sales
GROUP BY product_category
ORDER BY revenue_contribution DESC;

--Customer Behavior--

--What is the average spending per transaction by gender?
SELECT gender, ROUND(AVG(total_amount), 2) AS average_spending
FROM retail_sales
GROUP BY gender;

--What is the average quantity purchased per transaction?
SELECT AVG(quantity) AS average_quantity
FROM retail_sales;

--Who spends more per transaction — younger or older customers?
SELECT
	CASE
		WHEN age BETWEEN 18 AND 40 THEN 'younger_customer'
		ELSE 'older_customer'
	END AS customer_base,
	ROUND(AVG(total_amount), 2) AS avg_transaction
FROM retail_sales
GROUP BY customer_base
ORDER BY avg_transaction DESC;
		

--Which product category is most popular among each gender?
SELECT gender, product_category, COUNT(product_category) AS popular_category
FROM retail_sales
GROUP BY gender, product_category
ORDER BY gender, popular_category DESC
LIMIT 1;

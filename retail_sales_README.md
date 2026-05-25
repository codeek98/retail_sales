# 🛍️ Retail Sales & Customer Demographics Analysis — SQL Project

## Project Overview

This project analyzes a retail sales dataset to uncover patterns in customer demographics, product preferences, and purchasing behavior using SQL (PostgreSQL). The goal is to practice exploratory data analysis (EDA) and draw actionable insights that retailers could use to enhance their strategies and customer experiences.

---

## Dataset

- **Source:** Kaggle — Retail Sales and Customer Demographics Dataset
- **Type:** Synthetic (mirrors real-world retail scenarios)
- **Records:** 1,000 transactions
- **Columns:** 9

| Column | Data Type | Description |
|---|---|---|
| transaction_id | INT | Unique identifier for each transaction |
| date | DATE | Date of the transaction |
| customer_id | VARCHAR | Unique identifier for each customer |
| gender | VARCHAR | Gender of the customer (Male/Female) |
| age | INT | Age of the customer |
| product_category | VARCHAR | Category of purchased product |
| quantity | INT | Number of units purchased |
| price_per_unit | DECIMAL | Price of one unit |
| total_amount | DECIMAL | Total monetary value of the transaction |

---

## Tools Used

- **PostgreSQL** — Database
- **pgAdmin 4** — Query interface

---

## Business Questions & Queries

### Customer Demographics

**1. What is the gender breakdown of customers?**
```sql
SELECT gender, COUNT(*) AS gender_count
FROM retail_sales
GROUP BY gender;
```

**2. What is the average age of customers per product category?**
```sql
SELECT product_category, ROUND(AVG(age), 2) AS average_age
FROM retail_sales
GROUP BY product_category;
```

**3. Which gender spends more on average per transaction?**
```sql
SELECT gender, ROUND(AVG(total_amount), 2) AS average_transaction
FROM retail_sales
GROUP BY gender
ORDER BY average_transaction DESC;
```

**4. Which age group generates the most revenue?**
```sql
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY age_group
ORDER BY total_revenue DESC;
```

### Sales Trends

**5. What is the monthly revenue trend over time?**
```sql
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY year, month
ORDER BY year, month;
```

**6. Which month has the highest number of transactions?**
```sql
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    COUNT(transaction_id) AS transaction_counts
FROM retail_sales
GROUP BY year, month
ORDER BY transaction_counts DESC
LIMIT 1;
```

**7. Are there specific months where certain product categories sell more?**
```sql
SELECT 
    EXTRACT(MONTH FROM date) AS month,
    product_category,
    COUNT(product_category) AS product_count
FROM retail_sales
GROUP BY month, product_category
ORDER BY month, product_count DESC;
```

### Product Performance

**8. Which product category generates the most revenue?**
```sql
SELECT product_category, SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY product_category
ORDER BY revenue DESC;
```

**9. Which product category has the highest average price per unit?**
```sql
SELECT product_category, ROUND(AVG(price_per_unit), 2) AS average_price
FROM retail_sales
GROUP BY product_category
ORDER BY average_price DESC;
```

**10. Which product category is purchased in the highest quantities?**
```sql
SELECT product_category, SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity DESC;
```

**11. What is the revenue contribution (percentage) of each product category?**
```sql
SELECT product_category,
    ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM retail_sales), 2) AS revenue_contribution
FROM retail_sales
GROUP BY product_category
ORDER BY revenue_contribution DESC;
```

### Customer Behavior

**12. What is the average spending per transaction by gender?**
```sql
SELECT gender, ROUND(AVG(total_amount), 2) AS average_spending
FROM retail_sales
GROUP BY gender;
```

**13. What is the average quantity purchased per transaction?**
```sql
SELECT AVG(quantity) AS average_quantity
FROM retail_sales;
```

**14. Who spends more per transaction — younger or older customers?**
```sql
SELECT
    CASE
        WHEN age BETWEEN 18 AND 40 THEN 'younger_customer'
        WHEN age BETWEEN 41 AND 70 THEN 'older_customer'
    END AS customer_base,
    ROUND(AVG(total_amount), 2) AS avg_transaction
FROM retail_sales
GROUP BY customer_base
ORDER BY avg_transaction DESC;
```

**15. Which product category is most popular among each gender?**
```sql
SELECT gender, product_category, COUNT(product_category) AS popular_category
FROM retail_sales
GROUP BY gender, product_category
ORDER BY gender, popular_category DESC;
```

---

## Key Findings

- **Electronics** contributed the most to overall revenue, though its share was similar to Clothing — suggesting a fairly balanced product mix
- **Male and female customers** had very similar average spending per transaction, indicating gender has minimal influence on spending amount
- **Customers aged 46-60** generated the most revenue, making them the most valuable age segment
- **Customers aged 60+** had the lowest spending, suggesting this group may need targeted promotions
- **Younger customers (18-40)** tend to spend more per transaction compared to older customers (41-70)

---

## Skills Demonstrated

- `COUNT()`, `SUM()`, `AVG()`, `ROUND()` aggregate functions
- `EXTRACT()` for date-based analysis
- `CASE` statements for age group segmentation and custom sorting
- Subqueries for percentage calculations
- Multi-column `GROUP BY` and `ORDER BY`
- `LIMIT` for top N results

---

## How to Run

1. Install [PostgreSQL](https://www.postgresql.org/) and pgAdmin 4
2. Create a new database in pgAdmin
3. Run the `CREATE TABLE` statement below
4. Import `retail_sales.csv` via pgAdmin's Import/Export tool (ensure Header is toggled ON)
5. Open and run queries from `retail_sales_analysis.sql`

```sql
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
```

---

## About Me

I am currently transitioning into a data analytics career and building this portfolio to demonstrate my SQL skills. This is one of several projects I am working on as part of my self-learning journey.

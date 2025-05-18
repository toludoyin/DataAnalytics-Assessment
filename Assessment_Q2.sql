-- Transaction Frequency Analysis

WITH user_savings AS (
    SELECT * FROM users_customuser
    JOIN savings_savingsaccount USING()
)

freq_by_month AS (
    SELECT 
    DATE_TRUNC( , MONTH) AS monthly,
    COUNT(DISTINCT owner_id) AS customer_count,
    AVG(id) AS avg_transactions_per_month
    FROM user_savings
)

SELECT *,
CASE WHEN avg_transactions_per_month >= 10 THEN "High Frequency"
WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN "Medium Frequency"
WHEN avg_transactions_per_month <= 2 THEN "Low Frequency"
END AS frequency_category
FROM freq_by_month
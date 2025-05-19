-- Transaction Frequency Analysis
USE adashi_staging;
 
-- counts number of transactions per customer each month.
WITH freq_by_month AS (
SELECT 
    uc.id AS user_id,
    DATE_FORMAT(ss.transaction_date, '%Y-%m-01') AS transactions_month,
    COUNT(DISTINCT ss.id) AS transactions_per_month 
FROM users_customuser AS uc
JOIN savings_savingsaccount AS ss ON ss.owner_id = uc.id
WHERE ss.transaction_status = 'success'
GROUP BY uc.id, DATE_FORMAT(ss.transaction_date, '%Y-%m-01')
),

avg_txn AS (
SELECT  
    user_id,
    AVG(transactions_per_month) AS avg_txn_per_month
FROM freq_by_month
GROUP BY user_id
)

SELECT 
	DISTINCT frequency_category,
	COUNT(user_id) AS customer_count,
	ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM (
SELECT 
    *, 
    CASE WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
    WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
    END AS frequency_category
FROM avg_txn
) AS temp_freq_cat
GROUP BY frequency_category;
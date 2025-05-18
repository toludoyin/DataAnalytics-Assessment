-- High-Value Customers with Multiple Products

WITH user_plans AS (
    SELECT * FROM users_customuser
    JOIN savings_savingsaccount USING()
    JOIN plans_plan USING()
)

SELECT 
owner_id,
name,
COUNT() AS savings_count,
COUNT() AS investment_count,
SUM() AS total_deposits
FROM user_plans
WHERE (savings_count >=1
AND investment_count >=1)
GROUP BY owner_id, name
ORDER BY 5 DESC
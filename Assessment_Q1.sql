-- High-Value Customers with Multiple Products
USE adashi_staging;

WITH funded_users AS (
SELECT 
	DISTINCT uc.id AS owner_id, 
	CONCAT(uc.first_name, ' ', uc.last_name) AS name, 
    SUM(is_regular_savings) AS savings_count,
	SUM(pp.is_a_fund) AS investment_count, 
	ROUND(SUM(ss.confirmed_amount), 2) AS total_deposits
FROM users_customuser AS uc
JOIN plans_plan AS pp ON pp.owner_id = uc.id
JOIN savings_savingsaccount AS ss ON ss.plan_id = pp.id
WHERE ss.transaction_status = 'success'
GROUP BY owner_id, name
 )
 
SELECT * FROM funded_users
WHERE savings_count >=1 
AND investment_count >=1
ORDER BY total_deposits DESC;
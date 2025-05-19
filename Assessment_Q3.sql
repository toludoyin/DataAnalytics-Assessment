-- Account Inactivity Alert

USE adashi_staging;

WITH inactive_users AS ( 
SELECT 
	ss.plan_id, 
	ss.owner_id, 
	ss.transaction_date, 
	'Savings' AS type,
	ROW_NUMBER() OVER (PARTITION BY owner_id, plan_id ORDER BY transaction_date DESC) AS row_num,
	DATEDIFF(NOW(), ss.transaction_date) AS inactivity_days
FROM savings_savingsaccount AS ss 
JOIN plans_plan AS pp ON pp.id = ss.plan_id
WHERE ss.transaction_status = 'success'
AND pp.is_archived = 0
AND (pp.is_a_fund = 1 OR pp.is_regular_savings = 1)
)

SELECT 
	plan_id, 
	owner_id, 
	transaction_date, 
	type,
	inactivity_days
FROM inactive_users
WHERE row_num = 1
AND inactivity_days <= 365;
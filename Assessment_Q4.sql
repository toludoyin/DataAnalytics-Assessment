-- Customer Lifetime Value (CLV) Estimation

USE adashi_staging;

SELECT 
	customer_id,
	name,
	tenure_months,
	total_transactions,
	ROUND((total_transactions / tenure_months) * 12 * AVG(profit_per_transaction),2) AS estimated_clv
FROM (
    SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    date_joined,
    COUNT(ss.id) AS total_transactions,
    ROUND((SUM(confirmed_amount)) * 0.001,2) AS profit_per_transaction,
    TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
FROM users_customuser AS uc
JOIN savings_savingsaccount AS ss ON ss.owner_id = uc.id
WHERE ss.transaction_status = 'success'
GROUP BY 1,2,3
) AS temp_clv_estimation
GROUP BY 1,2,3,4
ORDER BY 5 DESC;

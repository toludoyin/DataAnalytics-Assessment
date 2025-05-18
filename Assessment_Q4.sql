-- Customer Lifetime Value (CLV) Estimation

SELECT *, 
(total_transactions / tenure) * 12 * avg_profit_per_transaction
 FROM (
    SELECT 
    customer_id,
    name,
    tenure_months,
    SUM() AS total_transactions,
    estimated_clv
    FROM users_customuser
    JOIN savings_savingsaccount USING()
) AS temp_clv_estimation
ORDER BY estimated_clv DESC;

-- Account Inactivity Alert

WITH inactive_users AS (
    SELECT 
    plan_id,
    owner_id,
    type,
    ROW_NUMBER() OVER (PARTITION BY owner_id, plan_id ORDER BY transaction_date DESC) AS rn_transaction_date,
    -- last_transaction_date,
    transaction_date - NOW() AS inactivity_days
    FROM plans_plan
    JOIN savings_savingsaccount USING()
)

SELECT * FROM inactive_users
WHERE rn_transaction_date = 1
AND inactivity_days >= 365
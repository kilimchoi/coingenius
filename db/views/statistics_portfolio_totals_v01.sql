SELECT DISTINCT ON(coins.id)
users.id AS user_id,
coins.id AS coin_id,
MAX(transactions.transaction_date) AS last_created_at,
SUM(transactions.amount) AS total_amount
FROM transactions
JOIN users ON users.id = transactions.user_id
LEFT JOIN coins ON coins.id = transactions.coin_id
WHERE transactions.is_expired = False
GROUP BY users.id, coins.id, transactions.amount, transactions.transaction_date

SELECT *,
  EXTRACT(ISODOW FROM week_starts_at)::int as week_number
FROM (
  SELECT date_trunc('week', transactions.created_at::date) AS week_starts_at,
  COUNT(transactions.id) as transactions_count,
  SUM(transactions.amount) as amount,
  users.id as user_id
  FROM transactions
  JOIN users ON users.id = transactions.user_id
  GROUP BY week_starts_at, users.id
  ORDER BY week_starts_at
) AS tr

SELECT *,
  (CAST(week_number AS VARCHAR) || '-' || user_id) AS id
FROM (
  SELECT *,
  EXTRACT(WEEK FROM week_starts_at)::int AS week_number,
  (week_starts_at + INTERVAL '6 days') AS week_ends_at
  FROM (
    SELECT date_trunc('week', transactions.transaction_date::date) AS week_starts_at,
    COUNT(transactions.id) AS transactions_count,
    SUM(transactions.price * transactions.amount) AS price,
    users.id AS user_id
    FROM transactions
    JOIN users ON users.id = transactions.user_id
    GROUP BY week_starts_at, users.id
    ORDER BY week_starts_at
  ) AS tr1
) AS tr2

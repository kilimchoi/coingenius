WITH dates AS (
  SELECT MIN(date_trunc('week', transaction_date)) AS start_week,
         MAX(date_trunc('week', transaction_date)) AS end_week
  FROM transactions
  ),
  weeks AS (
    SELECT *,
    CONCAT(
      EXTRACT(ISOYEAR FROM sub_dates.week_starts_at)::int,
      '-',
      LPAD(EXTRACT(WEEK FROM sub_dates.week_starts_at)::text, 2, '0')
    ) AS week_number
    FROM (
      SELECT generate_series(start_week, end_week, '7 days') AS week_starts_at,
             generate_series(start_week + INTERVAL '6 days', end_week + INTERVAL '6 days', '7 days') AS week_ends_at
      FROM dates
    ) AS sub_dates
  )

SELECT DISTINCT *, uuid_generate_v3(uuid_ns_x500(), CONCAT(week_number, user_id, coin_id)) AS id
FROM (
  SELECT
  weeks.*,
  users.id AS user_id,
  coins.id AS coin_id,
  COUNT(transactions.id) OVER week_user_coin AS weekly_transactions_count,
  SUM(transactions.amount) OVER week_user_coin AS weekly_total,
  SUM(transactions.amount) OVER user_and_coin AS total_amount
  FROM weeks
  JOIN transactions ON date_trunc('week', transactions.transaction_date) = weeks.week_starts_at
  JOIN users ON users.id = transactions.user_id
  LEFT JOIN coins ON coins.id = transactions.coin_id
  WHERE transactions.is_expired = False
  GROUP BY weeks.week_number, weeks.week_starts_at, weeks.week_ends_at,
            users.id, coins.id, transactions.id, transactions.amount
  WINDOW week_user_coin AS (PARTITION BY weeks.week_starts_at, users.id, coins.id),
         user_and_coin AS (PARTITION BY users.id, coins.id ORDER BY weeks.week_starts_at ASC)
  ORDER BY weeks.week_starts_at
) AS transactions_subquery;

CREATE INDEX ON weekly_user_transactions_groups (user_id);
CREATE INDEX ON weekly_user_transactions_groups (coin_id);
CREATE INDEX ON weekly_user_transactions_groups (week_number);

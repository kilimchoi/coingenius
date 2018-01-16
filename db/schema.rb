# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180114125700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.integer "resource_id"
    t.string "resource_type"
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "binance_deposits", force: :cascade do |t|
    t.jsonb "raw_data"
    t.datetime "executed_at"
    t.string "uuid"
    t.bigint "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_binance_deposits_on_transaction_id"
    t.index ["uuid"], name: "index_binance_deposits_on_uuid"
  end

  create_table "binance_orders", force: :cascade do |t|
    t.bigint "transaction_id"
    t.string "uuid"
    t.jsonb "raw_data"
    t.datetime "executed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_binance_orders_on_transaction_id"
    t.index ["uuid"], name: "index_binance_orders_on_uuid"
  end

  create_table "binance_withdrawals", force: :cascade do |t|
    t.string "uuid"
    t.datetime "executed_at"
    t.jsonb "raw_data"
    t.bigint "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_binance_withdrawals_on_transaction_id"
    t.index ["uuid"], name: "index_binance_withdrawals_on_uuid", unique: true
  end

  create_table "bittrex_orders", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "closed_at"
    t.datetime "executed_at", null: false
    t.integer "bittrex_orders_history_import_id"
    t.index ["transaction_id"], name: "index_bittrex_orders_on_transaction_id"
  end

  create_table "bittrex_orders_history_imports", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "file_content"
    t.datetime "processed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_bittrex_orders_history_imports_on_user_id"
  end

  create_table "coinbase_buys", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_buys_on_transaction_id"
  end

  create_table "coinbase_deposits", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_deposits_on_transaction_id"
  end

  create_table "coinbase_receiveds", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_receiveds_on_transaction_id"
  end

  create_table "coinbase_sells", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_sells_on_transaction_id"
  end

  create_table "coinbase_sents", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_sents_on_transaction_id"
  end

  create_table "coinbase_withdrawals", id: :serial, force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb "raw_data"
    t.string "uuid", null: false
    t.index ["transaction_id"], name: "index_coinbase_withdrawals_on_transaction_id"
  end

  create_table "coins", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.string "description"
    t.string "website"
    t.text "pros"
    t.string "where_to_buy"
    t.string "consensus_mechanism"
    t.string "category"
    t.string "name"
    t.text "cons"
    t.string "image_url"
    t.boolean "shapeshift_convertible", default: false, null: false
    t.index ["symbol"], name: "index_coins_on_symbol", unique: true
  end

  create_table "coins_exchanges", id: false, force: :cascade do |t|
    t.integer "coin_id"
    t.integer "exchange_id"
  end

  create_table "conversion_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.jsonb "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "conversion_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversion_id", "most_recent"], name: "index_conversion_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["conversion_id", "sort_key"], name: "index_conversion_transitions_parent_sort", unique: true
  end

  create_table "conversions", force: :cascade do |t|
    t.integer "receive_coin_id"
    t.integer "sending_coin_id"
    t.bigint "user_id"
    t.decimal "amount", null: false
    t.decimal "rate", null: false
    t.decimal "max_amount"
    t.decimal "min_amount"
    t.string "return_address", comment: "Address for refunding in case of failed conversion"
    t.string "withdrawal_address", comment: "Address to send requested coin"
    t.string "deposit_address", comment: "Address to send coin to"
    t.jsonb "raw_data", comment: "Raw response from ShapeShift"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_coin_id"], name: "index_conversions_on_receive_coin_id"
    t.index ["sending_coin_id"], name: "index_conversions_on_sending_coin_id"
    t.index ["user_id"], name: "index_conversions_on_user_id"
  end

  create_table "email_subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "enabled", default: false
    t.string "kind", default: "weekly_portfolio_report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_email_subscriptions_on_user_id"
  end

  create_table "exchanges", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "website"
    t.text "pros"
    t.text "cons"
    t.boolean "cc_supported"
    t.boolean "verification_required"
    t.text "deposit_withdrawal_limit"
    t.text "fees"
    t.text "description"
    t.integer "rank"
  end

  create_table "identities", id: :serial, force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.integer "user_id"
    t.string "access_token"
    t.string "refresh_token"
    t.index ["uid", "provider"], name: "index_identities_on_uid_and_provider"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "statistics_weekly_portfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "week_number", null: false
    t.decimal "total", default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_statistics_weekly_portfolios_on_user_id"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "transaction_type"
    t.decimal "price"
    t.decimal "amount"
    t.integer "coin_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "converted_coin_price"
    t.datetime "transaction_date"
    t.boolean "is_expired", default: false
    t.bigint "converted_coin_id"
    t.bigint "linked_transaction_id"
    t.index ["coin_id"], name: "index_transactions_on_coin_id"
    t.index ["converted_coin_id"], name: "index_transactions_on_converted_coin_id"
    t.index ["linked_transaction_id"], name: "index_transactions_on_linked_transaction_id"
    t.index ["transaction_type"], name: "index_transactions_on_transaction_type"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_api_credentials", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "encrypted_secret"
    t.string "encrypted_secret_iv"
    t.integer "nonce", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.index ["key"], name: "index_user_api_credentials_on_key"
    t.index ["user_id"], name: "index_user_api_credentials_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "is_admin", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bittrex_api_key"
    t.string "bittrex_api_secret"
    t.string "user_currency"
    t.string "binance_api_key"
    t.string "binance_api_secret"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "binance_orders", "transactions"
  add_foreign_key "bittrex_orders", "bittrex_orders_history_imports"
  add_foreign_key "bittrex_orders", "transactions"
  add_foreign_key "bittrex_orders_history_imports", "users"
  add_foreign_key "coinbase_buys", "transactions"
  add_foreign_key "coinbase_deposits", "transactions"
  add_foreign_key "coinbase_receiveds", "transactions"
  add_foreign_key "coinbase_sells", "transactions"
  add_foreign_key "coinbase_sents", "transactions"
  add_foreign_key "coinbase_withdrawals", "transactions"
  add_foreign_key "conversion_transitions", "conversions"
  add_foreign_key "conversions", "coins", column: "receive_coin_id"
  add_foreign_key "conversions", "coins", column: "sending_coin_id"
  add_foreign_key "conversions", "users"
  add_foreign_key "email_subscriptions", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "statistics_weekly_portfolios", "users"
  add_foreign_key "transactions", "coins", column: "converted_coin_id"
  add_foreign_key "transactions", "transactions", column: "linked_transaction_id"
  add_foreign_key "user_api_credentials", "users"

  create_view "weekly_user_transactions_groups", materialized: true,  sql_definition: <<-SQL
      WITH dates AS (
           SELECT min(date_trunc('week'::text, transactions.transaction_date)) AS start_week,
              max(date_trunc('week'::text, transactions.transaction_date)) AS end_week
             FROM transactions
          ), weeks AS (
           SELECT sub_dates.week_starts_at,
              sub_dates.week_ends_at,
              concat((date_part('isoyear'::text, sub_dates.week_starts_at))::integer, '-', lpad((date_part('week'::text, sub_dates.week_starts_at))::text, 2, '0'::text)) AS week_number
             FROM ( SELECT generate_series(dates.start_week, dates.end_week, '7 days'::interval) AS week_starts_at,
                      generate_series((dates.start_week + '6 days'::interval), (dates.end_week + '6 days'::interval), '7 days'::interval) AS week_ends_at
                     FROM dates) sub_dates
          )
   SELECT DISTINCT transactions_subquery.week_starts_at,
      transactions_subquery.week_ends_at,
      transactions_subquery.week_number,
      transactions_subquery.user_id,
      transactions_subquery.coin_id,
      transactions_subquery.weekly_transactions_count,
      transactions_subquery.weekly_total,
      transactions_subquery.total_amount,
      uuid_generate_v3(uuid_ns_x500(), concat(transactions_subquery.week_number, transactions_subquery.user_id, transactions_subquery.coin_id)) AS id
     FROM ( SELECT weeks.week_starts_at,
              weeks.week_ends_at,
              weeks.week_number,
              users.id AS user_id,
              coins.id AS coin_id,
              count(transactions.id) OVER week_user_coin AS weekly_transactions_count,
              sum(transactions.amount) OVER week_user_coin AS weekly_total,
              sum(transactions.amount) OVER user_and_coin AS total_amount
             FROM (((weeks
               JOIN transactions ON ((date_trunc('week'::text, transactions.transaction_date) = weeks.week_starts_at)))
               JOIN users ON ((users.id = transactions.user_id)))
               LEFT JOIN coins ON ((coins.id = transactions.coin_id)))
            WHERE (transactions.is_expired = false)
            GROUP BY weeks.week_number, weeks.week_starts_at, weeks.week_ends_at, users.id, coins.id, transactions.id, transactions.amount
            WINDOW week_user_coin AS (PARTITION BY weeks.week_starts_at, users.id, coins.id), user_and_coin AS (PARTITION BY users.id, coins.id ORDER BY weeks.week_starts_at)
            ORDER BY weeks.week_starts_at) transactions_subquery;
  SQL

  add_index "weekly_user_transactions_groups", ["coin_id"], name: "weekly_user_transactions_groups_coin_id_idx"
  add_index "weekly_user_transactions_groups", ["user_id"], name: "weekly_user_transactions_groups_user_id_idx"
  add_index "weekly_user_transactions_groups", ["week_number"], name: "weekly_user_transactions_groups_week_number_idx"

  create_view "statistics_portfolio_totals",  sql_definition: <<-SQL
      SELECT DISTINCT ON (coins.id) users.id AS user_id,
      coins.id AS coin_id,
      max(transactions.transaction_date) AS last_created_at,
      sum(transactions.amount) AS total_amount
     FROM ((transactions
       JOIN users ON ((users.id = transactions.user_id)))
       LEFT JOIN coins ON ((coins.id = transactions.coin_id)))
    WHERE (transactions.is_expired = false)
    GROUP BY users.id, coins.id, transactions.amount, transactions.transaction_date;
  SQL

end

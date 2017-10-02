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

ActiveRecord::Schema.define(version: 20170928062535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["symbol"], name: "index_coins_on_symbol", unique: true
  end

  create_table "coins_exchanges", id: false, force: :cascade do |t|
    t.integer "coin_id"
    t.integer "exchange_id"
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

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "transaction_type"
    t.decimal "price"
    t.decimal "amount"
    t.integer "coin_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "btc_price"
    t.datetime "transaction_date"
    t.boolean "is_expired", default: false
    t.index ["coin_id"], name: "index_transactions_on_coin_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bittrex_orders", "bittrex_orders_history_imports"
  add_foreign_key "bittrex_orders", "transactions"
  add_foreign_key "bittrex_orders_history_imports", "users"
  add_foreign_key "coinbase_buys", "transactions"
  add_foreign_key "coinbase_deposits", "transactions"
  add_foreign_key "coinbase_receiveds", "transactions"
  add_foreign_key "coinbase_sells", "transactions"
  add_foreign_key "coinbase_sents", "transactions"
  add_foreign_key "coinbase_withdrawals", "transactions"
  add_foreign_key "email_subscriptions", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "user_api_credentials", "users"

  create_view "weekly_user_transactions_groups", materialized: true,  sql_definition: <<-SQL
      SELECT tr2.week_starts_at,
      tr2.transactions_count,
      tr2.amount,
      tr2.user_id,
      tr2.week_number,
      tr2.week_ends_at,
      ((((tr2.week_number)::character varying)::text || '-'::text) || tr2.user_id) AS id
     FROM ( SELECT tr1.week_starts_at,
              tr1.transactions_count,
              tr1.amount,
              tr1.user_id,
              (date_part('week'::text, tr1.week_starts_at))::integer AS week_number,
              (tr1.week_starts_at + '6 days'::interval) AS week_ends_at
             FROM ( SELECT date_trunc('week'::text, ((transactions.created_at)::date)::timestamp with time zone) AS week_starts_at,
                      count(transactions.id) AS transactions_count,
                      sum(transactions.amount) AS amount,
                      users.id AS user_id
                     FROM (transactions
                       JOIN users ON ((users.id = transactions.user_id)))
                    GROUP BY (date_trunc('week'::text, ((transactions.created_at)::date)::timestamp with time zone)), users.id
                    ORDER BY (date_trunc('week'::text, ((transactions.created_at)::date)::timestamp with time zone))) tr1) tr2;
  SQL

end

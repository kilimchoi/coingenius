# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170809213708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bittrex_deposits", force: :cascade do |t|
    t.integer  "transaction_id"
    t.jsonb    "raw_data"
    t.string   "uuid"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bittrex_deposits", ["transaction_id"], name: "index_bittrex_deposits_on_transaction_id", using: :btree

  create_table "coinbase_buys", force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb   "raw_data"
    t.string  "uuid",           null: false
  end

  add_index "coinbase_buys", ["transaction_id"], name: "index_coinbase_buys_on_transaction_id", using: :btree

  create_table "coinbase_sells", force: :cascade do |t|
    t.integer "transaction_id"
    t.jsonb   "raw_data"
    t.string  "uuid",           null: false
  end

  add_index "coinbase_sells", ["transaction_id"], name: "index_coinbase_sells_on_transaction_id", using: :btree

  create_table "coins", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "symbol"
    t.string   "description"
    t.string   "website"
    t.text     "pros"
    t.string   "where_to_buy"
    t.string   "consensus_mechanism"
    t.string   "category"
    t.string   "name"
    t.text     "cons"
    t.string   "image_url"
  end

  add_index "coins", ["symbol"], name: "index_coins_on_symbol", unique: true, using: :btree

  create_table "coins_exchanges", id: false, force: :cascade do |t|
    t.integer "coin_id"
    t.integer "exchange_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name"
    t.string   "website"
    t.text     "pros"
    t.text     "cons"
    t.boolean  "cc_supported"
    t.boolean  "verification_required"
    t.text     "deposit_withdrawal_limit"
    t.text     "fees"
    t.text     "description"
    t.integer  "rank"
  end

  create_table "identities", force: :cascade do |t|
    t.string  "uid"
    t.string  "provider"
    t.integer "user_id"
    t.string  "access_token"
    t.string  "refresh_token"
  end

  add_index "identities", ["uid", "provider"], name: "index_identities_on_uid_and_provider", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "transaction_type"
    t.decimal  "price"
    t.decimal  "amount"
    t.integer  "coin_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "transactions", ["coin_id"], name: "index_transactions_on_coin_id", using: :btree
  add_index "transactions", ["transaction_type"], name: "index_transactions_on_transaction_type", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "username",               default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "is_admin",               default: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "bittrex_api_key"
    t.string   "bittrex_api_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "bittrex_deposits", "transactions"
  add_foreign_key "coinbase_buys", "transactions"
  add_foreign_key "coinbase_sells", "transactions"
  add_foreign_key "identities", "users"
end

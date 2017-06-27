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

ActiveRecord::Schema.define(version: 20170627001416) do

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

  add_index "coins", ["symbol"], name: "index_coins_on_symbol", unique: true

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

  create_table "transactions", force: :cascade do |t|
    t.integer  "transaction_type"
    t.decimal  "price"
    t.decimal  "amount"
    t.integer  "coin_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "transactions", ["coin_id"], name: "index_transactions_on_coin_id"
  add_index "transactions", ["transaction_type"], name: "index_transactions_on_transaction_type"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end

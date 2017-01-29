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

ActiveRecord::Schema.define(version: 20170129012605) do

  create_table "portfolios", force: :cascade do |t|
    t.decimal  "USD",        precision: 2
    t.decimal  "CAD",        precision: 2
    t.decimal  "EUR",        precision: 2
    t.decimal  "JPY",        precision: 2
    t.decimal  "GBP",        precision: 2
    t.decimal  "CHF",        precision: 2
    t.decimal  "AUD",        precision: 2
    t.decimal  "ZAR",        precision: 2
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "from_currency"
    t.string   "to_currency"
    t.decimal  "amount_spent"
    t.decimal  "amount_bought"
    t.decimal  "exch_rate"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.decimal  "available_credit",       precision: 2
    t.date     "went_broke_at"
    t.integer  "bankruptcy_count"
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

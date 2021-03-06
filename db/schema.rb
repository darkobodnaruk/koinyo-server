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

ActiveRecord::Schema.define(version: 20141103195509) do

  create_table "addresses", force: true do |t|
    t.string  "address"
    t.string  "privkey"
    t.string  "pubkey"
    t.boolean "server_managed"
    t.integer "user_id"
  end

  create_table "tx_outputs", force: true do |t|
    t.integer "txout_id"
    t.integer "indexin"
    t.integer "txin_id"
    t.integer "indexout"
    t.integer "address_id"
    t.integer "amount"
  end

  create_table "txs", force: true do |t|
    t.integer  "target_address_id"
    t.string   "txid"
    t.datetime "dt"
  end

  add_index "txs", ["target_address_id"], name: "index_txs_on_target_address_id"

  create_table "users", force: true do |t|
    t.string   "phone_number"
    t.string   "name"
    t.string   "access_token"
    t.string   "confirmation_code"
    t.datetime "cc_issued_at"
    t.datetime "cc_confirmed_at"
    t.boolean  "server_managed"
  end

end

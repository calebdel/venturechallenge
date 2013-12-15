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

ActiveRecord::Schema.define(version: 20131215213253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: true do |t|
    t.string   "name"
    t.integer  "kind_id"
    t.integer  "points"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.integer  "customer_id"
    t.string   "city"
    t.boolean  "accepts_marketing"
    t.integer  "orders_count"
    t.integer  "total_spent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kinds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "badge_id"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "subtotal_price"
    t.string   "shopify_id"
    t.string   "referring_site"
    t.integer  "total_discounts"
    t.float    "cost"
  end

  create_table "points", force: true do |t|
    t.integer  "kind_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
  end

  create_table "stores", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_orders"
    t.integer  "customer_count"
    t.integer  "order_count"
    t.integer  "user_id"
    t.integer  "league_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linkedin_uid"
    t.string   "phone"
    t.string   "linkedin_token"
    t.string   "shopify_token"
  end

end

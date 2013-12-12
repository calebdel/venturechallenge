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

ActiveRecord::Schema.define(version: 20131212050228) do

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

  create_table "kinds", force: true do |t|
    t.string   "name"
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
    t.integer  "user_id"
    t.integer  "kind_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
=======
    t.integer  "store_id"
>>>>>>> 63ae8b675d52e77a680886664f0ae1cc0e3f8fb2
  end

  create_table "stores", force: true do |t|
    t.string   "myshopify_domain"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_orders"
    t.integer  "customer_count"
    t.integer  "order_count"
  end

  create_table "users", force: true do |t|
    t.string   "shop"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
  end

end

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

ActiveRecord::Schema.define(version: 20130813135559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_informations", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "expiration"
    t.string   "type"
    t.string   "brand"
    t.string   "number"
    t.string   "cvv"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "billing_informations", ["user_id"], name: "index_billing_informations_on_user_id", using: :btree

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.float    "total_at_checkout"
    t.datetime "payment_at"
    t.float    "payment_amount"
    t.integer  "billing_information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["billing_information_id"], name: "index_carts_on_billing_information_id", using: :btree
  add_index "carts", ["shop_id"], name: "index_carts_on_shop_id", using: :btree
  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "shops", force: true do |t|
    t.integer  "user_id"
    t.integer  "city_id"
    t.boolean  "published"
    t.string   "logo"
    t.string   "address1"
    t.string   "address2"
    t.text     "directions"
    t.string   "website1"
    t.string   "website2"
    t.string   "website3"
    t.string   "website4"
    t.string   "website5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["city_id"], name: "index_shops_on_city_id", using: :btree
  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

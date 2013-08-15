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

ActiveRecord::Schema.define(version: 20130815112752) do

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

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "descriptions", force: true do |t|
    t.integer  "language_id"
    t.string   "name"
    t.text     "description"
    t.integer  "describable_id"
    t.string   "describable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descriptions", ["describable_id", "describable_type"], name: "index_descriptions_on_describable_id_and_describable_type", using: :btree
  add_index "descriptions", ["language_id"], name: "index_descriptions_on_language_id", using: :btree

  create_table "guest_profiles", force: true do |t|
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guest_profiles", ["language_id"], name: "index_guest_profiles_on_language_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "quantity"
    t.integer  "shop_id"
    t.integer  "max_adults"
    t.boolean  "published"
    t.float    "default_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["shop_id"], name: "index_items_on_shop_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "abbr"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_adjustments", force: true do |t|
    t.integer  "item_id"
    t.string   "price"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_adjustments", ["item_id"], name: "index_price_adjustments_on_item_id", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.string   "keyword"
    t.date     "checkin_at"
    t.date     "checkout_at"
    t.integer  "adults"
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["item_id"], name: "index_searches_on_item_id", using: :btree
  add_index "searches", ["shop_id"], name: "index_searches_on_shop_id", using: :btree
  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

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
    t.integer  "profile_id"
    t.string   "profile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["profile_id", "profile_type"], name: "index_users_on_profile_id_and_profile_type", using: :btree

end

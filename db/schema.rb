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

ActiveRecord::Schema.define(version: 20131120210709) do

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
    t.string   "ip_address"
  end

  add_index "billing_informations", ["user_id"], name: "index_billing_informations_on_user_id", using: :btree

  create_table "bookings", force: true do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.string   "responsible_name"
    t.integer  "adults"
    t.string   "name_at_checkout"
    t.integer  "quantity"
    t.boolean  "confirmed",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["cart_id"], name: "index_bookings_on_cart_id", using: :btree
  add_index "bookings", ["item_id"], name: "index_bookings_on_item_id", using: :btree

  create_table "carts", force: true do |t|
    t.datetime "submitted_at"
    t.datetime "processing_payment_at"
    t.datetime "payment_processed_at"
    t.datetime "authorizing_payment_at"
    t.datetime "cancelled_at"
    t.float    "payment_amount"
    t.integer  "billing_information_id"
    t.string   "state"
    t.string   "email"
    t.string   "phone"
    t.string   "order_confirmation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "search_id"
    t.integer  "user_id"
  end

  add_index "carts", ["billing_information_id"], name: "index_carts_on_billing_information_id", using: :btree
  add_index "carts", ["search_id"], name: "index_carts_on_search_id", using: :btree
  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "confirmations", force: true do |t|
    t.text     "message"
    t.string   "type"
    t.integer  "booking_id"
    t.datetime "sent_at"
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confirmations", ["booking_id"], name: "index_confirmations_on_booking_id", using: :btree
  add_index "confirmations", ["recipient_id", "recipient_type"], name: "index_confirmations_on_recipient_id_and_recipient_type", using: :btree
  add_index "confirmations", ["sender_id", "sender_type"], name: "index_confirmations_on_sender_id_and_sender_type", using: :btree

  create_table "contact_forms", force: true do |t|
    t.string   "subject"
    t.string   "from"
    t.string   "to"
    t.string   "state"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

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
    t.integer  "quantity"
    t.integer  "shop_id"
    t.integer  "max_adults"
    t.boolean  "published",     default: false
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

  create_table "line_items", force: true do |t|
    t.integer  "booking_id"
    t.float    "unit_price_at_checkout"
    t.date     "booking_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["booking_id"], name: "index_line_items_on_booking_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "ancestry"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_profiles", force: true do |t|
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
    t.string   "role"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_profiles", ["email"], name: "index_member_profiles_on_email", unique: true, using: :btree
  add_index "member_profiles", ["language_id"], name: "index_member_profiles_on_language_id", using: :btree
  add_index "member_profiles", ["reset_password_token"], name: "index_member_profiles_on_reset_password_token", unique: true, using: :btree

  create_table "phones", force: true do |t|
    t.integer  "shop_id"
    t.string   "number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["shop_id"], name: "index_phones_on_shop_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "photo"
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["photoable_id", "photoable_type"], name: "index_photos_on_photoable_id_and_photoable_type", using: :btree

  create_table "price_adjustments", force: true do |t|
    t.integer  "item_id"
    t.float    "price"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_adjustments", ["item_id"], name: "index_price_adjustments_on_item_id", using: :btree

  create_table "responsibilities", force: true do |t|
    t.integer  "user_id"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responsibilities", ["shop_id"], name: "index_responsibilities_on_shop_id", using: :btree
  add_index "responsibilities", ["user_id"], name: "index_responsibilities_on_user_id", using: :btree

  create_table "room_searches", force: true do |t|
    t.integer  "search_id"
    t.integer  "adults"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "room_searches", ["search_id"], name: "index_room_searches_on_search_id", using: :btree

  create_table "search_suggestions", force: true do |t|
    t.string   "term"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.string   "keyword"
    t.date     "checkin_at"
    t.date     "checkout_at"
    t.integer  "user_id"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["shop_id"], name: "index_searches_on_shop_id", using: :btree
  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "shop_requests", force: true do |t|
    t.integer  "shop_owner_profile_id"
    t.integer  "salesperson_profile_id"
    t.integer  "location_id"
    t.string   "state"
    t.text     "request"
    t.string   "shop_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
  end

  add_index "shop_requests", ["location_id"], name: "index_shop_requests_on_location_id", using: :btree
  add_index "shop_requests", ["salesperson_profile_id"], name: "index_shop_requests_on_salesperson_profile_id", using: :btree
  add_index "shop_requests", ["shop_id"], name: "index_shop_requests_on_shop_id", using: :btree
  add_index "shop_requests", ["shop_owner_profile_id"], name: "index_shop_requests_on_shop_owner_profile_id", using: :btree

  create_table "shopper_profiles", force: true do |t|
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "shopper_profiles", ["email"], name: "index_shopper_profiles_on_email", unique: true, using: :btree
  add_index "shopper_profiles", ["language_id"], name: "index_shopper_profiles_on_language_id", using: :btree
  add_index "shopper_profiles", ["reset_password_token"], name: "index_shopper_profiles_on_reset_password_token", unique: true, using: :btree

  create_table "shops", force: true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "published",      default: false
    t.string   "logo"
    t.string   "address1"
    t.string   "address2"
    t.text     "directions"
    t.string   "website1"
    t.string   "website2"
    t.string   "website3"
    t.string   "website4"
    t.string   "website5"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.float    "commission_pct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shops", ["location_id"], name: "index_shops_on_location_id", using: :btree
  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "sms", force: true do |t|
    t.integer  "cart_id"
    t.text     "message"
    t.integer  "phone_id"
    t.boolean  "incoming"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms", ["cart_id"], name: "index_sms_on_cart_id", using: :btree
  add_index "sms", ["phone_id"], name: "index_sms_on_phone_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type", using: :btree

  create_table "tags", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "profile_id"
    t.string   "profile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["profile_id", "profile_type"], name: "index_users_on_profile_id_and_profile_type", using: :btree

end

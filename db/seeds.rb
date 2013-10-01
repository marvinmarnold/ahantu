# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl'
require 'seeder'

Language.create(name: "English", abbr: "en", default: true)
Language.create(name: "Français", abbr: "fr")
Language.create(name: "Kinyarwanda", abbr: "ky")
Seeder.gen_locations("vendor/rwanda.csv")

Seeder.create_hotel_tags
Seeder.create_default_accounts
FactoryGirl.create_list(:complete_shop_w_items,
  3,
  city: City.all.sample,
  user: MemberProfile.shop_owners.first.user
)

FactoryGirl.create_list(:complete_shop_w_items,
  40,
  city: City.all.sample
)

Shop.all.each do |s|
  s.responsibilities.create!(user_id: MemberProfile.salespersons.first.user.id)
end
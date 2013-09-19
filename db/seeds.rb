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
FactoryGirl.create_list(:complete_shop_w_items, 40)

Seeder.create_default_accounts
Shop.all.each do |s|
  s.responsibilities.create!(user_id: SalespersonProfile.first.id)
end
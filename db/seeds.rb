require 'factory_girl'
require 'seeder'

$redis.flushall

Language.create(name: "English", abbr: "en", default: true)
Language.create(name: "Français", abbr: "fr")
Language.create(name: "Kinyarwanda", abbr: "ky")
Seeder.gen_locations("vendor/rwanda.csv")

Seeder.create_hotel_tags
Seeder.create_room_tags
Seeder.create_default_accounts
Seeder.preload_hotels

Shop.all.each do |s|
  s.responsibilities.create!(user_id: MemberProfile.salespersons.first.user.id)
end




# FactoryGirl.create_list(:complete_shop_w_items,
#   5,
#   city: City.all.sample,
#   user: MemberProfile.shop_owners.first.user
# )
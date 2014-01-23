require 'factory_girl'
require 'seeder'

$redis.flushall

Language.create(name: "English", abbr: "en", default: true)
Language.create(name: "Français", abbr: "fr")
Language.create(name: "Kinyarwanda", abbr: "ky")
Seeder.gen_locations("vendor/rwanda.csv")

# Seeder.create_hotel_tags
# Seeder.create_room_tags
# # Seeder.create_default_accounts
# Seeder.preload_hotels

FactoryGirl.create_list(:complete_shop_w_items,
  20,
  location: Location.all.sample,
  user: MemberProfile.shop_owners.first.user
)

Shop.all.each do |s|
  s.responsibilities.create!(user_id: MemberProfile.salespersons.first.user.id)
end

ShopRequest.all.each do |sr|
  sr.assign_to MemberProfile.salespersons.first.user
end

FactoryGirl.create_list(:cart_submitted, 20, user: MemberProfile.shoppers.first.user)
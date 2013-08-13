json.array!(@shops) do |shop|
  json.extract! shop, :user_id, :city_id, :published, :logo, :address1, :address2, :directions, :website1, :website2, :website3, :website4, :website5
  json.url shop_url(shop, format: :json)
end

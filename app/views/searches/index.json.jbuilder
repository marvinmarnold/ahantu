json.array!(@searches) do |search|
  json.extract! search, :keyword, :checkin_at, :checkout_at, :adults, :user_id, :item_id, :shop_id
  json.url search_url(search, format: :json)
end

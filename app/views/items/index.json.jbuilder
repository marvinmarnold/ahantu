json.array!(@items) do |item|
  json.extract! item, :quantity, :shop_id, :max_adults, :published, :default_price
  json.url item_url(item, format: :json)
end

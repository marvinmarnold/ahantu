json.array!(@shop_requests) do |shop_request|
  json.extract! shop_request, :user_id, :state, :request
  json.url shop_request_url(shop_request, format: :json)
end

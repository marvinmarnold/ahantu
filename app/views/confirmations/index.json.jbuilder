json.array!(@confirmations) do |confirmation|
  json.extract! confirmation, :message, :type, :text, :booking_id, :sent_at
  json.url confirmation_url(confirmation, format: :json)
end

json.array!(@contacts) do |contact|
  json.extract! contact, :type, :user_id, :value
  json.url contact_url(contact, format: :json)
end

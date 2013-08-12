json.array!(@billing_informations) do |billing_information|
  json.extract! billing_information, :first_name, :last_name, :expiration, :type
  json.url billing_information_url(billing_information, format: :json)
end

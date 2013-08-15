json.array!(@descriptions) do |description|
  json.extract! description, :language_id, :name, :description, :describable_id
  json.url description_url(description, format: :json)
end

json.array!(@locations) do |location|
  json.extract! location, :id, :code
  json.url location_url(location, format: :json)
end

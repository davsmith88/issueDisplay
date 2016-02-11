json.array!(@media) do |medium|
  json.extract! medium, :id, :location, :description
  json.url medium_url(medium, format: :json)
end

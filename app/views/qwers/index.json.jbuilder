json.array!(@qwers) do |qwer|
  json.extract! qwer, :id, :name
  json.url qwer_url(qwer, format: :json)
end

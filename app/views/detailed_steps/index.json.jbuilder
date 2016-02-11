json.array!(@detailed_steps) do |detailed_step|
  json.extract! detailed_step, :id, :number, :description
  json.url detailed_step_url(detailed_step, format: :json)
end

json.array!(@lineups) do |lineup|
  json.extract! lineup, :id, :position_number, :job_number, :master_spec, :machine
  json.url lineup_url(lineup, format: :json)
end

json.array!(@processareas) do |processarea|
  json.extract! processarea, :id, :complaint_id, :process_area_type
  json.url processarea_url(processarea, format: :json)
end

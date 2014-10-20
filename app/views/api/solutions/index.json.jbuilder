json.set! :solutions do
	json.array!(@solutions) do |solution|
		json.set! :id, solution.id
		json.set! :content, solution.content
	end
end
json.set! :workarounds do
	json.array!(@workarounds) do |workaround|
		json.set! :id, workaround.id
		json.set! :content, workaround.description
	end
end
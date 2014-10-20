if @workaround.valid?
	json.set! :workaround do
		json.set! :id, @workaround.id
		json.set! :content, @workaround.description
		json.set! :issue, @workaround.issue.id
	end
else
	json.set! :errors do
		json.set! :content, @workaround.errors[:description]
	end
end


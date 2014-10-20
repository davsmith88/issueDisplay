if @solution.valid?
	json.set! :solution do
		json.set! :id, @solution.id
		json.set! :content, @solution.content
		json.set! :issue, @solution.issue.id
	end
else
	json.set! :errors do
		json.set! :content, @solution.errors[:content]
	end
end
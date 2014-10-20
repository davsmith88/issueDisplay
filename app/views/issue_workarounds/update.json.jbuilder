if @issue_workaround.valid?
	json.set! :workaround do
		json.set! :id, @issue_workaround.id
		json.set! :content, @issue_workaround.description
		json.set! :issue, @issue.id
	end
else
	json.set! :errors do
		json.set! :content, @issue_workaround.errors[:description]
	end
end


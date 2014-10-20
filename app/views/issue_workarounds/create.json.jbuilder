if @issue_workaround.valid?
	json.set! :workaround do
		json.set! :id, @issue_workaround.id.to_s
		json.set! :content, @issue_workaround.description
		json.set! :issue, @issue_workaround.issue_id.to_s
	end
else
	json.set! :errors do
		json.set! :content, @issue_workaround.errors[:description]
	end
end
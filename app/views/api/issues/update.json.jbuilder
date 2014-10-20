json.set! :issue do
	json.extract! @issue, :id, :name, :description
	json.set! :author, @issue.user_id
end
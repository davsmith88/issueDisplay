json.set! :issue do
	json.set! :id, @issue.id
	json.set! :name, @issue.name
	json.set! :description, @issue.description
	json.set! :author, @issue.user_id
end
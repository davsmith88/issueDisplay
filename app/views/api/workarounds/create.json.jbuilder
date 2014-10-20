json.set! :workaround do
	json.set! :id, @workaround.id
	json.set! :content, @workaround.description
	json.set! :issue, @workaround.issue.id
end
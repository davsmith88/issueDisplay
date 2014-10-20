json.set! :solution do
	json.set! :id, @solution.id
	json.set! :content, @solution.content
	json.set! :issue, @solution.issue.id
end
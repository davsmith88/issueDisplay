json.set! :issues do
	json.array!(@issues) do |issue|
	  json.extract! issue, :id, :name, :description
	  json.set! :createdAt, issue.created_at
	  json.set! :updatedAt, issue.updated_at
	  json.set! :reviewDate, issue.review_date
	  json.set! :author, issue.user_id
	  json.set! :state, issue.state
	  # below will extract just the id's from the issue_workarounds
	  json.set! :workarounds, issue.issue_workarounds.map(&:id)
	  json.set! :solutions, issue.solutions.map(&:id)
	  
	end
	#json.array!(@user_issues) do |user_issue|
	  #json.extract! user_issue, :id, :name, :description
	 # json.set! :createdAt, user_issue.created_at
	 # json.set! :updatedAt, user_issue.updated_at
	 # json.set! :reviewDate, user_issue.review_date
	 # json.set! :author, user_issue.user_id
	 # json.set! :state, user_issue.state
	  # below will extract just the id's from the issue_workarounds
	 # json.set! :workarounds, user_issue.issue_workarounds.map(&:id)
	#  json.set! :solutions, user_issue.solutions.map(&:id)
	#end
end

json.set! :workarounds do
	@issues.each do |issue|
		json.array!(issue.issue_workarounds) do |workaround|
			json.extract! workaround, :id
			json.set! :createdAt, issue.created_at
			json.set! :updatedAt, issue.updated_at
			json.set! :content, workaround.description
			json.set! :issue, issue.id
		end
	end
end

json.set! :solutions do
	@issues.each do |issue|
		json.array!(issue.solutions) do |solution|
			json.extract! solution, :id
			json.set! :createdAt, issue.created_at
			json.set! :updatedAt, issue.updated_at
			#json.set! :content, solution.description
		end
	end
end
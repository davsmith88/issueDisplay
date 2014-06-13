class IssueManagementController < ApplicationController

	def index
		@issues = Issue.all
	end

end

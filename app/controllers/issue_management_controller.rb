class IssueManagementController < ApplicationController

	def index
		@issues = Issue.all.page(params[:page])
		render layout: "admin_layout"
	end

	def show
		@issue = Issue.find(params[:id])
		render layout: "admin_layout"
	end
end

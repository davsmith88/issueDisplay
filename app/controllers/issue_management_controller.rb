class IssueManagementController < ApplicationController

	def index
		@issues = Issue.all.page(params[:page])
		render layout: "admin_layout"
	end

	def show
		@issue = Issue.find(params[:id])
		render layout: "admin_layout"
	end

	def view
		@issue = Issue.find(params[:issue_management_id])
		render layout: "admin_layout"
	end

	def new
		render layout: "admin_layout"
	end

	def create

	end

	def edit
		render layout: "admin_layout"
	end

	def update

	end
end

class IssueManagementController < ApplicationController

	def index
		@issues = scoped.page(params[:page])
		render layout: "admin_layout"
	end

	def show
		@issue = scoped.find(params[:id])
		render layout: "admin_layout"
	end

	def view
		@issue = scoped.find(params[:issue_management_id])
		render layout: "admin_layout"
	end

	def new
		render layout: "admin_layout"
	end

	def create
		# when creating the issue have to assign the business id to the issue
	end

	def edit
		render layout: "admin_layout"
	end

	def update

	end

	private

	def scoped
		current_user.business.issues
	end
end

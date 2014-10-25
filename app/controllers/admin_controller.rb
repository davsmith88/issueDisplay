class AdminController < ApplicationController

	def index
		render layout: "admin_layout"
	end

	def show
		
	end

	def users
		@users = User.all.page(params[:page])
		render layout: "admin_layout", template: "admin/static/user"
	end

	def permissions
		render layout: "admin_layout", template: "admin/static/permissions"
	end

	def depareas
		render layout: "admin_layout", template: "admin/static/department_areas"
	end
end

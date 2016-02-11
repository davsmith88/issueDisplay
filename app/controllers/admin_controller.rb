class AdminController < ApplicationController
	# skip_authorization_check
	authorize_resource class: false

	def index
		render layout: "admin_layout"
	end

	def show
		# authorize! :show, :admin
	end

	def users
		# business = current_user.business
		@users = current_user.business.users.page(params[:page])
		render layout: "admin_layout", template: "admin/static/user"
	end

	def permissions
		render layout: "permission_static", template: "admin/static/permissions"
	end

	# def depareas
	# 	render layout: "departments_area", template: "admin/static/department_areas"
	# end

	def review_management
		# render layout: "admin_layout", template: "admin/static/review_management"
	end
end

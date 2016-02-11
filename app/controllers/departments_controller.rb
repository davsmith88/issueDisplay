class DepartmentsController < ApplicationController

	load_and_authorize_resource

	def index
		@active_departments = true
		@departments = scoped.page(params[:page])
		render layout: "departments_area"
	end

	def new
		@active_departments = true
		@department = Department.new
		render layout: "departments_area"
	end

	def create
		@department = Department.new(department_params)
		# @department.business_id = current_user.business.id
		respond_to do |format|
			if @department.save
				format.html {redirect_to departments_path}
			else
				format.html {render action: 'new', layout: "admin_layout"}
			end
		end
	end

	def edit
		@department = scoped.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@department = scoped.find(params[:id])

		respond_to do |format|
			if @department.update(department_params)
				format.html {redirect_to departments_path}
			else
				format.html { render action: 'edit', layout: "admin_layout"}
			end
		end
	end

	def destroy
		@department = scoped.find(params[:id])
		@department.delete

		respond_to do |format|
			format.html {redirect_to departments_path, notice: "Department was destroyed"}
		end
	end

	private

	def department_params
		params.require(:department).permit(:name, :description)
	end

	def scoped
		# current_user.business.departments
		Department.all
	end
end

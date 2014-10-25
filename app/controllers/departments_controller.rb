class DepartmentsController < ApplicationController

	def index
		@departments = Department.all.page(params[:page])
		render layout: "admin_layout"
	end

	def new
		@department = Department.new
		render layout: "permissions"
	end

	def create
		@department = Department.new(department_params)
		respond_to do |format|
			if @department.save
				format.html {redirect_to departments_path}
			else
				format.html {render action: 'new', layout: "admin_layout"}
			end
		end
	end

	def edit
		@department = Department.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@department = Department.find(params[:id])

		respond_to do |format|
			if @department.update(department_params)
				format.html {redirect_to departments_path}
			else
				format.html { render action: 'edit', layout: "admin_layout"}
			end
		end
	end

	def destroy
		@department = Department.find(params[:id])
		@department.delete

		respond_to do |format|
			format.html {redirect_to departments_path, notice: "Department was destroyed"}
		end
	end

	private

	def department_params
		params.require(:department).permit(:name, :description)
	end
end

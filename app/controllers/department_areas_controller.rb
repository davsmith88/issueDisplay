class DepartmentAreasController < ApplicationController
	def index
		@active_dp = true
		@depAreas = scoped.includes(:department, :area).page(params[:page])
		render layout: "departments_area"
	end

	def new
		@active_dp = true
		@depArea = DepartmentArea.new
		@departments = current_user.business.departments.all
		@areas = current_user.business.areas.all
		render layout: "departments_area"
	end

	def create
		area = current_user.business.areas.find(params["department_area"][:area_id])
		department = current_user.business.departments.find(params["department_area"][:department_id])
		@depArea = DepartmentArea.new(dep_area_params)
		@depArea.business_id = current_user.business.id
		@depArea.name = "#{department.name} #{area.name}"
		@depArea.save
		respond_to do |format|
			
			format.html {redirect_to department_areas_path, notice: "Deparment/area has been added"}
			
		end
	end

	def destroy
		@depArea = scoped.find(params[:id])

		respond_to do |format|
			if @depArea.destroy
				format.html {redirect_to department_areas_path, notice: "Department / area has been deleted"}
			end
		end
	end

	private

	def dep_area_params
		params.require(:department_area).permit(:department_id, :area_id)
	end

	def scoped
		current_user.business.department_areas
	end
end

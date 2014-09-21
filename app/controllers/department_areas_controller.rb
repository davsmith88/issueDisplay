class DepartmentAreasController < ApplicationController
	def index
		@depAreas = DepartmentArea.all.includes(:department, :area)
		render layout: "admin_layout"
	end

	def new
		@depArea = DepartmentArea.new
		@departments = Department.all
		@areas = Area.all
		render layout: "admin_layout"
	end

	def create
		area = Area.find(params["department_area"][:area_id])
		department = Department.find(params["department_area"][:department_id])
		@depArea = DepartmentArea.new(dep_area_params)
		@depArea.name = "#{department.name} #{area.name}"
		@depArea.save
		respond_to do |format|
			
			format.html {redirect_to department_areas_path, notice: "Deparment/area has been added"}
			
		end
	end

	def destroy
		@depArea = DepartmentArea.find(params[:id])

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
end

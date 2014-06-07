class DepartmentAreasController < ApplicationController
	def index
		@depAreas = DepartmentArea.all.includes(:department, :area)
	end

	def new
		@depArea = DepartmentArea.new
		@departments = Department.all
		@areas = Area.all

	end

	def create
		@depArea = DepartmentArea.create(dep_area_params)
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

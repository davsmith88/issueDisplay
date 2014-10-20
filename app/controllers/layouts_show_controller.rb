class LayoutsShowController < ApplicationController
	def show
		@dep_areas = DepartmentArea.all
	end
end
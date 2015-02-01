class AreasController < ApplicationController

	def index
		@active_areas = true
		@areas = scoped.page(params[:page])
		render layout: "departments_area"
	end

	def new
		@active_areas = true
		@area = Area.new
		render layout: "departments_area"
	end

	def create
		@area = Area.new(area_params)
		@area.business_id = current_user.business.id
		
		respond_to do |format|
			if @area.save
				format.html {redirect_to areas_path, notice: "Area has been added"}
			else
				format.html { render action: "new", layout: "departments_area" }
			end
		end
	end

	def edit
		@area = scoped.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@area = scoped.find(params[:id])
		respond_to do |format|
			if @area.update(area_params)
				format.html {redirect_to areas_path, notice: "Area has been updated"}
			else
				format.html {render action: "edit", layout: "admin_layout"}
			end
		end
	end

	def destroy
		@area = scoped.find(params[:id])
		@area.destroy

		respond_to do |format|
			format.html {redirect_to areas_path, notice: "Area has been deleted"}
		end
	end

	private

	def area_params
		params.require(:area).permit(:name, :description)
	end

	def scoped
		current_user.business.areas
	end
end

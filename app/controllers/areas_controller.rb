class AreasController < ApplicationController

	def index
		@areas = Area.all.page(params[:page])
		render layout: "admin_layout"
	end

	def new
		@area = Area.new
		render layout: "admin_layout"
	end

	def create
		@area = Area.new(area_params)

		respond_to do |format|
			if @area.save
				format.html {redirect_to areas_path, notice: "Area has been added"}
			else
				format.html { render action: "new", layout: "admin_layout" }
			end
		end
	end

	def edit
		@area = Area.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@area = Area.find(params[:id])
		respond_to do |format|
			if @area.update(area_params)
				format.html {redirect_to areas_path, notice: "Area has been updated"}
			else
				format.html {render action: "edit", layout: "admin_layout"}
			end
		end
	end

	def destroy
		@area = Area.find(params[:id])
		@area.destroy

		respond_to do |format|
			format.html {redirect_to areas_path, notice: "Area has been deleted"}
		end
	end

	private

	def area_params
		params.require(:area).permit(:name, :description)
	end
end

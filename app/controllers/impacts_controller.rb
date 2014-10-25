class ImpactsController < ApplicationController

	def index
		@impacts = Impact.all.page(params[:page])
		render layout: "admin_layout"
	end

	def new
		@impact = Impact.new
		render layout: "admin_layout"
	end

	def edit
		@impact = Impact.find(params[:id])
		render layout: "admin_layout"
	end

	def create
		@impact = Impact.new(impact_params)

		respond_to do |format|
			if @impact.save
				format.html {redirect_to impacts_path, notice: "An impact has been created"}
			else
				format.html {render action: "new", layout: "admin_layout"}
			end
		end
	end

	def destroy
		@impact = Impact.find(params[:id])
		respond_to do |format|
			if @impact.destroy
				format.html { redirect_to impacts_path, notice: "Impact has been destroyed" }
			else
				format.html { redirect_to impacts_path, alert: "The impact was not destroyed"}
			end
		end
	end

	def update
		@impact = Impact.find(params[:id])

		respond_to do |format|
			if @impact.update(impact_params)
				format.html {redirect_to impacts_path, notice: "The impact has been successfully saved"}
			else
				format.html {render action: "edit", layout: "admin_layout"}
			end
		end
	end

	private

	def impact_params
		params.require(:impact).permit(:name, :description)
	end
end

class ImpactsController < ApplicationController

	def index
		@impacts = Impact.all
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
				format.html {render action: 'new'}
			end
		end
	end

	def update
		@impact = Impact.find(params[:id])

		respond_to do |format|
			if @impact.update(impact_params)
				format.html {redirect_to impacts_path, notice: "The impact has been successfully saved"}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	private

	def impact_params
		params.require(:impact).permit(:name, :description)
	end
end

class ImpactsController < ApplicationController

	def index
		@impacts = Impact.all
	end

	def new
		@impact = Impact.new
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

	private

	def impact_params
		params.require(:impact).permit(:name, :description)
	end
end

class BusinessesController < ApplicationController

	def index
		@business = Business.all
	end

	def new
		@business = Business.new
	end

	def show
		@business = Business.find(params[:id])
	end

	def create
		@business = Business.new(business_params)

		respond_to do |format|
			if @business.save
				format.html {redirect_to business_path(@business)}
			else
				foramt.html {render action: 'new'}
			end
		end
	end

	private

	def business_params
		params.require(:business).permit(:name, :location)
	end
end

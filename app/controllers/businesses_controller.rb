class BusinessesController < ApplicationController

	def index
		@business = Business.all
	end

	def new
		if !user_signed_in?
			@business = Business.new
		else
			redirect_to home_path
		end
	end

	def newly_created

	end

	def show
		@business = Business.find(params[:id])
	end

	def create

		@business = Business.new(business_params)
		@business.users.build(user_params)
		# sets the user that creates the business as the creator
		@business.users.first.creator = true
		@business.intro = false

		respond_to do |format|
			if @business.save
				format.html {redirect_to newly_created_business_path(@business)}
			else
				format.html {render action: 'new'}
			end
		end
	end

	private

	def business_params
		params.require(:business).permit(:name, :location)
	end

	def user_params
		params.require(:user).permit(:email, :password, :password)
	end
end

class AdminBusinessController < ApplicationController

	before_action :get_business, only: [:edit, :update]

	def edit
		render layout: "admin_layout"
	end

	def update
		respond_to do |format|
			if @business.update(business_params)
				flash[:admin_notice] = "Business information has been updated"
				format.html { redirect_to business_edit_path }
			else
				flash.now[:admin_alert] = "Business Information could not be saved"
				format.html { render action: 'edit' }
			end
		end
	end

	private

	def get_business
		@business = current_user.business
	end

	def business_params
		params.require(:business).permit(:name, :description, :location)
	end
end
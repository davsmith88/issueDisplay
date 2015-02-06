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
		business = current_user.business

		dep = business.departments.count
		deparea = business.department_areas.count
		area = business.areas.count
		impact = business.impacts.count
		if dep == 0 or deparea == 0 or area == 0 or impact == 0
			render layout: "admin_layout"
		else
			flash[:admin_notice] = 'Business all ready set up'
			redirect_to admin_index_path
		end
	end

	def show
		@business = Business.find(params[:id])
	end

	def create

		@business = Business.new(business_params)
		@business.users.build(user_params)
		# sets the user that creates the business as the creator
		@business.users.first.creator = true
		@business.roles.build(name: "admin")
		@business.assignments.build(user: @business.users.first, role: @business.roles.first)
		# need to build/create the grants for the business

		Right.all.each do |right|
			Grant.create(right: right, role: @business.roles.first)
		end


		@business.intro = false

		respond_to do |format|
			if @business.save
				sign_in(:user, @business.users.first)
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
		params.require(:user).permit(:email, :password, :password, :name)
	end
end

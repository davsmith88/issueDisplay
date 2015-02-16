class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
  	protect_from_forgery with: :exception

  	before_filter :check_controller_name
  	# before_action :permissions


 	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  	protected

  	def record_not_found
  		redirect_to "/404.html"
  	end

  	private

 #  	def permissions
	# 	if current_user
	# 		@edit = current_user.can?("edit", controller_name)
	# 		@destroy = current_user.can?("destroy", controller_name)
	# 		@create = current_user.can?("new", controller_name)
	# 	end
	# end

	def check_intro
		business = current_user.business

		dep = business.departments.count
		deparea = business.department_areas.count
		area = business.areas.count
		impact = business.impacts.count
		if dep == 0 or deparea == 0 or area == 0 or impact == 0
			# puts "BUSINESS IS NOT SET UP CORRECTLY"
			# the business is not setup (ie no departments, areas, department areas or impacts)
			# those are critical in saving an issue, will alert the user
			business.intro = false
			business.save
			redirect_to newly_created_business_path(business)
		else
			# business is set up correclty and will allow the user to continue 
			# to next phase 
			business.intro = true
			business.save
		end
	end


	def check_controller_name
		puts "----> #{controller_name} #{action_name}"
		name = controller_name
		if name != 'static_pages' and name != 'sessions' and name != 'json_sessions'
			authenticate_user!
			check_authorization
		end
	end


  	def check_authorization
	  	unless current_user.can?(action_name, controller_name)
 			redirect_to home_path, notice: "User cannot access this resource"
	  	end
	end
end

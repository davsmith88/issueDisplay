class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
  	protect_from_forgery with: :exception

	before_action :authenticate_user!
  	
  	# check_authorization #used for cancancan authorization
	check_authorization :unless => :devise_controller?

 	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
 	rescue_from CanCan::AccessDenied, with: :no_permission

  	protected

  	def no_permission(exception)
  		respond_to do |format|
			format.html {redirect_to issues_path, alert: exception.message}
 		end
  	end

  	def record_not_found(exception)
  		redirect_to issues_path, alert: "The issue the ID '#{params[:id]}' does not exist"
  	end

  	private

	# def check_intro
	# 	business = current_user.business

	# 	dep = business.departments.count
	# 	deparea = business.department_areas.count
	# 	area = business.areas.count
	# 	impact = business.impacts.count
	# 	if dep == 0 or deparea == 0 or area == 0 or impact == 0
	# 		# puts "BUSINESS IS NOT SET UP CORRECTLY"
	# 		# the business is not setup (ie no departments, areas, department areas or impacts)
	# 		# those are critical in saving an issue, will alert the user
	# 		business.intro = false
	# 		business.save
	# 		redirect_to newly_created_business_path(business)
	# 	else
	# 		# business is set up correclty and will allow the user to continue 
	# 		# to next phase 
	# 		business.intro = true
	# 		business.save
	# 	end
	# end
end

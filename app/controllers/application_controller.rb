class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	include PublicActivity::StoreController
  	# protect_from_forgery with: :exception
  	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }


  	skip_before_filter :verify_authenticity_token
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

  	before_filter :check_controller_name

 	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# Needed for CORS support ... need to do more research
	def cors_set_access_control_headers
		# headers['Access-Control-Allow-Origin'] = 'http://localhost:4000'
		headers['Access-Control-Allow-Origin'] = 'http://192.168.0.6:4000'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, OPTIONS, DELETE'
		headers['Access-Control-Allow-Credentials'] = 'true'
		headers['Access-Control-Max-Age'] = '1728000'
	end

	def cors_preflight_check
		# headers['Access-Control-Allow-Origin'] = 'http://localhost:4000'
		headers['Access-Control-Allow-Origin'] = 'http://192.168.0.6:4000'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, OPTIONS, DELETE'
		headers['Access-Control-Request-Method'] = '*'

		headers['Access-Control-Allow-Credentials'] = 'true'
		headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Content-Type'
		headers['Access-Control-Max-Age'] = '1728000'

		# head(:ok) if request.request_method == "OPTIONS"
	end

  protected
  	def record_not_found
  		redirect_to "/404.html"
  	end

  private
	def check_controller_name
		puts "----> #{controller_name} #{action_name}"
		name = controller_name
		if name != 'static_pages' and name != 'sessions' and name != 'json_sessions'
			authenticate_user!
			check_authorization
		end
	end


  	def check_authorization
  		# puts current_user.can?(action_name, controller_name)
	  	unless current_user.can?(action_name, controller_name)
	  		# if the current user is not authorized to access the action on the controller
	  		# render nothing and supply the 401 (Unauthorised) status code
	  		# render nothing: true, status: 401

 			redirect_to home_path, notice: "User cannot access this resource"
	  		# puts "#{action_name} #{controller_name}"
	  		# if current_user.can?("show", controller_name)
  			# 	flash[:notice] = 'The user does not has write access'
  			# 	redirect_to issues_path
	  		# else
	  		# 	# render status: 401
		  	# 	# redirect_to home_path, notice: "User cannot access this resource"
		  	# 	# flash[:notice] = 'the user does not have access'
	  		# end
	  	# else
	  		# puts "unauthorised"
	  	end
	end
end

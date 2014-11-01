class ApplicationController < ActionController::Base
	include PublicActivity::StoreController
  	protect_from_forgery with: :exception

  	before_filter :check_controller_name
  	before_action :permissions

 	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  	protected

  	def record_not_found
  		redirect_to "/404.html"
  	end

  	private

  	def permissions
		if current_user
			@edit = current_user.can?("edit", controller_name)
			@destroy = current_user.can?("destroy", controller_name)
			@create = current_user.can?("new", controller_name)
		end
	end

	def check_controller_name
		# puts "----> #{controller_name} #{action_name}"
		name = controller_name
		if name != 'static_pages' and name != 'sessions' and name != 'json_sessions'
			authenticate_user!
			check_authorization
		end
	end


  	def check_authorization
  		# puts current_user.can?(action_name, controller_name)
	  	unless current_user.can?(action_name, controller_name)
 			redirect_to home_path, notice: "User cannot access this resource"
	  	end
	end
end

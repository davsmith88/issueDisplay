class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	include PublicActivity::StoreController
  	protect_from_forgery with: :exception
 
  # before_filter :check_controller_name

  private
	def check_controller_name
		puts "----> #{controller_name}"
		name = controller_name
		if name != 'static_pages' and name != 'sessions'
			authenticate_user!
			check_authorization
		end
	end


  	def check_authorization
  		
  		puts "#{current_user.can?(action_name, controller_name)}"
  		puts "#{action_name} #{controller_name}"
	  	unless current_user.can?(action_name, controller_name)
	  		puts "#{action_name} #{controller_name}"
	  		if current_user.can?("show", controller_name)
	  			flash[:notice] = 'The user does not has write access'
	  			redirect_to issues_path
	  		else
		  		redirect_to home_path, notice: "User cannot access this resource"
		  		flash[:notice] = 'the user does not have access'
	  		end
	  	end
  	end
end

class UsersController < ApplicationController
	
	authorize_resource
	# need to be implemented, take view out of admin static
	# def index

	# end


	def new
		@user = User.new
		render layout: "admin_layout"
	end

	def profile
		@issues = Issue.where(user_id: current_user.id).order("created_at DESC").page(params[:page])
		# if current_user
		# 	if params[:filter] == 'all' or params[:filter].nil?
		# 		@issues = Issue.where(user_id: current_user.id).order("created_at DESC").page(params[:page])
		# 	else
		# 		@issues = Issue.where(user_id: current_user.id, state: params[:filter]).order("created_at DESC").page(params[:page])
		# 	end
		# else
		# 	redirect_to new_user_session_path, notice: "A user needs to be signed in to view a profile"
		# end
	end

	def show
		@user = scoped.find(params[:id])

		#@issues = Issue.where(user_id: current_user.id)
	end

	def create
		@user = User.new(user_params)
		@user.business_id = current_user.business_id
		respond_to do |format|
			if @user.save
				flash[:admin_notice] = "'#{user_params[:name]}' has been created"
				format.html {redirect_to admin_user_static_path}
			else
				flash.now[:admin_alert] = "User cannot be created"
				format.html {render action: 'new', layout: "admin_layout"}
			end
		end
	end

	def edit
		@user = scoped.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@user = scoped.find(params[:id])

		respond_to do |format|
			if @user.update(user_params)
				flash[:admin_notice] = "'#{user_params[:name]}' details have been updated"
				format.html {redirect_to admin_user_static_path, :notice => "User details have been added to the system"}
			else
				flash.now[:admin_alert] = "'#{user_params[:name]}' details could not be updated"
				format.html {render action: 'edit', layout: "admin_layout"}
			end
		end
	end

	def destroy
		@user = scoped.find(params[:id])

		@user.destroy
		respond_to do |format|
			flash[:admin_notice] = "User has been destroyed"
			format.html {redirect_to admin_user_static_path}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password, :name, :title, :permType)
	end

	def scoped
		current_user.business.users
	end
end

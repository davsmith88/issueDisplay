class UsersController < ApplicationController
	def new
		@user = User.new
		render layout: "admin_layout"
	end

	def profile
		if current_user
			if params[:filter] == 'all' or params[:filter].nil?
				@issues = Issue.where(user_id: current_user.id).order("created_at DESC").page(params[:page])
			else
				@issues = Issue.where(user_id: current_user.id, state: params[:filter]).order("created_at DESC").page(params[:page])
			end
		else
			redirect_to new_user_session_path, notice: "A user needs to be signed in to view a profile"
		end
	end

	def show
		@user = User.find(params[:id])

		#@issues = Issue.where(user_id: current_user.id)
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html {redirect_to admin_user_static_path}
			else
				format.html {render action: 'new', layout: "admin_layout"}
			end
		end
	end

	def edit
		@user = User.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update(user_params)
				format.html {redirect_to admin_user_static_path, :notice => "User details have been added to the system"}
			else
				format.html {render action: 'edit', layout: "admin_layout"}
			end
		end
	end

	def destroy
		@user = User.find(params[:id])

		@user.destroy
		respond_to do |format|
			format.html {redirect_to admin_index_path, :notice => "User has been destroyed"}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password, :name, :title)
	end
end

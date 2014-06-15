class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def profile
		@issues = Issue.where(user_id: current_user.id).order("created_at DESC")
	end

	def show
		@user = User.find(params[:id])

		#@issues = Issue.where(user_id: current_user.id)
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html {redirect_to admin_index_path}
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update(user_params)
				format.html {redirect_to admin_index_path, :notice => "User details have been added to the system"}
			else
				format.html {render action: 'edit'}
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

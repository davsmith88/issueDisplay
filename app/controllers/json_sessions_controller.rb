class JsonSessionsController < ApplicationController


	respond_to :json


	
	CRUD = %w(show create update destroy)
	CONTROLLERS = %w(issues solutions attempted_solutions workarounds)

	def create
		# puts params[:session]
		@user = User.find_for_database_authentication(email: params[:session][:email])

		if @user && @user.valid_password?(params[:session][:password])
			sign_in @user
			# need to refactor into more efficient code
			# work out a solution to hit the database only once
			@permissions = Hash.new
			CONTROLLERS.each do |controller|
				@permissions[controller] = Hash.new
				CRUD.each do |action|
					# @permissions[controller][action] = @user.can?(action, controller)
					@permissions[controller][action] = true
				end
			end
			

			respond_to do |format|
				format.json
			end
		else
			render json: {
				errros: {
					email: "invalid email or password"
				}, status: :unprocessable_entity
			}
		end
	end

	def show
		user = User.find(params:[:id])
	end

	def destroy
		sign_out :user
		render json: {}, status: 204
	end
end
class AssignmentsController < ApplicationController

	def new
		@roles = Role.all
		@users = User.all
		@assignment = Assignment.new
	end

	def show
		@assignments = Assignment.includes(:user).where(role_id: params[:role_id])
	end

	def create
		@assignment = Assignment.new(assignment_params)

		@assignment.save

		respond_to do |format|
			if @assignment.save
				format.html {redirect_to roles_path}
			else
				format.html {redirect_to new_assignment_path, notice: "The user is already part of the role"}
			end
		end
		
	end

	def destroy
		role_id = params[:role_id]
		@assignment = Assignment.find(params[:id])
		respond_to do |format|
			if @assignment.destroy
				format.html {redirect_to assignment_role_view_path(role_id) }
			end
		end
	end

	private

	def assignment_params
		params.require(:assignment).permit(:role_id, :user_id)
	end
end

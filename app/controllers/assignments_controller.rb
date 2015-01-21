class AssignmentsController < ApplicationController

	def new
		@active_assignments = true
		@roles = Role.all
		@users = User.all
		@assignment = Assignment.new
		render layout: "permission_static"
	end

	def show
		@active_assignments = true
		@assignments = Assignment.includes(:user).where(role_id: params[:role_id])
		render layout: "permission_static"
	end

	def create
		@assignment = Assignment.new(assignment_params)

		@assignment.save

		respond_to do |format|
			if @assignment.save
				flash[:admin_notice] = "The user has been assigned a role"
				format.html { redirect_to new_assignment_path }
			else
				format.html { redirect_to new_assignment_path, notice: "The user is already part of the role" }
			end
		end
		
	end

	def destroy
		role_id = params[:role_id]
		@assignment = Assignment.find(params[:id])
		respond_to do |format|
			if @assignment.destroy
				flash[:admin_alert] = "The user is no longer associated with the role"
				format.html {redirect_to assignment_role_view_path(role_id) }
			end
		end
	end

	private

	def assignment_params
		params.require(:assignment).permit(:role_id, :user_id)
	end
end

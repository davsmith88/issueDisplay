class GrantsController < ApplicationController

	def new
		@active_grants = true
		query = %q{
		    case operation
			    when 'READ' then 1
			    when 'CREATE'  then 2
			    when 'UPDATE'  then 3
			    when 'DESTROY' then 4
		    end
		}

		@roles = current_user.business.roles.all
		@rights_admin = Right.where(resource: 'admin').order(query)
		@rights_issue = Right.where(resource: 'issues').order(query)
		@rights_role = Right.where(resource: 'roles').order(query)
		@rights_right = Right.where(resource: 'rights').order(query)
		@rights_grant = Right.where(resource: 'grants').order(query)
		@rights_assignment = Right.where(resource: 'assignments').order(query)
		@rights = Right.all
		@rights_attempted = Right.where(resource: 'attempted_solutions').order(query)
		@rights_workarounds = Right.where(resource: 'issue_workarounds').order(query)
		@rights_impacts = Right.where(resource: 'impacts').order(query)
		@rights_images = Right.where(resource: 'images').order(query)
		@rights_solutions = Right.where(resource: 'solutions').order(query)
		@rights_users = Right.where(resource: 'users').order(query)
		@rights_areas = Right.where(resource: 'areas').order(query)
		@rights_departments = Right.where(resource: 'departments').order(query)
		@rights_department_areas = Right.where(resource: 'department_areas').order(query)

		

		@grant = Grant.new

		render layout: "permission_static"
	end

	def create
		params[:grant]["rights"].each do |right|
			Grant.create(role_id: params[:grant][:role_id], right_id: right)
		end
		respond_to do |format|
			flash[:admin_notice] = "Right has been assigned to a role"
			format.html { redirect_to roles_path }
		end
	end

	def destroy
		@grant = Grant.find(params[:id])
		@role = @grant.role
		@grant.delete
		respond_to do |format|
			flash[:admin_notice] = "Right is no longer associated with the role"
			format.html { redirect_to role_path(@role) }
		end
	end

	private

	def grants_params
		params.require(:grant).permit(:role_id, :right_id)
	end
end

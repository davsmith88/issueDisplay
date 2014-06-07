class GrantsController < ApplicationController

	def new
		query = %q{
		    case operation
			    when 'READ' then 1
			    when 'CREATE'  then 2
			    when 'UPDATE'  then 3
			    when 'DESTROY' then 4
		    end
		}

		@roles = Role.all
		@rights_admin = Right.where(resource: 'admin').order(query)
		@rights_issue = Right.where(resource: 'issues').order(query)
		@rights_role = Right.where(resource: 'roles').order(query)
		@rights_right = Right.where(resource: 'rights').order(query)
		@rights_grant = Right.where(resource: 'grants').order(query)
		@rights_assignment = Right.where(resource: 'assignments').order(query)
		@rights = Right.all
		@rights_attempted = Right.where(resource: 'attempted_solutions').order(query)
		@grant = Grant.new
	end

	def create
		params[:grant]["rights"].each do |right|
			Grant.create(role_id: params[:grant][:role_id], right_id: right)
		end
		respond_to do |format|
			format.html {redirect_to roles_path, :notice => "Rights have been added to the role"}
		end
	end

	private

	def grants_params
		params.require(:grant).permit(:role_id, :right_id)
	end
end

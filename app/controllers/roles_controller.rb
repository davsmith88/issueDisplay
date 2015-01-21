class RolesController < ApplicationController
	def index
		@active_roles = true
		@roles = Role.all.page(params[:page])
		render layout: "permission_static"
	end

	def show
		@active_roles = true
		@role = Role.find(params[:id])
		@grants = Grant.where(role_id: params[:id]).page(params[:page])

		render layout: "permission_static"
	end

	def new
		@active_roles = true
		@role = Role.new
		render layout: "permission_static"
	end

	def create
		@role = Role.new(role_params)
		respond_to do |format|
			if @role.save()
				flash[:admin_notice] = "Role has been created"
				format.html { redirect_to roles_path }
			else
				flash[:admin_alert] = "Role could not be created"
				format.html { render action: 'new' }
			end
		end
	end

	def edit
		@active_roles = true
		@role = Role.find(params[:id])
		render layout: "permission_static"
	end

	def update
		@role = Role.find(params[:id])
		respond_to do |format|
			if @role.update(role_params)
				flash[:admin_notice] = "Role information as been updated"
				format.html { redirect_to roles_path }
			else
				flash[:admin_alert] = "Role information could not be updated"
				format.html { render action: 'edit' }
			end
		end
	end

	def destroy
		@role = Role.find(params[:id])
		@role.destroy

		respond_to do |format|
			flash[:admin_notice] = "Role has been destroyed"
			format.html {redirect_to roles_path}
		end
	end

	private

	def role_params
		params.require(:role).permit(:name, :description)
	end

end

class RolesController < ApplicationController
	def index
		@roles = Role.all.page(params[:page])
		render layout: "admin_layout"
	end

	def show
		@role = Role.find(params[:id])
		@grants = Grant.where(role_id: params[:id]).page(params[:page])

		render layout: "admin_layout"
	end

	def new
		@role = Role.new
		render layout: "admin_layout"
	end

	def create
		@role = Role.new(role_params)
		respond_to do |format|
			if @role.save()
				format.html {redirect_to roles_path, notice: "Created the Role"}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@role = Role.find(params[:id])
		render layout: "admin_layout"
	end

	def update
		@role = Role.find(params[:id])
		respond_to do |format|
			if @role.update(role_params)
				format.html {redirect_to roles_path}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@role = Role.find(params[:id])
		@role.destroy

		respond_to do |format|
			format.html {redirect_to roles_path}
		end
	end

	private

	def role_params
		params.require(:role).permit(:name, :description)
	end

end

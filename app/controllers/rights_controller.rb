class RightsController < ApplicationController

	def index
		@active_rights = true
		@rights = Right.all.page(params[:page])
		render layout: "permission_static"
	end

	def new
		@active_rights = true
		@right = Right.new
		render layout: "permission_static"
	end	

	def create
		params[:right]['resource'].each do |key, value|
			value.each do |v|
				Right.create(:resource => key, :operation => v)
			end
		end

		respond_to do |format|
			flash[:admin_notice] = "Rights have been created"
		 	format.html { redirect_to rights_path }
		end
	end

	def destroy
		@right = Right.find(params[:id])
		@right.destroy
		respond_to do |format|
			flash[:admin_notice] = "Right has been destroyed"
			format.html {redirect_to rights_path}
		end
	end

	private

	def right_params
		params.require(:right).permit(:resource, :operation)
	end

end

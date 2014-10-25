class RightsController < ApplicationController

	def index
		@rights = Right.all.page(params[:page])
		render layout: "admin_layout"
	end

	def new
		@right = Right.new
		render layout: "admin_layout"
	end	

	def create
		params[:right]['resource'].each do |key, value|
			value.each do |v|
				Right.create(:resource => key, :operation => v)
			end
		end

		respond_to do |format|
		 	format.html {redirect_to rights_path, notice: "Right has been created"}
		end
	end

	def destroy
		@right = Right.find(params[:id])
		@right.destroy
		respond_to do |format|
			format.html {redirect_to rights_path}
		end
	end

	private

	def right_params
		params.require(:right).permit(:resource, :operation)
	end

end

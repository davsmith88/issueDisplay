class ErrorsController < ActiveController::Base
	def unauthorised
		respond_to do |format|
			format.json {render json: {error: "unauthorised", status: 401}}
		end
	end
end
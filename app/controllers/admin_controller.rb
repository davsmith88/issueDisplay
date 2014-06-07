class AdminController < ApplicationController

	def index
		@users = User.all
	end

	def show
		# View profile of the user
	end


end

class AlbumsController < ApplicationController

	def index
		@issue = Issue.find(params[:issue_id])
		@images = @issue.images.all
	end

end

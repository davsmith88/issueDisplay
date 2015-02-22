class ImgController < ApplicationController
	
	before_action :find_issue

	def new
		@image = @issue.images.new
	end

	def create
		@image = @issue.images.new(image_params)

		respond_to do |format|
			if @image.save
				format.html {redirect_to edit_issue_path(@issue)}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit

	end

	def update

	end

	def destroy

	end

	private

	def image_params
		params.require(:image).permit(:caption, :picture)
	end

	def find_issue
		puts params
		@issue = Issue.find(params[:issue_id])
	end
end
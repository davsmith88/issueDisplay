class ImgController < ApplicationController
	
	before_action :find_issue
	before_action :find_image, only: [:edit, :update, :destroy]

	def new
		@image = @issue.images.new
	end

	def create
		@image = @issue.images.new(image_params)

		respond_to do |format|
			if @image.save
				format.html {redirect_to edit_images_issue_path(@issue)}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit

	end

	def update
		if @image.update_attributes(image_params)
			redirect_to edit_images_issue_path(@issue)
		else
			render action: "edit"
		end
	end

	def destroy
		if @image.destroy
			redirect_to edit_images_issue_path(@issue)
		else
			render action: "edit"
		end
	end

	private

	def image_params
		params.require(:image).permit(:caption, :picture)
	end

	def find_issue
		@issue = Issue.find(params[:issue_id])
	end

	def find_image
		@image = Image.find(params[:id])
	end
end
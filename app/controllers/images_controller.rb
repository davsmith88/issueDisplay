class ImagesController < ApplicationController

	def new
		# @album = Album.find(params[:album_id])
		@context = context
		
		if params.has_key?(:solution_id)
			
			@issue = Issue.find(params[:issue_id])
			@solution = Solution.find(params[:solution_id])
			@image = @solution.images.new
		elsif params.has_key?(:attempted_solution_id)
			@issue = Issue.find(params[:issue_id])
			@solution = AttemptedSolution.find(params[:attempted_solution_id])
			@image = @solution.images.new
		elsif params.has_key?(:issue_workaround_id)
			@issue = Issue.find(params[:issue_id])
			@solution = IssueWorkaround.find(params[:issue_workaround_id])
			@image = @solution.images.new			
		else
			@image = @context.images.new
		end
	end

	def create
		# @album = Album.find(params[:album_id])
		@context = context
		@issue = Issue.find(params[:issue_id])
		if params.has_key?(:solution_id)
			
			# @issue = Issue.find(params[:issue_id])
			@solution = Solution.find(params[:solution_id])
			@image = @solution.images.new(image_params)
		else
			@image = @context.images.new(image_params)
		end
		

		# @image.album_id = @album.id

		respond_to do |format|
			if @image.save
				format.html {redirect_to edit_issue_path(@issue)}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@issue = Issue.find(params[:issue_id])
		@image = @issue.images.find(params[:id])
	end

	def update
		@issue = Issue.find(params[:issue_id])
		@image = @issue.images.find(params[:id])


		@image.update(image_params)
		redirect_to edit_issue_path(@issue)
	end	

	def destroy
		@issue = Issue.find(params[:issue_id])
		image = Image.find(params[:id])
		image.destroy

		redirect_to edit_issue_path(@issue)
	end

	private

	def image_params
		params.require(:image).permit(:caption, :picture)
	end

	def context
	    if params.has_key?(:solution_id) and params.has_key?(:issue_id)
	    	puts "---> solution id and issue id"
	    	id = params[:solution_id]
	    	Solution.find(id)
	    elsif params.has_key?(:issue_workaround_id)
	    	id = params[:issue_workaround_id]
	    	IssueWorkaround.find(id)
	    elsif params.has_key?(:attempted_solution_id)
	    	id = params[:attempted_solution_id]
	    	AttemptedSolution.find(id)
	    elsif params[:issue_id]
	    	params[:issue_id]
	      	id = params[:issue_id]
	      	Issue.find(params[:issue_id])
	    end
	end 
end

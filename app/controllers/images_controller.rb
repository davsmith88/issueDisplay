class ImagesController < ApplicationController

	def new
		
		@c = find_imageable
		@image = @c.images.new
		
	end

	def create
		
		@c = find_imageable
		@image = @c.images.new(image_params)

		respond_to do |format|
			if @image.save
				if @c.class.name == 'Issue'
					format.html {redirect_to edit_issue_path(@c)}
				else
					format.html {redirect_to edit_issue_path(@c.issue)}
				end
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@c = find_imageable
		
		@image = @c.images.find(params[:id])
	end

	def update
		# @issue = Issue.find(params[:issue_id])
		@c = find_imageable
		@image = @c.images.find(params[:id])


		@image.update(image_params)
		if @c.class.name == "Issue"
			redirect_to edit_issue_path(@c)
		else
			redirect_to edit_issue_path(@c.issue)
		end
	end	

	def destroy
		# @issue = Issue.find(params[:issue_id])
		@c = find_imageable
		@image = @c.images.find(params[:id])

		
		@image.destroy
		if @c.class.name === "Issue"
			redirect_to edit_issue_path(@c)
		else
			redirect_to edit_issue_path(@c.issue)
		end
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

	def find_imageable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      	return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

end

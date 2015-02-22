class ImagesController < ApplicationController

	before_action :set_type
	before_action :find_issue
	before_action :get_review

	def new
		@rr = @review.images.new
	end

	def create
		@image = @review.images.new(image_params)

		respond_to do |format|
			if @image.save
				format.html {redirect_to edit_issue_path(@issue)}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@rr = @review.images.find(params[:id])
		
		# @image = @c.images.find(params[:id])
	end

	def update
		# @issue = Issue.find(params[:issue_id])
		@rr = @review.images.find(params[:id])


		if @rr.update(image_params)
			redirect_to edit_issue_path(@issue)
		else
			render action: "edit"
		end
	end	

	def destroy
		# @issue = Issue.find(params[:issue_id])
		# @c = find_imageable
		# @image = @c.images.find(params[:id])
		@rr = @review.images.find(params[:id])

		
		@rr.destroy
	
		redirect_to edit_issue_path(@rr)
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

	def set_type
		# @type = params[:type]
		type
		@class = @type.underscore.humanize
	end

	def type
		@type = (params[:type]) ? params[:type] : "Issue"
	end

	def type_class
		params[:type].constantize
	end

	def associated_method
		params[:type].underscore.pluralize.to_sym
	end

	def find_issue
		@issue = Issue.find(params[:issue_id])
	end

	def get_review
		association = @issue.send associated_method
		p = params[:type].underscore + "_id"
		@review = association.find(params[p])
	end
end

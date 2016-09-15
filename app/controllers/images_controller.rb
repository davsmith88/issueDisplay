class ImagesController < ApplicationController

	authorize_resource

	# before_action :set_type
	# before_action :find_issue, except: [:index]
	# before_action :get_review

	def index
		# count = params[:count]
		# numPict = params[:numPict]
		@location = Location.all.group_by(&:department_area_id)
		@imgCount = Image.count
		@loc = params[:loc] || ""
		# puts @loc
		if(!params.has_key?('loc'))
			@images = Image.all.page(params[:page])
		else
			@images = Image.where(location_id: @loc).page(params[:page])
		end

		# @images = Image.limit(numPict).offset(count)
		respond_to do |format|
			format.html {render layout: 'admin_layout'}
			format.js
			format.json
		end
	end

	# def manindex
	# 	@location = Location.all
	# 	@loc = params[:loc] || ""
	# 	puts @loc
	# 	if(!params.has_key?('loc'))
	# 		@images = Image.all.page(params[:page])
	# 	else
	# 		@images = Image.where(location_id: @loc).page(params[:page])
	# 	end

	# 	respond_to do |format|
	# 		format.html {render layout: 'admin_layout'}
	# 		format.js
	# 	end
	# end

	def get_images
		# @location = Location.all
		count = params[:count]
		numPict = params[:numPict]
		code = params[:code]
		@imgCount = Image.where(location_id: code).count
		@images = Image.where(location_id: code).limit(numPict).offset(count)
		respond_to do |format|
			format.json
		end
	end

	def new
		# @rr = @review.images.new
		@rr = Image.new
		@locations = Location.all.group_by(&:department_area_id)
		render layout: 'admin_layout'
	end

	def create
		@rr = Image.new(image_params)
		@locations = Location.all
		respond_to do |format|
			if @rr.save
				format.html {redirect_to images_path}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		# @rr = @review.images.find(params[:id])
		@rr = Image.find(params[:id])
		@locations = Location.all.group_by(&:department_area_id)
		# @image = @c.images.find(params[:id])
		render layout: 'admin_layout'
	end

	def update
		# @issue = Issue.find(params[:issue_id])
		# @rr = @review.images.find(params[:id])
		@rr = Image.find(params[:id])


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
		# @rr = @review.images.find(params[:id])
		@rr = Image.find(params[:id])

		
		@rr.destroy
	
		redirect_to edit_issue_path(@rr)
	end

	private

	def image_params
		params.require(:image).permit(:name, :caption, :picture, :description, :location_id)
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

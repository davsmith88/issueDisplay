class ReviewsController < RevController
	
	# before_action :set_redirect_name, only: [:create, :update, :destroy]

	def index
		@reviews = type_class.all
	end
	def new
		super
	end

	def create
		association = @issue.send associated_method
		@review = association.new(review_params)
		respond_to do |format|
			if @review.save
				format.html {redirect_to self.send(@redirect_method, @issue)}
			else
				flash.now[:alert] = "#{pretty_class_name} could not be created - Invalid Attributes"
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		super
	end

	def update
		respond_to do |format|
			if @review.update(review_params)
				# @issue.change_state
				format.html {redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} has been updated"}
			else
				flash.now[:alert] = "#{pretty_class_name} could not be saved"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		respond_to do |format|
			if @review.destroy
				format.html {redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} has been deleted"}
			else
				format.html { redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} could not be deleted" }
			end
		end
	end

	private

	# def set_redirect_name
	# 	@redirect_method = "edit_#{params[:u]}_issue_path"
	# end

	def set_redirect_name
		@redirect_method = "edit_#{params[:u]}_issue_path"
	end
end
class ReviewManagementController < RevController

	def index
		@reviews = type_class.all
	end
	def new
		super
		render layout: "admin_layout"
	end

	def create
		super
		respond_to do |format|
			if @review.save
				format.html {redirect_to self.send(@redirect_method, @issue)}
			else
				flash.now[:admin_alert] = "#{pretty_class_name} could not be created - Invalid Attributes"
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@admin = true
		render layout: "admin_layout"
	end

	def update
		respond_to do |format|
			if @review.update(review_params)
				
				format.html {redirect_to self.send(@redirect_method, @issue)}
			
				# format.html {redirect_to @url, notice: "#{pretty_class_name} has been updated"}
			else
				flash.now[:alert] = "#{pretty_class_name} could not be saved"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		respond_to do |format|
			if @review.destroy
				format.html {redirect_to self.send(@redirect_method, @issue)}
				# format.html {redirect_to @url, notice: "#{pretty_class_name} has been deleted"}
			else
				# format.html { redirect_to @url, notice: "#{pretty_class_name} could not be deleted" }
			end
		end
	end


	private

	def set_redirect_name
		@redirect_method = "edit_#{params[:u]}_issue_management_path"
	end
end
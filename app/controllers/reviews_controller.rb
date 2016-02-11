class ReviewsController < RevController

	# before_action :get_issue, only: [:index, :create]
	before_action :get_reviews, only: [:index, :create, :destroy]

	def index
		# @reviews = type_class.all
		# @issue = Issue.find(params[:issue_id] || params[:id])
		# @name = params[:u]
		# if params[:u] == 'workarounds'
		# 	@active_workarounds = true
		# 	@reviews = @issue.issue_workarounds
		# end
		# if params[:u] == 'solutions'
		# 	@active_solutions = true
		# 	@reviews = @issue.solutions
		# end
		respond_to do |format|
			format.html {
				render partial: 'issues/show_review_table',
				layout: 'displaytab',
				locals: {list: @reviews, name: 'solutions', type: @type}
			}
			format.js
		end
	end
	def new
		super

		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		super
		@name = params[:u]
		puts @review
		respond_to do |format|
			if @review.save
				format.html {redirect_to self.send(@redirect_method, @issue)}
				format.js
			else
				flash.now[:alert] = "#{pretty_class_name} could not be created - Invalid Attributes"
				format.html {render action: 'new'}
				format.js {render action: 'new'}
			end
		end
	end

	def edit
		super
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		@name = params[:u]
		respond_to do |format|
			if @review.update(review_params)
				# @issue.change_state
				format.html {redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} has been updated"}
				format.js
			else
				flash.now[:alert] = "#{pretty_class_name} could not be saved"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@name = params[:u]
		respond_to do |format|
			if @review.destroy
				format.html {redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} has been deleted"}
				format.js
			else
				format.html { redirect_to self.send(@redirect_method, @issue), notice: "#{pretty_class_name} could not be deleted" }
			end
		end
	end

	private

	def set_redirect_name
		@redirect_method = "edit_#{params[:u]}_issue_path"
	end

	def get_reviews
		if params[:u] == 'workarounds'
			@active_workarounds = true
			@reviews = @issue.issue_workarounds
		end
		if params[:u] == 'solutions'
			@active_solutions = true
			@reviews = @issue.solutions
		end
	end
end
class ReviewManagementController < RevController
	
	# before_action :set_type
	# before_action :get_issue, only: [:new, :create, :index, :edit, :update, :destroy]
	# before_action :get_review, only: [:edit, :update, :destroy]
	# before_action :set_url_path, only: [:new, :create]

	def index
		@reviews = type_class.all
	end
	def new
		# association = @issue.send associated_method
		# @review = association.new
		super
		# case params[:type]
		# when "IssueWorkaround"
		# 	@url = issue_management_issue_workarounds_path(@issue)
		# 	@url_edit = edit_workaround_issue_management_path(@issue)
		# when "Solution"
		# 	@url = issue_management_solutions_path(@issue)
		# 	@url_edit = edit_solutions_issue_management_path(@issue)
		# when "AttemptedSolution"
		# 	@url = issue_management_attempted_solutions_path(@issue)
		# 	@url_edit = edit_attempted_solutions_issue_management_path(@issue)
		# end
		render layout: "admin_layout"
	end

	def create
		super
		respond_to do |format|
			if @review.save
				# @issue.change_state

				# case params[:type]
				# 	when "IssueWorkaround"
				# 		@url = edit_workaround_issue_management_path(@issue)
				# 	when "Solution"
				# 		@url = edit_solutions_issue_management_path(@issue)
				# 	when "AttemptedSolution"
				# 		@url = edit_attempted_solutions_issue_management_path(@issue)
				# 	end
				# flash[:admin_notice]
				# format.html {redirect_to @url}
				format.html {redirect_to self.send(@redirect_method, @issue)}
			else
				flash.now[:admin_alert] = "#{pretty_class_name} could not be created - Invalid Attributes"
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@admin = true
		# case params[:type]
		# when "IssueWorkaround"
		# 	@url = issue_management_issue_workaround_path(@issue, @review)
		# 	@url_edit = issue_management_issue_workaround_path(@issue, @review)
		# when "Solution"
		# 	@url = issue_management_solution_path(@issue, @review)
		# 	@url_edit = issue_management_solution_path(@issue, @review)
		# when "AttemptedSolution"
		# 	@url = issue_management_attempted_solution_path(@issue, @review)
		# 	@url_edit = issue_management_attempted_solution_path(@issue, @review)
		# 	# edit_issue_management_attempted_solution
		# end
		render layout: "admin_layout"
	end

	def update
		respond_to do |format|
			if @review.update(review_params)
				# @issue.change_state
				# case params[:type]
				# 	when "IssueWorkaround"
				# 		@url = edit_workaround_issue_management_path(@issue)
				# 	when "Solution"
				# 		@url = edit_solutions_issue_management_path(@issue)
				# 	when "AttemptedSolution"
				# 		@url = edit_attempted_solutions_issue_management_path(@issue)
				# 	end
				format.html {redirect_to self.send(@redirect_method, @issue)}
			
				# format.html {redirect_to @url, notice: "#{pretty_class_name} has been updated"}
			else
				flash.now[:alert] = "#{pretty_class_name} could not be saved"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy

		# case params[:type]
		# 	when "IssueWorkaround"
		# 		@url = edit_workaround_issue_management_path(@issue)
		# 	when "Solution"
		# 		@url = edit_solutions_issue_management_path(@issue)
		# 	when "AttemptedSolution"
		# 		@url = edit_attempted_solutions_issue_management_path(@issue)
		# 	end

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

	# def set_url_path
	# 	case params[:type]
	# 	# when "IssueWorkaround"
	# 	# 	@url = issue_management_issue_workarounds_path(@issue)
	# 	# 	@url_edit = edit_workaround_issue_management_path(@issue)
	# 	# when "Solution"
	# 	# 	@url = issue_management_solutions_path(@issue)
	# 	# 	@url_edit = edit_solutions_issue_management_path(@issue)
	# 	# when "AttemptedSolution"
	# 	# 	@url = issue_management_attempted_solutions_path(@issue)
	# 	# 	@url_edit = edit_attempted_solutions_issue_management_path(@issue)
	# 	# end
	# end


	# def set_type
	# 	@type = type
	# 	@class =  params[:type].underscore.humanize
	# end

	# def type
	# 	Review.types.include?(params[:type]) ? params[:type] : "Review"
	# end

	# def type_class
	# 	type.constantize
	# end

	# def associated_method
	# 	type.underscore.pluralize.to_sym
	# end

	# def pretty_class_name
	# 	params[:type].underscore.humanize
	# end





	# def get_issue
	# 	id = params[:issue_id] || params[:issue_management_id]
	# 	@issue = Issue.find(id)
	# end

	# def get_review
	# 	@review = type_class.find(params[:id])
	# end

	# def review_params
	# 	params.require(type.underscore.downcase.to_sym).permit(:description)
	# end
end
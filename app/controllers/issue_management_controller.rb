class IssueManagementController < BIssueController

	authorize_resource class: false

	# before_action :check_intro
	# before_action :get_dep_area, only: [:new, :create, :edit,:edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	# before_action :get_impacts, only: [:new, :create, :edit, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]

	def index
		@issues = scoped.issues.page(params[:page])
		render layout: "admin_layout"
	end

	def show
		# @issue = scoped.issues.find(params[:id])
		super
		render layout: "admin_layout"
	end

	def view
		@active_workarounds = true
		@issue = scoped.issues.find(params[:issue_management_id])
		@list = scoped.issues.find(@issue).issue_workarounds
		@steps = @issue.detailed_steps
		# render layout: "show_issue_admin"
		render layout: "layouts/show_issue_admin", partial: "issues/show_review_table", locals: {list: @list}
	end

	def new
		super
		render layout: "admin_layout"
	end

	def create
		super
		respond_to do |format|
			if @issue.save
				flash[:admin_notice] = "Issue was created successfully"
				format.html { redirect_to issue_management_path(@issue) }
			else
				flash.now[:admin_alert] = "Issue is not valid"
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		super
		render layout: "admin_layout"
	end

	def update
		super
		respond_to do |format|
			if @issue.update(issue_params)
				flash[:admin_notice] = "Issue was updated successfully"
				format.html { redirect_to issue_management_view_path(@issue) }
			else
				flash.now[:admin_alert] = "Issue is not valid"
				format.html {render action: 'edit' }
			end
		end
	end

	def destroy
		flash["admin_notice"] = "Issue has been destroyed"
		redirect_to issue_management_index_path
	end

	def edit_workaround
		# @active_workarounds = true
		# @workarounds = return_array @issue.issue_workarounds.includes(:images)
		super
		# Below lines are tempory to get everything up and running
		@admin = true
		@workaround_create = true


		render layout: "admin_layout", template: "issues/edit_workaround"
	end

	def edit_solutions
		# @active_solutions = true
		# @solutions = return_array @issue.solutions.includes(:images)
		super
		@solution_create = true
		@admin = true
		# render layout: "admin_layout", template: "issues/edit_solutions"
		# render layout: "admin_layout", template: "issues/show_review_table"
		render layout: "admin_layout", template: "issues/edit_solutions"
	end

	def show_workarounds
		@active_workarounds = true
		@name = 'workarounds'
		@list = @issue.issue_workarounds
		render layout: "layouts/show_issue_admin", partial: "issues/show_review_table", locals: {list: @list}
	end

	def show_solutions
		@active_solutions = true
		@name = 'solutions'
		@list = @issue.solutions
		# render layout: "show_issue_admin", template: "issues/show_solutions"
		render partial: "issues/show_review_table", layout: 'layouts/show_issue_admin', locals: {list: @list}
	end

	def show_steps
		@active_steps = true
		
		@issue = Issue.find(params[:id])
		@list = @issue.detailed_steps
		@steps = @issue.detailed_steps
		render partial: "issues/show_step_table", layout: 'layouts/show_issue_admin', locals: {list: @list}
	end

	private

	# def get_dep_area
	# 	@depAreas = DepartmentArea.all.includes(:department, :area)
	# end

	# def get_impacts
	# 	@impacts = Impact.all
	# end

	def issue_params
		params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date, :picture ,:i_type, :preferences => :howTo)
	end


	# def scoped
	# 	current_user.business.issues
	# end
end

class IssueManagementController < BIssueController

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
		@issue_workarounds = scoped.issues.find(@issue).issue_workarounds
		render layout: "show_issue_admin", template: "issues/show_workarounds"
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
		redirect_to issue_management_view_path(@issue)
	end

	def destroy
		flash["admin_notice"] = "Issue has been destroyed"
		redirect_to issue_management_index_path
	end

	def edit_images
		# @active_images = true
		# @images = @issue.images
		super
		render layout: "admin_page", template: "issues/edit_images"
	end

	def edit_workaround
		# @active_workarounds = true
		# @workarounds = return_array @issue.issue_workarounds.includes(:images)
		super
		render layout: "admin_page", template: "issues/edit_workaround"
	end

	def edit_solutions
		# @active_solutions = true
		# @solutions = return_array @issue.solutions.includes(:images)
		super
		render layout: "admin_page", template: "issues/edit_solutions"
	end

	def edit_attempted_solutions
		# @active_att_sol = true
		# @attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
		super
		render layout: "admin_page", template: "issues/edit_attempted_solutions"
	end

	def show_workarounds
		@active_workarounds = true
		@issue_workarounds = @issue.issue_workarounds.includes(:images)
		render layout: "show_issue_admin", template: "issues/show_workarounds"
	end

	def show_solutions
		@active_solutions = true
		@solutions = @issue.solutions
		render layout: "show_issue_admin", template: "issues/show_solutions"
	end

	def show_attempted_solutions
		@active_att_sol = true
		@att_sol = @issue.attempted_solutions
		render layout: "show_issue_admin", template: "issues/show_attempted_solutions"
	end

	private

	# def get_dep_area
	# 	@depAreas = DepartmentArea.all.includes(:department, :area)
	# end

	# def get_impacts
	# 	@impacts = Impact.all
	# end

	def issue_params
		params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date, :i_type)
	end


	# def scoped
	# 	current_user.business.issues
	# end
end

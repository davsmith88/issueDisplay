class IssuesController < BIssueController
	load_and_authorize_resource
	# before_action :check_intro
	# before_action :find_issue, only: [:show, :edit, :update, :destroy, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions, :show_workarounds, :show_attempted_solutions, :show_solutions]
	# before_action :get_dep_area, only: [:new, :create, :edit,:edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	# before_action :get_impacts, only: [:new, :create, :edit, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	# before_action :other_permissions

	def index
		@s = params[:search]
		@loc = params[:department_area_id]

		@problems = find_items(params)
		@locations = DepartmentArea.all.group_by(&:department_id)
	end

	def show
		# shows the current issues
		# @images = @issue.images
		# @issue_workarounds = @issue.issue_workarounds.includes(:images)


		# # Issue.increment_counter(:view_counter, @issue.id)
		super
		session[:return_to] ||= request.referer
		# @workarounds = @issue.issue_workarounds
		# @solutions = @issue.solutions
		@steps = @issue.detailed_steps.order(number: :asc)
		# @type = 'IssueWorkaround'
		# @name = 'workarounds'
		# render partial: 'issues/show_review_table',
			# layout: 'displaytab',
			# locals: {list: @issue.issue_workarounds, name: 'workarounds'}
	end

	def draft_to_review
		@issue = Issue.find(params[:id])
		@issue.draft_to_review
		redirect_to issue_management_path(@issue), flash: {notice: "Issue state has been changed from draft to review"}
	end

	def review_to_draft
		@issue = Issue.find(params[:id])
		@issue.review_to_draft
		redirect_to issue_management_path(@issue), flash: {notice: "Issue state has been changed from review to draft"}
	end

	def review_to_publish
		@issue = Issue.find(params[:id])
		@issue.review_to_publish
		redirect_to issue_management_path(@issue), flash: {notice: "Issue state has been changed from review to publish"}
	end

	def publish_to_review
		@issue = Issue.find(params[:id])
		@issue.publish_to_review
		redirect_to issue_management_path(@issue), flash: {notice: "Issue state has been changed from publish to review"}
	end

	def publish_to_draft
		@issue = Issue.find(params[:id])
		@issue.publish_to_draft
		redirect_to issue_management_path(@issue), flash: {notice: "Issue state has been changed from publish to draft"}
	end

	def new
		super
		@options = DepartmentArea.pluck(:name, :id)
		respond_to do |format|
			format.html {render action: 'new'}
			format.json
		end
	end

	def create
		super
		@options = DepartmentArea.pluck(:name, :id)
		@user = current_user
		respond_to do |format|
			if @issue.save
				UserMailer.issue_create_email(@issue, @user).deliver_later
				format.html {redirect_to @issue, notice: "Issue was created successfully"}
			else
				pp @issue.errors
				flash.now[:alert] = "Issue is not valid"
				format.html {render action: 'new'}
			end
		end
	end

	# def show_workarounds
	# 	super
	# 	render partial: 'issues/show_review_table',
	# 		layout: 'displaytab',
	# 		locals: {list: @issue.issue_workarounds, name: 'workarounds'}
	# end

	# def show_solutions
	# 	super
	# 	render partial: 'issues/show_review_table',
	# 		layout: 'displaytab',
	# 		locals: {list: @issue.solutions, name: 'solutions'}
	# end

	# def show_steps
	# 	super
	# 	render partial: "issues/show_step_table",
	# 		layout: 'displaytab',
	# 	 	locals: {list: @issue.detailed_steps}
	# end

	# def show_attempted_solutions
	# 	# @active_att_sol = true{workaround: link_to("Workarounds",show_workarounds_issue_path(@issue)), solutions: link_to("Solutions", show_solutions_issue_path(@issue)), 
	# 	steps: link_to("Steps", show_steps_issue_path(@issue)),
	# 	att_sol: link_to("Attempted Solutions", show_att_sol_issue_path(@issue)),
	# 	images: link_to("Images", show_images_issue_path(@issue))},
	# 	# @att_sol = @issue.attempted_solutions
	# 	super
	# 	@list = @issue.attempted_solutions
	# 	render layout: "show_issue"
	# end

	def show_images
		super
		render layout: "show_issue"
	end


	def edit
		# @active_basic = true
		# @departments = DepartmentArea.all
		super
		@options = DepartmentArea.pluck(:name, :id)
		# render layout: "edit_page"
	end

	def edit_images
		# @active_images = true
		# @images = @issue.images
		super
		render layout: "edit_page", template: "issues/edit_images"
	end

	def edit_workaround
		# @active_workarounds = true
		# @workarounds = return_array @issue.issue_workarounds.includes(:images)
		super
		render layout: "edit_page", template: "issues/edit_workaround"
	end

	def edit_solutions
		# @active_solutions = true
		# @solutions = return_array @issue.solutions.includes(:images)
		super
		render layout: "edit_page", template: "issues/edit_solutions"
	end

	def edit_attempted_solutions
		# @active_att_sol = true
		# @attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
		super
		render layout: "edit_page", template: "issues/edit_attempted_solutions"
	end

	def update
		super
		respond_to do |format|
			if @issue.update(issue_params)
				format.html {redirect_to @issue, notice: "Issue has been updated"}
			else
				flash.now[:alert] = "Issue could not be updated"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		super
		respond_to do |format|
			format.html {redirect_to issues_path, notice: "Issue has been destroyed"}
		end
	end

	def history
		@issue = Issue.find(params[:id])
		@versions = @issue.versions
	end

	private

	# def other_permissions
	# 	if current_user

	# 		@edit = current_user.can?("edit", controller_name)
	# 		@destroy = current_user.can?("destroy", controller_name)
	# 		@create = current_user.can?("new", controller_name)
			
	# 		@workaround_create = current_user.can?("new", "issue_workarounds")
	# 		@workaround_edit = current_user.can?("edit", "issue_workarounds")
	# 		@workaround_destroy = current_user.can?("destroy", "issue_workarounds")

	# 		@image_create = current_user.can?("new", "images")
	# 		@image_edit = current_user.can?("edit", "images")
	# 		@image_destroy = current_user.can?("destroy", "images")

	# 		@solution_create = current_user.can?("new", "solutions")
	# 		@solution_edit = current_user.can?("edit", "solutions")
	# 		@solution_destroy = current_user.can?("destroy", "solutions")

	# 		@attempted_solution_create = current_user.can?("new", "attempted_solutions")
	# 		# @attempted_solution_create = current_user.can?("edit", "attempted_solutions")
	# 		# @attempted_solution_create = current_user.can?("destroy", "attempted_solutions")
	# 	end
	# end

	# def return_array(data)
	# 	data.to_a
	# end

	# def find_issue
	# 	@issue = Issue.find(params[:id])
	# end

	# def get_dep_area
	# 	@depAreas = DepartmentArea.all.includes(:department, :area)
	# end

	# def get_impacts
	# 	@impacts = Impact.all
	# end

	# def issue_params
	# 	params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date, :i_type)
	# end
	def find_items(params)
		if params.has_key?(:loc) and params.has_key?(:search)
			@loc = params[:loc]
			
			# @issues = current_user.business.issues.search(params[:search], "name|description").where(state: "publish", department_area_id: @loc).order(created_at: :desc).page(params[:page])
			# @issues = Issue.search(params[:search], "name|description", params[:page]).where(state: "publish", department_area_id: @loc).order(created_at: :desc).page(params[:page])
			@problems = Item.includes(:type).search(params[:search], "name|description", params[:page]).where(department_area_id: @loc).order(created_at: :desc).page(params[:page])
		elsif params.has_key?(:search)
			# @issues = Issue.search(params[:search], "name|description", params[:page]).where(state: "publish").order(created_at: :desc).page(params[:page])
			@problems = Item.includes(:type).search(params[:search], "name|description", params[:page]).order(created_at: :desc).page(params[:page])
			
		else
			
			# @issues = Issue.where(state: "publish").order(created_at: :desc).page(params[:page])
			@problems = Item.includes(:type).order(created_at: :desc).page(params[:page])
			# @issues = current_user.business.issues.where(state: "publish").order(created_at: :desc).page(params[:page])

		end
	end
end

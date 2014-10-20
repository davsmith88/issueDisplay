class Api::IssuesController < ApplicationController
	before_action :find_issue, only: [:show, :edit, :update, :destroy]
	before_action :get_dep_area, only: [:new, :create, :edit]
	before_action :get_impacts, only: [:new, :create, :edit]
	before_action :permissions, only: [:index]


	def index
		@issues = Issue.where(state: "publish").order(created_at: :desc).page(params[:page])
		# @issues = Issue.where(state: "publish").order(created_at: :desc).page(params[:page]) + current_user.issues.where.not(state: "publish").order(created_at: :desc)
		# @user_issues = current_user.issues.where.not(state: "publish").order(created_at: :desc)
		# pp @user_issues
		respond_to do |format|
			format.json
		end
	end

	def show

	end

	# def show
	# 	# shows the current issues
	# 	@images = @issue.images
	# 	@issue_workarounds = @issue.issue_workarounds.includes(:images)
	# 	@solutions = @issue.solutions.includes(:images)
	# 	@attempted_solutions =  @issue.attempted_solutions.includes(:images)

	# 	@user = User.find(@issue.user_id)

	# 	@impact = Impact.find_by_id(@issue.impact_id)
	# 	#da = DepartmentArea.includes(:department, :area)
	# 	#@d = da.find_by_id(@issue.DepartmentArea_id)

	# 	# Issue.increment_counter(:view_counter, @issue.id)
	# end

	def draft_to_review
		@issue = Issue.find(params[:id])
		@issue.draft_to_review
		redirect_to issue_management_index_path
	end

	def review_to_draft
		@issue = Issue.find(params[:id])
		@issue.review_to_draft
		redirect_to issue_management_index_path
	end

	def review_to_publish
		@issue = Issue.find(params[:id])
		@issue.review_to_publish
		redirect_to issue_management_index_path
	end

	def publish_to_review
		@issue = Issue.find(params[:id])
		@issue.publish_to_review
		redirect_to issue_management_index_path
	end

	def publish_to_draft
		@issue = Issue.find(params[:id])
		@issue.publish_to_draft
		redirect_to issue_management_index_path
	end

	def new
		@issue = Issue.new
		respond_to do |format|
			# format.js {}
			format.html {render action: 'new'}
		end
	end

	def create
		@issue = Issue.new(issue_params)

		@issue.user_id = current_user.id

		respond_to do |format|
			if @issue.save
				# @album = Album.create({imageable_type: "issue", imageable_id: @issue.id})
				# format.html {redirect_to @issue, notice: "Issue was created successfully"}
				format.json
			else
				# format.html {render action: 'new'}
				format.json {render :json => {:error => @issue.errors.messages}, status: 422}
			end
		end
	end

	# def edit
	# 	@images = @issue.images
	# 	@workarounds = return_array @issue.issue_workarounds.includes(:images)
	# 	@solutions = return_array @issue.solutions.includes(:images)
	# 	@attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
	# 	@departments = DepartmentArea.all
	# end

	def update
		respond_to do |format|
			if @issue.update(issue_params)
				# format.html {redirect_to @issue, notice: "Issue has been updated"}
				format.json
			else
				# format.html {render action: 'edit'}
				# format.json {render json: @issues.errors, status: :unprocessable_entity}
				format.json {render json: {:error => @issue.errors.messages}, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		@issue.destroy
		respond_to do |format|
			# format.html {redirect_to issues_path}
			format.json {head :no_content}
		end
	end

	def history
		@issue = Issue.find(params[:id])
		@versions = @issue.versions
	end

	private

	def permissions
		if current_user
			@edit = current_user.can?("edit", controller_name)
			@destroy = current_user.can?("destroy", controller_name)
			@create = current_user.can?("new", controller_name)
		end
	end

	def return_array(data)
		data.to_a
	end

	def find_issue
		@issue = Issue.find(params[:id])
	end

	def get_dep_area
		@depAreas = DepartmentArea.all.includes(:department, :area)
	end

	def get_impacts
		@impacts = Impact.all
	end

	def issue_params
		params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date, :i_type)
	end
end
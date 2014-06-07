class IssuesController < ApplicationController

	before_action :find_issue, only: [:show, :edit, :update, :destroy]
	before_action :get_dep_area, only: [:new, :create, :edit]
	before_action :get_impacts, only: [:new, :create, :edit]
	before_action :permissions, only: [:index]

	def index
		@issues = Issue.ordered_by_desc.page(params[:page])
	end

	def show

		# shows the current issues
		@images = @issue.images
		@issue_workarounds = @issue.issue_workarounds.includes(:images)
		@solutions = @issue.solutions.includes(:images)
		@attempted_solutions =  @issue.attempted_solutions.includes(:images)

		@user = User.find(@issue.user_id)

		@impact = Impact.find_by_id(@issue.impact_id)
		#da = DepartmentArea.includes(:department, :area)
		#@d = da.find_by_id(@issue.DepartmentArea_id)

		# Issue.increment_counter(:view_counter, @issue.id)
	end

	def new
		@issue = Issue.new
	end

	def create
		@issue = Issue.new(issue_params)
		
		@issue.user_id = current_user.id
		# @album = Album.create({imageable_type: "issue", imageable_id: @issue.id})
	
		respond_to do |format| 
			if @issue.save
				@album = Album.create({imageable_type: "issue", imageable_id: @issue.id})
				format.html {redirect_to @issue, notice: "Issue was created successfully"}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
		@images = @issue.images
		@workarounds = return_array @issue.issue_workarounds.includes(:images)
		@solutions = return_array @issue.solutions.includes(:images)
		@attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
		@departments = DepartmentArea.all
	end

	def update

		respond_to do |format|
			if @issue.update(issue_params)
				format.html {redirect_to @issue, notice: "Issue has been updated"}
				format.json {head :no_content}
			else
				format.html {render action: 'edit'}
				format.json {render json: @issues.errors, status: :unprocessable_entity}
			end
		end
	end

	def destroy
		@issue.destroy
		respond_to do |format|
			format.html {redirect_to issues_path}
			format.json {head :no_content}
		end
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
		params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date)
	end
	    
end

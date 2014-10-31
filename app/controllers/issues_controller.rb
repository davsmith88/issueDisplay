class IssuesController < ApplicationController

	before_action :find_issue, only: [:show, :edit, :update, :destroy, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	before_action :get_dep_area, only: [:new, :create, :edit,:edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	before_action :get_impacts, only: [:new, :create, :edit, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	# before_action :other_permissions


	def index
		@issues = Issue.where(state: "publish").order(created_at: :desc).page(params[:page])
	end

	def show
		# shows the current issues
		@images = @issue.images
		@issue_workarounds = @issue.issue_workarounds.includes(:images)
		@solutions = @issue.solutions.includes(:images)
		@attempted_solutions =  @issue.attempted_solutions.includes(:images)

		# @user = User.find(@issue.user_id)

		@impact = Impact.find_by_id(@issue.impact_id)
		#da = DepartmentArea.includes(:department, :area)
		#@d = da.find_by_id(@issue.DepartmentArea_id)

		# Issue.increment_counter(:view_counter, @issue.id)
	end

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
			format.html {render action: 'new'}
		end
	end

	def create
		@issue = Issue.new(issue_params)
		if issue_params[:review_date] and @issue.review_date
			issue_review_date = Date.parse(@issue.review_date.to_s).strftime("%d-%m-%Y")
			current_review_date = Date.parse(issue_params[:review_date]).strftime("%d-%m-%Y")
			# if the submitted review date is equal to the issue's review date
			# then use the current date (today) now and add on two weeks
			# else check if the submmited review date is less than todays' date
			# then use today's, add two weeks and assign that to the review date
			# so that means that if the review date is greater than the review date
			# and greater than the current date, assign that date to the review value
			# need to check that this works
			if current_review_date == issue_review_date
				# puts "review date has not changed"
				convert_date = DateTime.now + 2.weeks
				params[:issue]["review_date"] = convert_date
			else
				# puts "review date as changed"
				if current_review_date < DateTime.now
					# puts "review date is less that the current date"
					params[:issue]["review_date"] = DateTime.now + 2.weeks
				end
			end
		end


		
		# @issue.user_id = current_user.id
		@issue.user_id = 15

		respond_to do |format|
			if @issue.save
				# @album = Album.create({imageable_type: "issue", imageable_id: @issue.id})
				format.html {redirect_to @issue, notice: "Issue was created successfully"}
				format.json {head :no_content}
			else
				format.html {render action: 'new'}
				format.json {render :json => {:success => false, :error => @issue.errors.messages}, status: 422}
			end
		end
	end

	def edit
		@active_basic = true
		@departments = DepartmentArea.all
		render layout: "edit_page"
	end

	def edit_images
		@active_images = true
		@images = @issue.images
		render layout: "edit_page", template: "issues/edit_images"
	end

	def edit_workaround
		@active_workarounds = true
		@workarounds = return_array @issue.issue_workarounds.includes(:images)
		render layout: "edit_page", template: "issues/edit_workaround"
	end

	def edit_solutions
		@active_solutions = true
		@solutions = return_array @issue.solutions.includes(:images)
		render layout: "edit_page", template: "issues/edit_solutions"
	end

	def edit_attempted_solutions
		@active_att_sol = true
		@attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
		render layout: "edit_page", template: "issues/edit_attempted_solutions"
	end

	def update
		issue_review_date = Date.parse(@issue.review_date.to_s).strftime("%d-%m-%Y")
		current_review_date = Date.parse(issue_params[:review_date]).strftime("%d-%m-%Y")
		# if the submitted review date is equal to the issue's review date
		# then use the current date (today) now and add on two weeks
		# else check if the submmited review date is less than todays' date
		# then use today's, add two weeks and assign that to the review date
		# so that means that if the review date is greater than the review date
		# and greater than the current date, assign that date to the review value
		if current_review_date == issue_review_date
			# puts "review date has not changed"
			convert_date = DateTime.now + 2.weeks
			params[:issue]["review_date"] = convert_date
		else
			# puts "review date as changed"
			if current_review_date < DateTime.now
				# puts "review date is less that the current date"
				params[:issue]["review_date"] = DateTime.now + 2.weeks
			end
		end
		respond_to do |format|
			if @issue.update(issue_params)
				format.html {redirect_to @issue, notice: "Issue has been updated"}
				format.json {head :no_content}
			else
				format.html {render action: 'edit'}
				# format.json {render json: @issues.errors, status: :unprocessable_entity}
				format.json {render json: {success: false, :error => @issue.errors.messages}, status: :unprocessable_entity}
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

	def history
		@issue = Issue.find(params[:id])
		@versions = @issue.versions
	end

	private

	def other_permissions
		if current_user
			@workaround_create = current_user.can?("new", "issue_workarounds")
			@workaround_edit = current_user.can?("edit", "issue_workarounds")
			@workaround_destroy = current_user.can?("destroy", "issue_workarounds")

			@image_create = current_user.can?("new", "images")
			@image_edit = current_user.can?("edit", "images")
			@image_destroy = current_user.can?("destroy", "images")

			@solution_create = current_user.can?("new", "solutions")
			@solution_edit = current_user.can?("edit", "solutions")
			@solution_destroy = current_user.can?("destroy", "solutions")

			@attempted_solution_create = current_user.can?("new", "attempted_solutions")
			@attempted_solution_create = current_user.can?("edit", "attempted_solutions")
			@attempted_solution_create = current_user.can?("destroy", "attempted_solutions")
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

class BIssueController < ApplicationController

	# before_action :check_intro
	before_action :find_issue, only: [:show, :edit, :update, :destroy, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions, :show_workarounds, :show_attempted_solutions, :show_solutions, :show_images]
	before_action :get_dep_area, only: [:new, :create, :edit,:edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	before_action :get_impacts, only: [:new, :create, :edit, :edit_images, :edit_basic, :edit_workaround, :edit_solutions, :edit_attempted_solutions]
	# before_action :other_permissions

	def show
		# @images = @issue.images
		@images = []
		@issue_workarounds = @issue.issue_workarounds.includes(:images)


		# Issue.increment_counter(:view_counter, @issue.id)
		@active_workarounds = true
		@workarounds = @issue.issue_workarounds
	end


	def new
		@issue = current_user.business.issues.new
	end

	def create
		@issue = current_user.business.issues.new(issue_params)
		if issue_params[:review_date] and @issue.review_date
			issue_review_date = DateTime.parse(@issue.review_date.to_s).strftime("%d-%m-%Y")
			current_review_date = DateTime.parse(issue_params[:review_date]).strftime("%d-%m-%Y")
			# if the submitted review date is equal to the issue's review date
			# then use the current date (today) now and add on two weeks
			# else check if the submmited review date is less than todays' date
			# then use today's, add two weeks and assign that to the review date
			# so that means that if the review date is greater than the review date
			# and greater than the current date, assign that date to the review value
			# need to check that this works
			if current_review_date == issue_review_date
				# puts "review date has not changed"
				convert_date = DateTime.now.utc + 2.weeks
				params[:issue]["review_date"] = convert_date
			else
				# puts "review date as changed"
				if current_review_date < DateTime.now.utc
					# puts "review date is less that the current date"
					params[:issue]["review_date"] = DateTime.now.utc + 2.weeks
				end
			end
		end
		@issue.user_id = current_user.id
	end

	def edit
		@active_basic = true
		@departments = DepartmentArea.all
	end

	def update
		if issue_params[:review_date]
			issue_review_date = DateTime.parse("#{@issue.review_date.to_s}").strftime("%d-%m-%Y")
			current_review_date = DateTime.parse("#{issue_params[:review_date]}").strftime("%d-%m-%Y")
			# if the submitted review date is equal to the issue's review date
			# then use the current date (today) now and add on two weeks
			# else check if the submmited review date is less than todays' date
			# then use today's, add two weeks and assign that to the review date
			# so that means that if the review date is greater than the review date
			# and greater than the current date, assign that date to the review value
			if current_review_date == issue_review_date
				# puts "review date has not changed"
				convert_date = DateTime.now.utc + 2.weeks
				params[:issue]["review_date"] = convert_date
			else
				if current_review_date < DateTime.now
					params[:issue]["review_date"] = DateTime.now.utc + 2.weeks
				end
			end
		else
			# if no review date was supplied
			params[:issue]["review_date"] = DateTime.now.utc + 2.weeks
		end
	end

	def destroy
		@issue.destroy
	end



	def edit_images
		@active_images = true
		@images = @issue.images
	end

	def edit_workaround
		@active_workarounds = true
		# @workarounds = return_array @issue.issue_workarounds.includes(:images)
		@workarounds = @issue.issue_workarounds
	end

	def edit_solutions
		@active_solutions = true
		# @solutions = return_array @issue.solutions.includes(:images)
		@solutions = @issue.solutions
	end

	def edit_attempted_solutions
		@active_att_sol = true
		@attempted_solutions = return_array @issue.attempted_solutions.includes(:images)
	end

	# def show_workarounds
	# 	@active_workarounds = true
	# 	@issue_workarounds = @issue.issue_workarounds.includes(:images)
	# 	# render layout: "show_issue"
	# end

	def show_images
		@active_images = true
		@images = @issue.images
	end

	# def show_solutions
	# 	@active_solutions = true
	# 	@solutions = @issue.solutions
	# 	# render layout: "show_issue"
	# end

	# def show_steps
	# 	@active_steps = true
	# 	@steps = @issue.detailed_steps
	# end

	def show_attempted_solutions
		@active_att_sol = true
		@att_sol = @issue.attempted_solutions
		# render layout: "show_issue"
	end

	private
		def scoped
			current_user.business
		end

		def find_issue
			@issue = scoped.issues.find(params[:id])
		end

		def get_dep_area
			@depAreas = scoped.department_areas.includes(:department, :area)
		end

		def get_impacts
			@impacts = scoped.impacts.all
		end

		def issue_params
			params.require(:issue).permit(:name, :description, :impact_id, :department_area_id, :review_date, :picture, :i_type)
		end

		def return_array(data)
			data.to_a
		end

		def other_permissions
			if current_user

				@edit = current_user.can?("edit", controller_name)
				@destroy = current_user.can?("destroy", controller_name)
				@create = current_user.can?("new", controller_name)
				
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
				# @attempted_solution_create = current_user.can?("edit", "attempted_solutions")
				# @attempted_solution_create = current_user.can?("destroy", "attempted_solutions")
			end
		end
end
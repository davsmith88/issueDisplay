class EditIssue < ApplicationController
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
end
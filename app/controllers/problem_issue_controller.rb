class ProblemIssueController < ApplicationController
	load_and_authorize_resource
	def index
		@probiss = ProblemIssue.all
	end

	def new
		# @problems = Item.p_attr_name_id
		# @issues = Item.i_attr_name_id

		@a_problem = Problem.includes(:item).pluck("items.name", :id)
		@b_issue = Issue.includes(:item).pluck("items.name", :id)

		# @issues = Issue.pluck(:name, :id)
	end

	def create
		ProblemIssue.create(problem_issue_params)

		respond_to do |format|
			format.html {redirect_to problems_path}
		end
	end

	def destroy
	end

	def problem_issue_params
		params.require(:problem_issue).permit(:problem_id, :issue_id)
	end

end
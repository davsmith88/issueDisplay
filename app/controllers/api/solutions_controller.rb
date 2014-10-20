class Api::SolutionsController < ApplicationController

	before_action :get_issue, only: [:create]
	before_action :get_solution, only: [:update, :destroy]

	def cors
		respond_to do |format|
			format.json {head :no_content}
		end
	end

	def index
		if params[:ids].kind_of?(Array)
			@solutions = Solution.find(params[:ids])
		else
			@solutions = Solution.where(issue_id: params[:issue_id])
		end

		respond_to do |format|
			format.json
		end
	end

	def create
		@solution = @issue.solutions.new(solution_params)
		respond_to do |format|
			if @solution.save
				# @issue.change_state
				format.json
			else
				format.json {render template: "api/solutions/create.json.jbuilder", status: 422}
			end
		end
	end

	def update
		respond_to do |format|
			if @solution.update(solution_params)
				format.json
			else
				format.json {render template: "api/solutions/update.json.jbuilder", status: 422}
			end
		end
	end

	def destroy
		@solution.destroy

		respond_to do |format|
			format.json {head :no_content}
		end
	end

	private

	def solution_params
		params.require(:solution).permit(:name, :content)
	end

	def get_issue
		@issue = Issue.find(params[:solution][:issue])
	end

	def get_solution
		@solution = Solution.find(params[:id])
	end
end
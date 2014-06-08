class SolutionsController < ApplicationController

	before_action :get_issue, only: [:new, :create]
	before_action :get_solution, only: [:edit, :update, :destroy]

	def new
		@solution = @issue.solutions.new
	end
	
	def create
		@solution = @issue.solutions.new(solution_params)
		respond_to do |format|
			if @solution.save
				format.html {redirect_to edit_issue_path(@issue), notice: "Solution has been created"}
			else
				format.html {render action: 'new'}
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @solution.update(solution_params)
				format.html {redirect_to edit_issue_path(@solution.issue)}
				format.json {head :no_content}
			end
		end
	end

	def destroy
		if @solution.destroy
			respond_to do |format|
				format.html {redirect_to edit_issue_path(@solution.issue)}
				format.json {head :no_content}
			end
		end
	end

	private

	def get_issue
		@issue = Issue.find(params[:issue_id])
	end

	def get_solution
		@solution = Solution.find(params[:id])
	end

	def solution_params
		params.require(:solution).permit(:name, :content)
	end	
end

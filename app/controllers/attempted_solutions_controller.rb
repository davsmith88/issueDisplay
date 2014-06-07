class AttemptedSolutionsController < ApplicationController

	before_action :get_issue, only: [:new, :create, :show, :edit, :update, :destroy]
	before_action :get_attempted, only: [:edit, :update, :destroy]

	def new
		@attempted = @issue.attempted_solutions.new
	end

	def create
		@attempted = @issue.attempted_solutions.new(attempted_params)
		respond_to do |format|
			if @attempted.save
				format.html {redirect_to edit_issue_path(@issue)}
			else
				format.html {render action: 'new' }
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @attempted.update(attempted_params)
				format.html {redirect_to edit_issue_path(@issue)}
				format.json {head :no_content}
			end
		end
	end

	def destroy
		@attempted.destroy
		redirect_to edit_issue_path(@issue)
	end

	private

	def get_issue
		@issue = Issue.find(params[:issue_id])
	end

	def get_attempted
		@attempted = @issue.attempted_solutions.find(params[:id])
	end

	def attempted_params
		params.require(:attempted_solution).permit(:name, :description, :reason)
	end
end

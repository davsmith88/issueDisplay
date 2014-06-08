class IssueWorkaroundsController < ApplicationController

	before_action :get_issue, only: [:new, :create]
	before_action :get_workaround, only: [:edit, :update, :destroy]

	def new
		@issue_workaround = @issue.issue_workarounds.new
	end

	def create
		@issue_workaround = @issue.issue_workarounds.new(workaround_params)
		respond_to do |format|
			if @issue_workaround.save
				format.html {redirect_to edit_issue_path(@issue)}
			end
		end
	end

	def edit
	end

	def update
		@issue_workaround.update(workaround_params)
		respond_to do |format|
			if @issue_workaround.save
				format.html {redirect_to edit_issue_path(@issue_workaround.issue)}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@issue_workaround.destroy
		redirect_to edit_issue_path(@issue_workaround.issue)
	end

	private

	def get_issue
		@issue = Issue.find(params[:issue_id])
	end

	def get_workaround
		@issue_workaround = IssueWorkaround.find(params[:id])
	end

	def workaround_params
		params.require(:issue_workaround).permit(:description)
	end
end

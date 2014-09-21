class IssueWorkaroundsController < ApplicationController

	before_action :get_issue, only: [:new, :create, :update, :index]
	before_action :get_workaround, only: [:edit, :update, :destroy]

	def index
		@issue_workarounds = @issue.issue_workarounds.to_a
		respond_to do |format|
			format.json
		end
	end

	def new
		@issue_workaround = @issue.issue_workarounds.new
	end

	def cors
		respond_to do |format|
			format.json {head :no_content}
		end
	end

	def create
		@issue_workaround = @issue.issue_workarounds.new(workaround_params)
		respond_to do |format|
			if @issue_workaround.save
				# @issue.change_state
				format.html {redirect_to edit_issue_path(@issue)}
				format.json
			else
				format.html
				format.json {render template: "issue_workarounds/create.json.jbuilder", status: 422}
			end
		end
	end

	def edit
	end

	def update
		puts params
		respond_to do |format|
			if @issue_workaround.update(workaround_params)
				# @issue.change_state
				format.html {redirect_to edit_issue_path(@issue_workaround.issue)}
				# format.json {head :no_content}
				format.json
			else
				format.html {render action: 'edit'}
				# to return json with a http status code, provide the format.json with the
				# render method, then providing the template param with the location of the
				# jbuidler file and also the stats code
				format.json {
					render template: "issue_workarounds/update.json.jbuilder", status: 422
				}
			end
		end
	end

	def destroy
		@issue_workaround.destroy
		
		respond_to do |format|
			format.html {redirect_to edit_issue_path(@issue_workaround.issue)}
			format.json {head :no_content}
		end
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

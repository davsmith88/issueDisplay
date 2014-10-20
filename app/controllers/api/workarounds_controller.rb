class Api::WorkaroundsController < ApplicationController

	before_action :get_issue, only: [:create]
	before_action :get_issue_workaround, only: [:update, :destroy]

	def cors

	end

	def index
		if params[:ids].kind_of?(Array)
			@workarounds = IssueWorkaround.find(params[:ids])
		else
			@workarounds = IssueWorkaround.where(issue_id: params[:issue_id])
		end

		respond_to do |format|
			format.json
		end
	end

	def create
		# @issue = Issue.find(params[:workaround][:issue])

		@workaround = @issue.issue_workarounds.new(workaround_params)

		respond_to do |format|
			if @workaround.save

				format.json
			else
				# format.json {render :json => {:success => false, :error => @issue.errors.messages}, status: 422}
				format.json {render json: {error: "there was an error trying to save"}, status: 422}
			end
		end
	end

	def update
		# @workaround = IssueWorkaround.find(params[:id])
		respond_to do |format|
			if @workaround.update(workaround_params)
				# @issue.change_state
				# format.html {redirect_to edit_issue_path(@issue_workaround.issue)}
				# format.json {head :no_content}
				format.json
			else
				# format.html {render action: 'edit'}
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
		# @workaround = IssueWorkaround.find(params[:id])
		@workaround.destroy
		respond_to do |format|
			format.json {head :no_content}
		end
	end

	private

	def get_issue
		@issue = Issue.find(params[:workaround][:issue])
	end

	def get_issue_workaround
		@workaround = IssueWorkaround.find(params[:id])
	end

	def workaround_params
		params.require(:workaround).permit(:description)
	end
end
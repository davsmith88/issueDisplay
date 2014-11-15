# class IssueWorkaroundsController < ApplicationController

# 	before_action :get_issue, only: [:new, :create, :index]
# 	before_action :get_workaround, only: [:edit, :update, :destroy]

# 	def index
# 		@issue_workarounds = @issue.issue_workarounds
# 		# respond_to do |format|
# 		# 	format.json
# 		# end
# 	end

# 	def new
# 		@issue_workaround = @issue.issue_workarounds.new
# 	end

# 	# def cors
# 	# 	respond_to do |format|
# 	# 		format.json {head :no_content}
# 	# 	end
# 	# end

# 	def create
# 		@issue_workaround = @issue.issue_workarounds.new(workaround_params)
# 		respond_to do |format|
# 			if @issue_workaround.save
# 				# @issue.change_state
# 				format.html {redirect_to edit_issue_path(@issue)}
# 			else
# 				flash.now[:alert] = "Issue Workaround could not be created - Invalid Attributes"
# 				format.html {render action: 'new'}
# 			end
# 		end
# 	end

# 	def edit
# 	end

# 	def update
# 		respond_to do |format|
# 			if @issue_workaround.update(workaround_params)
# 				# @issue.change_state
# 				format.html {redirect_to edit_issue_path(@issue_workaround.issue), notice: "Workaround has been updated"}
# 			else
# 				flash.now[:alert] = "Workaround could not be saved"
# 				format.html {render action: 'edit'}
# 			end
# 		end
# 	end

# 	def destroy
# 		respond_to do |format|
# 			if @issue_workaround.destroy
# 				format.html {redirect_to edit_issue_path(@issue_workaround.issue), notice: "Issue Workaround has been deleted"}
# 			else
# 				format.html { redirect_to edit_issue_path(@issue_workaround.issue), notice: "Issue Workaround could not be deleted" }
# 			end
# 		end
# 	end

# 	private

# 	def get_issue
# 		@issue = Issue.find(params[:issue_id])
# 	end

# 	def get_workaround
# 		@issue_workaround = IssueWorkaround.find(params[:id])
# 	end

# 	def workaround_params
# 		params.require(:issue_workaround).permit(:description)
# 	end
# end

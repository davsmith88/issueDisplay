class RecordsController < ApplicationController

	def index
		@issue = Issue.find(params[:issue_id])
		@issue_w = @issue.issue_workarounds
		if params.has_key?(:issue_id)
			@records = @issue_w
			#@records = Record.where(issue_id: params[:issue_id]).group(:recordable_type, :recordable_id)
			#@records_count = Record.where(issue_id: params[:issue_id]).group(:recordable_type, :recordable_id).count
			
		else
			#@records = Record.all.group_by(:issue_id)
		end
		# @records = Record.all
	end

	def create
		@issue = Issue.find(params[:issue_id])
		#@issue_workaround = IssueWorkaround.find(params[:recordable_id])
		@issue_workaround = params[:recordable_type].constantize.find(params[:recordable_id])
		@issue_workaround.records.create(record_params)
		redirect_to @issue, notice: "#{params[:recordable_type]} has been recorded. Thank you for your coperation"
	end

	private

	def record_params
		params.permit(:issue_id, :user_id, :recordable_type, :recordable_id)
	end
end

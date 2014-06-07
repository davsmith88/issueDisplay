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

	def new
		@c = find_recordable
		@record = @c.records.new
	end

	def create
		@c = find_recordable
	
		@record = @c.records.new(record_params)
		@record.issue_id = @c.issue_id
		@record.save

		redirect_to issue_path(@c.issue), notice: " has been recorded. Thank you for your coperation"
	end

	private

	def record_params
		#params.require(:record).permit(:issue_id, :user_id, :recordable_type, :recordable_id, :message)
		params.require(:record).permit!
	end

	def find_recordable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      	return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

end

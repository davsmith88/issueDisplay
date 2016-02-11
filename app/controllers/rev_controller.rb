class RevController < ApplicationController

	authorize_resource

	before_action :set_type
	before_action :get_name
	before_action :get_issue, only: [:new, :create, :index, :edit, :update, :destroy]
	before_action :get_review, only: [:edit, :update, :destroy]
	before_action :set_redirect_name, only: [:create, :update, :destroy]

	def index
		puts type_class
		puts "--------"
		@reviews = type_class.all
	end
	def new
		# puts @issue
		association = @issue.send associated_method
		@review = association.new
	end

	def create
		association = @issue.send associated_method
		@review = association.new(review_params)
	end

	def edit
		
	end

	def update
		respond_to do |format|
			if @review.update(review_params)
				# @issue.change_state
				format.html {redirect_to edit_issue_path(@issue), notice: "#{pretty_class_name} has been updated"}
			else
				flash.now[:alert] = "#{pretty_class_name} could not be saved"
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		respond_to do |format|
			if @review.destroy
				format.html {redirect_to edit_issue_path(@issue), notice: "#{pretty_class_name} has been deleted"}
			else
				format.html { redirect_to edit_issue_path(@issue), notice: "#{pretty_class_name} could not be deleted" }
			end
		end
	end


	private

	def set_type
	# 			puts "----------------"
	# 	puts params
	# 	puts "----------------"
		@type = type
		@class =  params[:type].underscore.humanize
		puts @class
	end

	def get_name
		@name = params[:u]
	end

	def type
		puts params[:type]
		Review.types.include?(params[:type]) ? params[:type] : "Review"
	end

	def type_class
		type.constantize
	end

	def associated_method
		type.underscore.pluralize.to_sym
	end

	def pretty_class_name
		params[:type].underscore.humanize
	end





	def get_issue
		id =  params[:issue_id] || params[:id] || params[:issue_management_id]
		@issue = Issue.find(id)
	end

	def get_review
		@review = type_class.find(params[:id])
	end

	def review_params
		params.require(type.underscore.downcase.to_sym).permit(:description)
	end

end
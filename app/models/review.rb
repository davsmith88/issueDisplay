class Review < ActiveRecord::Base
	
	belongs_to :issue
	belongs_to :user
	has_one :medium, as: :imageable, dependent: :destroy

	validates :description, presence: {message: "Workaround needs to have a description"}
	# validate :assign_review_date

	scope :workarounds, -> { where(type: 'IssueWorkaround') }
	scope :solutions, -> { where(type: 'Solution') }
	scope :attempted_solutions, -> { where(type: 'AttemptedSolution') }

	# state_machine :state, :initial => :draft do
	# 	state :draft, value: 'draft'
	# 	state :review, value: 'review'
	# 	state :publish, value: 'publish'

	# 	event :draft_to_review do
	# 		transition :draft => :review
	# 	end
	# 	event :review_to_publish do
	# 		transition :review => :publish
	# 	end
	# 	event :review_to_draft do
	# 		transition :review => :draft
	# 	end

	# 	event :publish_to_draft do
	# 		transition :publish => :draft
	# 	end
	# 	event :publish_to_review do
	# 		transition :publish => :review
	# 	end
	# end

	# def change_state
	# 	if self.state?(:publish)
	# 		self.publish_to_draft
	# 	elsif self.state?(:review)
	# 		self.review_to_draft
	# 	end
	# end

	def self.types
		%w(IssueWorkaround Solution AttemptedSolution)
	end

	def build
		if medium
			medium
		else
			build_medium
		end
	end

	protected

	# def assign_review_date
	# 	if self.review_date.nil?
	# 		self.review_date = DateTime.now.utc + 2.weeks
	# 	end
	# 	current_review_date = DateTime.parse(self.review_date.to_s).strftime("%d-%m-%Y")
	# 	# if the submitted review date is equal to the issue's review date
	# 	# then use the current date (today) now and add on two weeks
	# 	# else check if the submmited review date is less than todays' date
	# 	# then use today's, add two weeks and assign that to the review date
	# 	# so that means that if the review date is greater than the review date
	# 	# and greater than the current date, assign that date to the review value
	# 	# need to check that this works
	# 	if current_review_date < DateTime.now.utc
	# 		self.review_date = DateTime.now.utc + 2.weeks
	# 	end
	# end
end

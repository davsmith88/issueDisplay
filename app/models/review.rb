class Review < ActiveRecord::Base
	include PublicActivity::Model
  	# tracked owner: Proc.new{ |controller, model| controller.current_user }

	belongs_to :issue
	has_many :records, as: :recordable
	has_many :images, as: :imageable, dependent: :destroy

	validates :description, presence: {message: "Workaround needs to have a description"}

	scope :workarounds, -> { where(type: 'IssueWorkaround') }
	scope :solutions, -> { where(type: 'Solution') }
	scope :attempted_solutions, -> { where(type: 'AttemptedSolution') }

	state_machine :state, :initial => :draft do
		state :draft, value: 'draft'
		state :review, value: 'review'
		state :publish, value: 'publish'

		event :draft_to_review do
			transition :draft => :review
		end
		event :review_to_publish do
			transition :review => :publish
		end
		event :review_to_draft do
			transition :review => :draft
		end

		event :publish_to_draft do
			transition :publish => :draft
		end
		event :publish_to_review do
			transition :publish => :review
		end
	end
end

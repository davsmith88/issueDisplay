class Issue < ActiveRecord::Base
	include PublicActivity::Model

  	#tracked owner: Proc.new{ |controller, model| controller.current_user }
	# has_paper_trail :meta => {:department_area_name => :get_department_name,
		# :impact_name => :get_impact_name
	# }

  	TYPES = ["operational", "mechanical", "electrical"]

	def get_department_name
		return if !self.department_area
		self.department_area.name
	end

	def get_impact_name
		return if !self.impact
		self.impact.name
	end

	def change_state
		if self.state?(:publish)
			self.publish_to_draft
		elsif self.state?(:review)
			self.review_to_draft
		end
	end

	self.per_page = 10
	has_many :solutions
	has_many :attempted_solutions
	has_many :issue_workarounds
	has_many :images, as: :imageable
	has_many :records, as: :recordable
	has_many :notes

	belongs_to :department_area
	belongs_to :impact
	belongs_to :user

	validates :name, presence: {message: "Issue needs to have a name"}
	validates :impact_id, numericality: {
		message: "Impact ID must be an integer only",
		only_integer: true
	}, if: "!impact_id.nil?"
	validates :user_id, numericality: {
		message: "User ID must be an integer only",
		only_integer: true
	}, if: "!user_id.nil?"

	validates :department_area_id, numericality: {
		message: "Department Area ID must be an integer only",
		only_integer: true
	}, if: "!department_area_id.nil?"
	validates :review_date, presence: true

	scope :ordered_by_desc, ->{ order("created_at DESC") }

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

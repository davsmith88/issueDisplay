class Issue < ActiveRecord::Base
	include PublicActivity::Model
  	tracked owner: Proc.new{ |controller, model| controller.current_user }

  	
	self.per_page = 5
	has_many :solutions
	has_many :attempted_solutions
	has_many :issue_workarounds

	belongs_to :department_area
	belongs_to :impact

	#has_one :department_area
	# has_one :department
	# has_one :area
	#has_one :impact
	# has_one :album, as: :imageable
	has_many :images, as: :imageable


	
	has_many :records, as: :recordable

	has_attached_file :image, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	# do_not_validate_attachment_file_type :image
	# validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :name, presence: {message: "Issue needs to have a name"}
	validates :review_date, presence: true

	scope :ordered_by_desc, order("created_at DESC")

	state_machine :state, :initial => :draft do
		state :draft, value: 'draft'
		state :review, value: 'review'
		state :publish, value: 'pending'

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

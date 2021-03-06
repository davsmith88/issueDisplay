class Issue < ActiveRecord::Base
	# include PublicActivity::Model
	# tracked
	after_initialize :init

	store_accessor :preferences, :howTo, :workaround, :solution

	# validates :howTo, inclusion: { in: [true, false] }

  	#tracked owner: Proc.new{ |controller, model| controller.current_user }
	# has_paper_trail :meta => {:department_area_name => :get_department_name,
		# :impact_name => :get_impact_name
	# }

  	TYPES = ["operational", "mechanical", "electrical"]



  	def self.search(search, search_col, page)
  		search_condition = "%#{search}%"
  		case search_col
	  		when "id"
	  			condition = ['id = ?', search]
	  		when "name"
	  			condition = ['name like ?', search_condition]
	  		when "description"
	  			condition = ['description like ?', search_condition]
	  		when "name|description"
	  			condition = ['name like ? OR description like ?', search_condition, search_condition]
  			else
  				condition = ['name like ?', search_condition]
  		end
  		
  		Issue.order('name').where(condition).paginate(:page => 1)
  		# paginate per_page: 5, page: page, conditions: condition, order: 'name'
  	
  	end

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

	self.per_page = 5
	# has_many :solutions
	# has_many :attempted_solutions
	# has_many :issue_workarounds
	has_many :detailed_steps
	# has_many :records, as: :recordable
	# has_many :notes

	has_many :problem_issues

	has_many :problems, through: :problem_issues

	has_one :item, as: :type, dependent: :destroy
	accepts_nested_attributes_for :item

	# belongs_to :department_area

	
	belongs_to :impact
	belongs_to :user
	belongs_to :problem
	# belongs_to :business


	# validates :name, presence: {message: "Issue needs to have a name"}
	# validates :impact_id, numericality: {
	# 	message: "Impact ID must be an integer only",
	# 	only_integer: true
	# }, if: "!impact_id.nil?"
	# validates :user_id, numericality: {
	# 	message: "User ID must be an integer only",
	# 	only_integer: true
	# }, if: "!user_id.nil?"

	# validates :department_area_id, numericality: {
	# 	message: "Department Area ID must be an integer only",
	# 	only_integer: true
	# }, if: "!department_area_id.nil?"
	
	validates :review_date, presence: true

	scope :ordered_by_desc, -> { order("created_at DESC") }

	# used for video uploading
	has_attached_file :avatar, :styles => {
	    :medium => { :geometry => "640x480", :format => 'mp4' },
	    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
	  }, :processors => [:transcoder]
	  validates_attachment_content_type :avatar, content_type: /\Avideo\/.*\Z/ 

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


	def init
		puts self.review_date
      self.review_date  ||= DateTime.now + 3.weeks           #will set the default value only if it's nil
      # self.address ||= build_address #let's you set a default association
    end

end

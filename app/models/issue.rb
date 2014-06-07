class Issue < ActiveRecord::Base
	self.per_page = 3
	has_many :solutions
	has_many :attempted_solutions
	has_many :issue_workarounds
	has_one :department_area
	# has_one :department
	# has_one :area
	has_one :impact
	# has_one :album, as: :imageable
	has_many :images, as: :imageable


	
	has_many :records

	has_attached_file :image, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	# do_not_validate_attachment_file_type :image
	# validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :name, presence: {message: "Issue needs to have a name"}
	validates :review_date, presence: true

	scope :all, order("created_at DESC")
end

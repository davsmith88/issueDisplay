class Department < ActiveRecord::Base
  has_many :department_areas
  has_many :areas, through: :department_areas

  has_many :issues, through: :department_areas

	# belongs_to :business

	self.per_page = 8

	validates :name, presence: {message: "Department needs to have a name"}
	validates :description, presence: {message: "Description needs to be filled out"}
end

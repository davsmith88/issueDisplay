class Area < ActiveRecord::Base
	has_many :department_areas
  
	self.per_page = 8

	validates :name, presence: { message: "Each area must be provided with a name" }
	validates :description, presence: { message: "Each area must have a formal description" }
end

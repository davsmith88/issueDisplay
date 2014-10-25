class Department < ActiveRecord::Base
	belongs_to :issue

	self.per_page = 8

	validates :name, presence: {message: "Department needs to have a name"}
	validates :description, presence: {message: "Description needs to be filled out"}
end

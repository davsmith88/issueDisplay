class Area < ActiveRecord::Base
	belongs_to :issue
	belongs_to :business

	self.per_page = 8

	validates :name, presence: { message: "Each area must be provided with a name" }
	validates :description, presence: { message: "Each area must have a formal description" }
end

class Impact < ActiveRecord::Base
	belongs_to :issue

	self.per_page = 5

	validates :name, presence: {message: "Impact must have a name"}
end

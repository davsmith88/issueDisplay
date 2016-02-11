class Impact < ActiveRecord::Base
	has_many :issues
	belongs_to :business

	self.per_page = 5

	validates :name, presence: {message: "Impact must have a name"}
end

class Assignment < ActiveRecord::Base
	belongs_to :user
	belongs_to :role

	belongs_to :business

	validates_uniqueness_of :user, scope: :role

	self.per_page = 5
end

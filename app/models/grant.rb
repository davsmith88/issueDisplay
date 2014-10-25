class Grant < ActiveRecord::Base
	belongs_to :role
	belongs_to :right

	self.per_page = 10

	validates_uniqueness_of :role, scope: [:role, :right]
end

class Grant < ActiveRecord::Base
	belongs_to :role
	belongs_to :right

	validates_uniqueness_of :role, scope: [:role, :right]
end

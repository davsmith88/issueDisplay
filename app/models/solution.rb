class Solution < ActiveRecord::Base
	belongs_to :issue
	has_many :images, as: :imageable, dependent: :destroy
end

class Location < ActiveRecord::Base
	has_one :medium, as: :imageable
	belongs_to :department_area

	validates :name, :code, presence: true

	def build
		if medium
			medium
		else
			build_medium
		end
	end
end

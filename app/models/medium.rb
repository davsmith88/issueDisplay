class Medium < ActiveRecord::Base

	belongs_to :imageable, polymorphic: true
	belongs_to :image

end

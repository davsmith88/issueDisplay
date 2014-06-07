class Image < ActiveRecord::Base

	# belongs_to :album
	belongs_to :imageable, :polymorphic => true

	
	has_attached_file :picture, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
end

class Image < ActiveRecord::Base

	# belongs_to :album
	belongs_to :imageable, :polymorphic => true

	has_attached_file :picture, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	validates :picture, presence: {
		message: "Needs to have an image file to be able to submit"
	}

	validates_attachment_content_type :picture,{content_type: /^image\/(png|gif|jpeg|jpg)/, message: "only (png/gif/jpeg) files area allowed"}
end

class Image < ActiveRecord::Base

	has_many :media
	belongs_to :location

	has_attached_file :picture, styles: {
		thumb: '100x100>',
    	square: '200x200#',
    	medium: '300x300>'
	}
	process_in_background :picture
	
	validates :picture, presence: {
		message: "Needs to have an image file to be able to submit"
	}

	validates_attachment_content_type :picture,{content_type: /^image\/(png|gif|jpeg|jpg)/, message: "only (png/gif/jpeg) files area allowed"}

	self.per_page = 5
end

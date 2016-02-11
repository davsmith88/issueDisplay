class DetailedStep < ActiveRecord::Base
	belongs_to :issue

	validates :number, presence: {message: "Step must have an index number"}
	validates :description, presence: {message: "Step must have a description"}

	validates :number, numericality: {only_integer: true, message: "Step Order must be a number"}


	# has_attached_file :image, styles: {medium: "300x300", thumb: "100x100"}, default_url: "/images/:style/missing.png"
	# validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	# has_many :medium, as: :imageable,  dependent: :destroy
	# has_many :media, as: :imageable,  dependent: :destroy
	has_one :medium, as: :imageable, dependent: :destroy

	def build
       if medium
           medium
       else
           build_medium
       end
    end
end

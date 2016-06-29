class DetailedStep < ActiveRecord::Base

	before_create :check

	belongs_to :issue

	validates :number, presence: {message: "Step must have an index number"}
	validates :description, presence: {message: "Step must have a description"}

	validates :number, numericality: {only_integer: true, message: "Step Order must be a number"}


	# has_attached_file :image, styles: {medium: "300x300", thumb: "100x100"}, default_url: "/images/:style/missing.png"
	# validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	# has_one :medium, as: :imageable, dependent: :destroy
  has_one :medium, as: :imageable
  # has_one :image, as: :imageable

	def build
       if medium
           medium
       else
           build_medium
       end
    end

    def check
    	# method checks to see whether the user is able to create the detailed steps,
    	# if not it will return false, which will NOT save the record in the database
    	puts self.issue.howTo
    	puts "______"
    	if self.issue.howTo == "false"
    		return false
    	end
    end

    # def able?
    #   if self.issue.howTo == "true"
    #     return true
    #   else
    #     return false
    #   end
    # end
end

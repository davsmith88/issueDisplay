class DetailedStep < ActiveRecord::Base

	before_create :check

	belongs_to :issue
  has_one :medium, as: :imageable

	validates :number, presence: {message: "Step must have an index number"}
	validates :description, presence: {message: "Step must have a description"}

	validates :number, numericality: {only_integer: true, message: "Step Order must be a number"}
  
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
    	if self.issue.howTo == "false"
    		return false
    	end
    end
end

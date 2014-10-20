class Step < ActiveRecord::Base

	after_initialize :init
	has_many :images, as: :imageable, validate: :true

	validates :description, presence: {message: "Description cannot be empty"}
	validates :step_order, numericality: {only_integer: true, message: "Step Order must be a number"}

	# validates_associated :images

	def init
		self.step_order ||= 0
	end
end

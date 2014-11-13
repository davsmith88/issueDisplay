class IssueWorkaround < ActiveRecord::Base
	include PublicActivity::Model
  	# tracked owner: Proc.new{ |controller, model| controller.current_user }
  	
	belongs_to :issue
	has_many :records, as: :recordable
	has_many :images, as: :imageable, dependent: :destroy

	validates :description, presence: {message: "Workaround needs to have a description"}
end

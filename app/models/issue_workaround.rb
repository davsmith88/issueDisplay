class IssueWorkaround < ActiveRecord::Base
	belongs_to :issue
	has_many :records, as: :recordable
	has_many :images, as: :imageable, dependent: :destroy
end

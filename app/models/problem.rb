class Problem < ActiveRecord::Base
	has_many :problem_issues
	has_many :issues, :through => :problem_issues

	has_many :solutions
	has_many :issue_workarounds

	has_one :item, as: :type, dependent: :destroy

	accepts_nested_attributes_for :item
end

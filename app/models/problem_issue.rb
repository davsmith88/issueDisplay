class ProblemIssue < ActiveRecord::Base
  belongs_to :problem
  belongs_to :issue
end

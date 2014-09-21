require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  # unit tests should include tests for each validation
  # tests for validations and a test for each method on the model

  # tests for associations
  should have_many(:issue_workarounds)
  should have_many(:solutions)
  should have_many(:attempted_solutions)
  should have_many(:notes)
  should have_many(:images)

  should belong_to(:department_area)
  should belong_to(:impact)
  should belong_to(:user)
  # tests for validations
  test "issue should have a name" do
  	issue = Issue.new
  	assert_not issue.save, "saved without a name to the issue"
  end
end

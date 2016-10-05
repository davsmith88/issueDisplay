module FormHelper
  def setup_user(problem)
    problem.item ||= Item.new
    problem
  end

  def setup_issue(issue)
  	issue.item ||= Item.new
  	issue
  end
end
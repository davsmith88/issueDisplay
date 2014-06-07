class AddIssueIdToIssueWorkaround < ActiveRecord::Migration
  def change
    add_column :issue_workarounds, :references, :issue
  end
end

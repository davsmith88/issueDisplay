class AddIssueIdToIssueWorkaround < ActiveRecord::Migration
  def change
    add_column :issue_workarounds, :issue_id, :integer
end
end

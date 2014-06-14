class AddIssueIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :issue_id, :integer
    add_index :notes, :issue_id
  end
end

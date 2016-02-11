class AddRelationColumnToIssues < ActiveRecord::Migration
  def change
  	add_column :detailed_steps, :issue_id, :integer
  end
end

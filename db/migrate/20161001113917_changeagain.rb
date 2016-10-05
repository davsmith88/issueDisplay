class Changeagain < ActiveRecord::Migration
  def change
  	remove_column :issues, :problem_id, :integer
  	rename_column :reviews, :issue_id, :problem_id
  end
end

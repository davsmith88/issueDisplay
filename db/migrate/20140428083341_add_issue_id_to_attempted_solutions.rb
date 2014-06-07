class AddIssueIdToAttemptedSolutions < ActiveRecord::Migration
  def change
    add_column :attempted_solutions, :issue_id, :integer
    # if adding an association, needs a coloumn relating to reference
    # if that coloumn type is an integer, than you must create an index for the coloumn
    add_index :attempted_solutions, :issue_id
  end
end

class AddViewCounterToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :view_counter, :integer
  end
end

class AddWorkaroundToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :workaround, :text
  end
end

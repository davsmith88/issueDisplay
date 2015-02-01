class AddBusinessIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :business_id, :integer
  end
end

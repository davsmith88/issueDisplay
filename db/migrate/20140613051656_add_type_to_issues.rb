class AddTypeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :i_type, :string
  end
end

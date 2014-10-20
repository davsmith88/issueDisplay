class AddAuthorToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :author, :string
  end
end

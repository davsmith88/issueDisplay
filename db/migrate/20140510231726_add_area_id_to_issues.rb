class AddAreaIdToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :area, index: true
  end
end

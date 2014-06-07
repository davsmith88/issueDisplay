class AddDeparmentIdToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :department, index: true
  end
end

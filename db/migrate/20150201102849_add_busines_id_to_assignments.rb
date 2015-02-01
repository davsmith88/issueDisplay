class AddBusinesIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :business_id, :integer
  end
end

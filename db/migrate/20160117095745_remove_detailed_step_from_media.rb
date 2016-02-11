class RemoveDetailedStepFromMedia < ActiveRecord::Migration
  def change
  	remove_column :media, :detailed_step_id
  end
end

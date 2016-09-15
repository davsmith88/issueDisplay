class ChangeNumberInDetailedSteps < ActiveRecord::Migration
  def change
  	remove_column :detailed_steps, :number
  	add_column :detailed_steps, :number, :integer
  end
end

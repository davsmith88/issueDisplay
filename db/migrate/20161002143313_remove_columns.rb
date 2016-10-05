class RemoveColumns < ActiveRecord::Migration
  def change
  	remove_column :issues, :name
  	remove_column :issues, :description
  	remove_column :issues, :department_area_id
  end
end

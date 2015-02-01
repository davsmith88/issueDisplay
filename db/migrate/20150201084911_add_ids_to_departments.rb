class AddIdsToDepartments < ActiveRecord::Migration
  def change
  	add_column :departments, :business_id, :integer
  	add_column :areas, :business_id, :integer
  	add_column :department_areas, :business_id, :integer
  end
end

class AddDepartmentAreaIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :department_area_id, :integer
  end
end

class AddNameToDepartmentAreas < ActiveRecord::Migration
  def change
    add_column :department_areas, :name, :string
  end
end

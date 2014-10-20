class ChangeTheDepartmentIdColumn < ActiveRecord::Migration
  def change
  	rename_column :issues, :DepartmentArea_id, :department_area_id
  end
end

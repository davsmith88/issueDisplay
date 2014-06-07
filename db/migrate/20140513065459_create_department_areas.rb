class CreateDepartmentAreas < ActiveRecord::Migration
  def change
    create_table :department_areas do |t|
      t.references :department, index: true
      t.references :area, index: true

      t.timestamps
    end
  end
end

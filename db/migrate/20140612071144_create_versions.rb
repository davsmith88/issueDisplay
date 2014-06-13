class CreateVersions < ActiveRecord::Migration
  def change
    add_column :versions, :department_area_name, :string
  end
end

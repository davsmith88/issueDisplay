class RenameJob < ActiveRecord::Migration
  def change
  	rename_column :jobs, :department_areas_id, :department_area_id
  end
end

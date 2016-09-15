class RenameColomn < ActiveRecord::Migration
  def change
  	rename_column :complaints, :material_number, :master_spec
  end
end

class AddNameToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :name, :string
    add_column :locations, :info, :string
  end
end

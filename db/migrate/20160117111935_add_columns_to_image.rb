class AddColumnsToImage < ActiveRecord::Migration
  def change
    add_column :images, :location, :string
    add_column :images, :description, :string

    remove_column :media, :location
    remove_column :media, :description
  end
end

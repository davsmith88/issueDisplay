class AddLocationIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :location_id, :string
    remove_column :media, :location_id
  end
end

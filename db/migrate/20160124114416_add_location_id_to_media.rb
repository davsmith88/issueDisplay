class AddLocationIdToMedia < ActiveRecord::Migration
  def change
  	add_column :media, :location_id, :string
  end
end

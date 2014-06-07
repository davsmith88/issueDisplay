class AddPolymoricImages < ActiveRecord::Migration
  def change
  	add_column :images, :imageable_type, :string
  	add_column :images, :imageable_id, :integer

  	add_index :images, :imageable_id
  	add_index :images, :imageable_type
  end
end

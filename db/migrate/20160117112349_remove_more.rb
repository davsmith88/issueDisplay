class RemoveMore < ActiveRecord::Migration
  def change
  	remove_column :media, :image_file_name
  	remove_column :media, :image_content_type
  	remove_column :media, :image_file_size
  	remove_column :media, :image_updated_at

  	remove_column :images, :imageable_type
  	remove_column :images, :imageable_id
  	remove_column :images, :album_id
  end
end

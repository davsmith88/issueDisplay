class AddIssueIdToAlbums < ActiveRecord::Migration
  def change
  	add_reference :albums, :imageable, polymorphic: true, index: true

   	remove_column :albums, :issue_id, :integer

   	add_column :images, :album_id, :integer
  end
end

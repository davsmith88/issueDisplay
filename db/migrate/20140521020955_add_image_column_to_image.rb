class AddImageColumnToImage < ActiveRecord::Migration
 def self.up
    add_attachment :images, :picture
  end

  def self.down
    remove_attachment :images, :picture
  end
end

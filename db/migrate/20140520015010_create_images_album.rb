class CreateImagesAlbum < ActiveRecord::Migration
  def change
   def self.up
    change_table :albums do |t|
      t.references :imageable, :polymorphic => true
    end
  end

  def self.down
    change_table :albums do |t|
      t.remove_references :imageable, :polymorphic => true
    end
  end
  end
end

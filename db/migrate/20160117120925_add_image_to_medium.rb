class AddImageToMedium < ActiveRecord::Migration
  def change
  	add_reference :media, :image, index: true
  end
end

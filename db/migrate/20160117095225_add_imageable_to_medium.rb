class AddImageableToMedium < ActiveRecord::Migration
  def change
  	change_table :media do |t|
  		t.references :imageable, polymorphic: true, index: true
  	end
  end
end

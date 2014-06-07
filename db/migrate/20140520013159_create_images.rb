class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :caption

      t.timestamps
    end
  end
end

class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.text :description
      t.integer :frequency
      t.text :name
      t.text :rectify
      t.boolean :internal
      t.text :material_number


      t.timestamps
    end
  end
end

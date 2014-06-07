class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end

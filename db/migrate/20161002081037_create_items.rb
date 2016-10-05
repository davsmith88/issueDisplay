class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.references :type, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

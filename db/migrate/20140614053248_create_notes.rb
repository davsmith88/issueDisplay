class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :context
      t.integer :reviewer_id
      t.string :category

      t.timestamps
    end
  end
end

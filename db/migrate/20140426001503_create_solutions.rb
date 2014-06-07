class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :issue, index: true
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end

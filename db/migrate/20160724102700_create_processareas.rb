class CreateProcessareas < ActiveRecord::Migration
  def change
    create_table :processareas do |t|
      t.references :complaint, index: true
      t.string :process_area_type

      t.timestamps
    end
  end
end

class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :description
      t.integer :step_order

      t.timestamps
    end
  end
end

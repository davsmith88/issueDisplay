class CreateDetailedSteps < ActiveRecord::Migration
  def change
    create_table :detailed_steps do |t|
      t.string :number
      t.string :description

      t.timestamps
    end
  end
end

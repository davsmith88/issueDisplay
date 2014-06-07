class CreateAttemptedSolutions < ActiveRecord::Migration
  def change
    create_table :attempted_solutions do |t|
      t.string :name
      t.text :description
      t.text :reason

      t.timestamps
    end
  end
end

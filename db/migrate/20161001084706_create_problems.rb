class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :name
      t.text :description

      t.timestamps null: false
    end

    add_reference :issues, :problem, foreign_key: true
  end
end

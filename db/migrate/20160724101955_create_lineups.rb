class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :position_number
      t.string :job_number
      t.string :master_spec
      t.string :machine

      t.timestamps
    end
  end
end

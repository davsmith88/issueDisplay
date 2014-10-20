class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :description
      t.references :department_areas, index: true

      t.timestamps
    end
  end
end

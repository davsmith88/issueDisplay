class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.text :description
      # t.string :author

      t.timestamps
    end
  end
end

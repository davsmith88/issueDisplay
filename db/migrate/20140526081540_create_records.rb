class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :recordable, polymorphic: true, index: true
      t.references :user, index: true
      t.references :issue, index: true

      t.timestamps
    end
  end
end

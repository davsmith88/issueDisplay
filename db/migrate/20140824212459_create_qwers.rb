class CreateQwers < ActiveRecord::Migration
  def change
    create_table :qwers do |t|
      t.string :name

      t.timestamps
    end
  end
end

class Change < ActiveRecord::Migration
  def change
  	remove_column :complaints, :frequency, :integer
  	add_column :complaints, :priority, :string
  end
end

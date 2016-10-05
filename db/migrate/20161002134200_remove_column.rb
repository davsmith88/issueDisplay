class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :problems, :name
  	remove_column :problems, :description
  end
end

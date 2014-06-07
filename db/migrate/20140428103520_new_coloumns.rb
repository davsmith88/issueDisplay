class NewColoumns < ActiveRecord::Migration
  def change
  	add_column :issues, :department, :string
  	add_column :issues, :area, :string
  end
end

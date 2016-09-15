class Add < ActiveRecord::Migration
  def change
  	add_column :lineups, :cust_name, :string
  end
end

class New < ActiveRecord::Migration
  def change
  	add_column :complaints, :cust_name, :string
  end
end

class AddCustToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :cust_name, :text
  end
end

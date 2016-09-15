class AddStepToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :step, :string
    remove_column :complaints, :cust_name, :string
  end
end

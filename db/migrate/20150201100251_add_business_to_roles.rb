class AddBusinessToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :business_id, :integer
  end
end

class AddPermTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :permType, :string
  end
end

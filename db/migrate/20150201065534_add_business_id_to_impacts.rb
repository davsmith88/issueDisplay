class AddBusinessIdToImpacts < ActiveRecord::Migration
  def change
    add_column :impacts, :business_id, :integer
  end
end

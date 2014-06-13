class AddImpactNameToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :impact_name, :string
  end
end

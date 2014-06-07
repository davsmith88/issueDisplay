class AddAreaImpactedToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :area_impacted, :string
  end
end

class AddImpactIdToIssues < ActiveRecord::Migration
  def change
    add_reference :issues, :impact, index: true
  end
end

class AddDetailedStepToMedia < ActiveRecord::Migration
  def change
    add_reference :media, :detailed_step, index: true
  end
end

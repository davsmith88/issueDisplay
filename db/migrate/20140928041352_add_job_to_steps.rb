class AddJobToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :job, :integer
  end
end

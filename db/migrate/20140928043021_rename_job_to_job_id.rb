class RenameJobToJobId < ActiveRecord::Migration
  def change
  	rename_column :steps, :job, :job_id
  end
end

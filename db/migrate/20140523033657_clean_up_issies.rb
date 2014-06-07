class CleanUpIssies < ActiveRecord::Migration
  def change
  	remove_column :issues, :department
  	remove_column :issues, :area
  	remove_column :issues, :department_id
  	remove_column :issues, :area_id
  	remove_column :issues, :impact_area

  	remove_column :issues, :image_file_name
  	remove_column :issues, :image_content_type
  	remove_column :issues, :image_file_size
  	remove_column :issues, :image_updated_at
  end
end

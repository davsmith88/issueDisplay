class AddReviewDateToIssues < ActiveRecord::Migration
  def change
  	add_column :issues, :review_date, :date
  end
end

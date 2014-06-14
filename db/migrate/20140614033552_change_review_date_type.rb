class ChangeReviewDateType < ActiveRecord::Migration
  def change
  	change_column :issues, :review_date, :datetime
  end
end

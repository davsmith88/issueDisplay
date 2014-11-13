class AddReviewDateToReview < ActiveRecord::Migration
  def change
  	add_column :reviews, :review_date, :datetime
  end
end

class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.text :description
      	t.timestamps
    end
    add_reference :reviews, :user, index: true
    add_reference :reviews, :issue, index: true
  end
end

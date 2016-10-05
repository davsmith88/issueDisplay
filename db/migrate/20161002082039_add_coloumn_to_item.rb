class AddColoumnToItem < ActiveRecord::Migration
  def change
    add_reference :items, :department_area, index: true, foreign_key: true
  end
end

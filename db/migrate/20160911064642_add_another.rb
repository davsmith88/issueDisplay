class AddAnother < ActiveRecord::Migration
 def up
    add_attachment :issues, :avatar
  end

  def down
    remove_attachment :issues, :avatar
  end
end

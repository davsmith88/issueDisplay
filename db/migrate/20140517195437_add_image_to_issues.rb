class AddImageToIssues < ActiveRecord::Migration
  def self.up
    add_attachment :issues, :image
  end

  def self.down
    remove_attachment :issues, :image
  end
end

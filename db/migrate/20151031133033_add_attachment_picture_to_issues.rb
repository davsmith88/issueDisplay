class AddAttachmentPictureToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :issues, :picture
  end
end

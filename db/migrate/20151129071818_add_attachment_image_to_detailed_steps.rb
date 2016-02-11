class AddAttachmentImageToDetailedSteps < ActiveRecord::Migration
  def self.up
    change_table :detailed_steps do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :detailed_steps, :image
  end
end

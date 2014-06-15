class AddReadToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :author_read, :boolean
    add_column :notes, :checked, :boolean
    add_column :notes, :version_number, :integer
  end
end

class AddPropertiesHstoreToIssue < ActiveRecord::Migration
  def change
  	enable_extension "hstore"
  	add_column :issues, :preferences, :hstore
  	add_index :issues, :preferences, using: :gin
  end
end

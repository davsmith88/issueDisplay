class AddTimestampToLineup < ActiveRecord::Migration
  def change
    add_column :lineups, :timestamp, :string
  end
end

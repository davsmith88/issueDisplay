class AddIntroToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :intro, :boolean
  end
end

class RemoveIssueworkarounds < ActiveRecord::Migration
  def change

  	drop_table :issue_workarounds

  	create_table :issue_workarounds do |t|
  		t.string :description
  		t.references :issue
  	end

  end
end

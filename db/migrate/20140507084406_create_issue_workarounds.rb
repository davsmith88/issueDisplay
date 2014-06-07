class CreateIssueWorkarounds < ActiveRecord::Migration
  def change
    create_table :issue_workarounds do |t|
      t.text :description

      t.timestamps
    end
  end
end

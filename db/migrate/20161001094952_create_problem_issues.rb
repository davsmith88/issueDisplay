class CreateProblemIssues < ActiveRecord::Migration
  def change
    create_table :problem_issues do |t|
      t.references :problem, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

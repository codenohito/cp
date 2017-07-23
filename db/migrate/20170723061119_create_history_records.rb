class CreateHistoryRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :history_records do |t|
      t.references :project, foreign_key: true
      t.datetime :moment
      t.text :body

      t.timestamps
    end
  end
end

class CreateHistoryRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :history_records do |t|
      t.references :cluster, foreign_key: true
      t.datetime :moment
      t.text :body

      t.timestamps
    end

    add_index :history_records, :moment
  end
end

class CreateTimeRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :time_records do |t|
      t.date :theday
      t.integer :amount
      t.references :nakama, foreign_key: true
      t.references :project, foreign_key: true
      t.text :comment

      t.timestamps
    end

    add_index :time_records, :theday
  end
end

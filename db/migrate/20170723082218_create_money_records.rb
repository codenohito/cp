class CreateMoneyRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :money_records do |t|
      t.datetime :moment
      t.float :amount
      t.integer :kind
      t.integer :account_id
      t.integer :category_id
      t.references :nakama, foreign_key: true
      t.references :project, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end

class CreateMoneyRecordCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :money_record_categories do |t|
      t.string :name
      t.boolean :kind

      t.timestamps
    end
  end
end

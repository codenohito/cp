class CreateMoneyAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :money_accounts do |t|
      t.string :name
      t.text :descr

      t.timestamps
    end
  end
end

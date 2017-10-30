class CreatePaymentRates < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_rates do |t|
      t.references :nakama, foreign_key: true, null: false
      t.references :project, foreign_key: true
      t.float :hour_rate, null: false
      t.float :hour_cost, null: false
      t.datetime :active_from, null: false

      t.timestamps
    end
  end
end

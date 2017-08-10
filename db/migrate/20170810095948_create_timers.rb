class CreateTimers < ActiveRecord::Migration[5.1]
  def change
    create_table :timers do |t|
      t.references :user, foreign_key: true, null: false
      t.datetime :started_at
      t.integer :seconds
      t.references :project, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end

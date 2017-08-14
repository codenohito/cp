class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :cluster, foreign_key: true
      t.string :name
      t.text :descr

      t.timestamps
    end
  end
end

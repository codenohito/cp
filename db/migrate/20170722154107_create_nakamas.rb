class CreateNakamas < ActiveRecord::Migration[5.1]
  def change
    create_table :nakamas do |t|
      t.string :name

      t.timestamps
    end
  end
end

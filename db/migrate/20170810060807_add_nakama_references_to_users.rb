class AddNakamaReferencesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :nakama, foreign_key: true
  end
end

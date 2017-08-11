class AddPermissionsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :perms, :integer
  end
end

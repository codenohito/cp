class AddOptionsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :options, :text
  end
end

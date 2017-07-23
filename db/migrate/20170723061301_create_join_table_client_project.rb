class CreateJoinTableClientProject < ActiveRecord::Migration[5.1]
  def change
    create_join_table :clients, :projects do |t|
      # t.index [:client_id, :project_id]
      # t.index [:project_id, :client_id]
    end
  end
end

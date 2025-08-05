class AddForeignKeyAndIndexToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :microposts, :users
    add_index :microposts, [:user_id, :created_at]
  end
end

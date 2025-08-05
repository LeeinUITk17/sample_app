class ChangeUserIdToBigintInMicroposts < ActiveRecord::Migration[7.0]
  def change
    change_column :microposts, :user_id, :bigint
  end
end

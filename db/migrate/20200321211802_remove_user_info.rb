class RemoveUserInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name
    remove_column :users, :address
    remove_column :users, :gender
  end
end

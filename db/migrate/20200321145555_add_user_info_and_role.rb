class AddUserInfoAndRole < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer
    add_column :users, :name, :string, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :gender, :string, null: false
    add_column :users, :age, :integer
  end
end

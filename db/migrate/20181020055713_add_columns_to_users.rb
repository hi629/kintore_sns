class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :avatar, :string
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :introduce, :text

    add_index :users, :username, unique:true
  end
end

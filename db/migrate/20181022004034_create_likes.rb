class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end

    add_index :likes, :user_id
    add_index :likes, :post_id
    add_index :likes, [:user_id, :post_id], unique: true
  end
end

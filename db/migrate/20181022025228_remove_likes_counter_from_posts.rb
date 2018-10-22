class RemoveLikesCounterFromPosts < ActiveRecord::Migration[5.1]
  def up
    remove_column :posts, :likes_counter
  end

  def down
    add_column :posts, :likes_counter, :integer
  end
end

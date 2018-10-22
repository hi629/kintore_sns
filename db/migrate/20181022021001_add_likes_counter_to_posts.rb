class AddLikesCounterToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likes_counter, :integer
  end
end

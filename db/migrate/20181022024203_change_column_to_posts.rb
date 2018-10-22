class ChangeColumnToPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_column_null :posts, :likes_counter, false, 0
  end

  def self.down
    change_column_null :posts, :likes_counter
  end
end

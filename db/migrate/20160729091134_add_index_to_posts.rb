class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :parent_id
  end
end

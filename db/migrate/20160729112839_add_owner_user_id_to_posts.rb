class AddOwnerUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :owner_user_id, :integer
  end
end

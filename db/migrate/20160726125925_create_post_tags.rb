class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.references :post, index: true
      t.references :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_tags, :posts
    add_foreign_key :post_tags, :tags
  end
end

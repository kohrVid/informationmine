class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :parent_id
      t.integer :accepted_answer_id
      t.integer :score
      t.integer :view_count
      t.text :body
      t.string :title
      t.integer :answer_count
      t.json :tags

      t.timestamps null: false
    end
  end
end

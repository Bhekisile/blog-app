class AddForeignKey < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :comments, :posts, column: :post_id
    add_foreign_key :posts, :users, column: :author_id
    add_foreign_key :likes, :users, column: :author_id
    add_foreign_key :comments, :users, column: :author_id
  end
end

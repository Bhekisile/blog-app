class RenameColumn < ActiveRecord::Migration[7.1]
  def change
        rename_column :comments, :user_id, :author_id
        rename_column :likes, :user_id, :author_id
  end
end

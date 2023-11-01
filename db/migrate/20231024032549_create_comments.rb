class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :author, foreign_key: true
      t.references :post, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end

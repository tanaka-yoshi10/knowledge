class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :article, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :stocks,[:user_id, :article_id],  unique: true
    add_index :stocks,[:article_id, :user_id],  unique: true
  end
end

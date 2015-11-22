class RemoveIndexFromStocks < ActiveRecord::Migration
  def change
    remove_index :stocks,[:article_id, :user_id]
  end
end

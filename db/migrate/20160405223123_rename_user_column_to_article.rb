class RenameUserColumnToArticle < ActiveRecord::Migration
  def change
    rename_column :articles, :user_id, :author_id
  end
end

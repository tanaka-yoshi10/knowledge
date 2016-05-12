class RenameIntroductionColumnToProfile < ActiveRecord::Migration
  def change
    rename_column :profiles, :introducion, :introduction
  end
end

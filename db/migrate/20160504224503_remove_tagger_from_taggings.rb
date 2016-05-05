class RemoveTaggerFromTaggings < ActiveRecord::Migration
  def change
    remove_column :taggings, :taggable_type, :string
    remove_column :taggings, :tagger_id, :integer
    remove_column :taggings, :tagger_type, :string
    remove_column :taggings, :context, :string
  end
end

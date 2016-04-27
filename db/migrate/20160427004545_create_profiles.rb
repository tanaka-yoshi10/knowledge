class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :blog_url
      t.string :organization
      t.string :introducion
      t.string :qiita_id

      t.timestamps null: false
    end
  end
end

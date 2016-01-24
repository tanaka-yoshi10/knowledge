class CreateTagfollows < ActiveRecord::Migration
  def change
    create_table :tagfollows do |t|
      t.references :user
      t.references :tag

      t.timestamps null: false
    end
  end
end

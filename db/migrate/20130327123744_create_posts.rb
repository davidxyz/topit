class CreatePosts < ActiveRecord::Migration
   def up
    create_table :microposts do |t|
      t.integer :user_id
      t.integer  :posttype#either top 5 top 10 top 20
      t.string  :title
      t.integer :likes, :integer, :default=>0
      t.timestamps
    end
  add_index :microposts, [:user_id, :created_at]
 end
 def down
   drop_table :microposts
 end
end

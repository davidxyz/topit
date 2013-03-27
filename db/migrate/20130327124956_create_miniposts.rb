class CreateMiniposts < ActiveRecord::Migration
   def up
    create_table :miniposts do |t|
      t.text :content
      t.string :name
      t.string :image
      t.integer :user_id
      t.integer :micropost_id
      t.integer :likes, :integer, :default=>0
      t.timestamps
    end
  add_index :miniposts, [:user_id, :created_at]
 end
 def down
   drop_table :miniposts
 end
end

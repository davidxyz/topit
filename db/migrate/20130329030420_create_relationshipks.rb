class CreateRelationshipks < ActiveRecord::Migration
  def up
    create_table :relationshipks do |t|
    t.integer :subscriber_id
    t.integer :subscribed_id
    t.string :post_ids
    t.timestamps
    end
    add_index :relationshipks, :subscriber_id
    add_index :relationshipks, :subscribed_id
    add_index :relationshipks,[:subscribed_id, :subscriber_id], :unique=>true
  end
  def down
    remove_column :microposts,:post_ids
  	drop_table :relationshipks
  end
end

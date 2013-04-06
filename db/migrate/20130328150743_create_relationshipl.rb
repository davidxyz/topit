class CreateRelationshipl < ActiveRecord::Migration
def up
    create_table :relationshipls do |t|
    t.integer :liker_id
    t.integer :liked_id
    t.string :posttype, :default=>"micropost"
    t.timestamps
    end
    add_index :relationshipls, :liker_id
    add_index :relationshipls, :liked_id
    add_index :relationshipls,[:liker_id, :liked_id,:posttype], :unique=>true
  end
  def down
  	drop_table :relationshipls
  end
end

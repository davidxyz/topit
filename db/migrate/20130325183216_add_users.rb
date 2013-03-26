class AddUsers < ActiveRecord::Migration#adds users and session tables
  def up
  	  create_table :users do |t|
      t.string :name
      t.string :email
      t.string :remember_token
      t.string :password_digest
      t.boolean :admin, :default => false
      t.timestamps
    end
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end
    add_index :sessions, :session_id
    add_index :sessions, :updated_at
    add_index :users, :email, unique: true
    add_index :users,:remember_token
  end

  def down
  	drop_table :users
  	drop_table :sessions
  end
end

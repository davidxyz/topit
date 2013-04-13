class ChangeComments < ActiveRecord::Migration
  def up
  	add_column :comments,:likes, :integer,:default=>0
  end

  def down
  	remove_column :comments,:likes
  end
end

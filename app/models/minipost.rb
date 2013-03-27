class Minipost < ActiveRecord::Base
attr_accessible :name,:content,:image,:remote_image_url,:micropost_id
mount_uploader :image, ImageUploader
belongs_to :user
belongs_to :micropost
end
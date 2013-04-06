class Minipost < ActiveRecord::Base
attr_accessible :name,:content,:image,:remote_image_url,:micropost_id
mount_uploader :image, ImageUploader
default_scope order:'miniposts.likes DESC'
belongs_to :user
belongs_to :micropost
validates :name, presence:true, length: {minimum:3,maximum: 68}
validates :content, presence:true, length: {minimum:3,maximum: 1500}
has_many :reverse_relationshipls,foreign_key: "liked_id",class_name:"Relationshipl", dependent: :destroy
 has_many :likers, through: :reverse_relationshipls,source: :liker
def imageine
	return "unknown.png" if self.image.nil?
	return self.image_url(:thumb)
end

def top?
	self.id==self.top.id
end
def top
	self.micropost.miniposts.order("likes DESC").first
end

  def inc
    self.update_attribute(:likes,likes+1)
  end
  def dec
    self.update_attribute(:likes,likes-1)
  end
end
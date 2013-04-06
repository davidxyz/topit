class Micropost < ActiveRecord::Base
attr_accessible :title,:posttype#default=>top5
acts_as_commentable
belongs_to :user
has_many :comments
has_many :miniposts
has_many :reverse_relationshipls,foreign_key: "liked_id",foreign_key:"Micropost",class_name:"Relationshipl", dependent: :destroy
 has_many :likers, through: :reverse_relationshipls,source: :liker
 has_many :reverse_relationshipks,foreign_key: "subscribed_id",class_name:"Relationshipk", dependent: :destroy
 has_many :subscribers, through: :reverse_relationshipks,source: :subscriber
  def inc
    self.update_attribute(:likes,likes+1)
  end
  def dec
    self.update_attribute(:likes,likes-1)
  end
  def self.random#returns a random post
  	posts=Micropost.all
  	posts[Random.rand(posts.count)]
  end

end

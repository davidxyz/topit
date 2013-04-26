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
  def self.calcFeed(popularity)
    case popularity
    when :popular
      Micropost.order("likes DESC")
    when :rising
      Micropost.order("likes > 3 AND likes < 10")
    when :new
      Micropost.order("likes ASC").order("created_at ASC")
    end
  end
  def top
    self.miniposts.first
  end
  def comments
    y=[]
    self.root_comments.each{|x| 
      y<<x
      y<<x.children if x.has_children?
    }
    y.flatten
  end
  def next#should refine to model it out of users feed
    Micropost.where("id > ?", id).order("id DESC").first
  end

  def prev#should refine to model it out of users feed
    Micropost.where("id < ?", id).order("id ASC").first
  end
   def self.search(search)
  if search
  x=where('title LIKE ?', "%#{search}%")  
  x=x+Minipost.where('name LIKE ? OR content LIKE ?',"%#{search}%","%#{search}%").map{|x| Micropost.find(x.micropost_id)}
  x.uniq
  else
  all
  end
  end
end

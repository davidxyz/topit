class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_many :microposts
  has_many :miniposts
  has_many :comments
  has_many :relationshipls, foreign_key: "liker_id", dependent: :destroy
  has_many :likes, through: :relationshipls, source: :liked
  has_many :relationshipks, foreign_key: "subscriber_id", dependent: :destroy
  has_many :subscribeds, through: :relationshipks, source: :subscribed
 has_secure_password
  before_save :create_remember_token
  before_save{|user| user.email=email.downcase}
  
  validates :name, presence:true, length: {minimum:3,maximum: 12},format: {with: /\A[a-zA-Z0-9_]+\z/},uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  def subscribed?(post)
   if relationshipks.find_by_subscribed_id(post.id).nil?
      return false
    else
      true
    end
  end
  def commented_on?(post)
    !Comment.where(user_id:self.id,commentable_id:post.id,commentable_type:post.class.base_class.name).first.nil?
  end
  def subscribe!(post)
    relationshipks.create!(subscribed_id: post.id)
  end
   def unsubscribe!(post)
    relationshipks.find_by_subscribed_id(post.id).destroy
  end
   def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    def liked?(post,post_type)
    !self.relationshipls.where(liked_id: post.id,posttype: post_type).first.nil?
  end
  def like!(post,post_type)
  self.relationshipls.create!(liked_id: post.id,posttype:post_type)
  end
  def hate!(post,post_type)
    self.relationshipls.where(liked_id: post.id,posttype: post_type).first.destroy
  end
   def subscriptions(choice)#things that entered the top
    count=0
    if choice==:change #issue an event change if the top 5 posts change in anyway
    subscribeds.each{|x| count+=1 unless relationshipks.find_by_subscribed_id(x.id).post_ids.split(",").map{|y| y.to_i}==x.miniposts.limit(5).map{|x| x.id}}
    elsif choice==:top #issue an event change if the top 1 post change in anyway
    subscribeds.each{|x| count+=1 unless relationshipks.find_by_subscribed_id(x.id).post_ids.split(",")[0].to_i==x.miniposts.first.id}
    end
    count
  end
  def justify(post)
    if self.subscribed?(post)
     var=""
     post.miniposts.limit(5).each{|x| var+=(x.id.to_s+",")}
     self.relationshipks.find_by_subscribed_id(post.id).update_attribute(:post_ids,var)
   end
  end
end

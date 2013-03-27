class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_many :microposts
  has_many :miniposts
  has_many :comments
 has_secure_password
  before_save :create_remember_token
  before_save{|user| user.email=email.downcase}
  
  validates :name, presence:true, length: {minimum:3,maximum: 12},format: {with: /\A[a-zA-Z0-9_]+\z/},uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
   def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

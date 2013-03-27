class Micropost < ActiveRecord::Base
attr_accessible :title,:posttype#default=>top5
acts_as_commentable
belongs_to :user
has_many :comments
has_many :miniposts
end

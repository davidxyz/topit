class Relationshipk < ActiveRecord::Base
  # attr_accessible :title, :body
  #liked_id=comment or micropost_id
  attr_accessible :subscribed_id
  belongs_to :subscriber, class_name: "User"
  belongs_to :subscribed, class_name: "Micropost"
  validates :subscribed_id, presence: true
  validates :subscriber_id, presence: true
end

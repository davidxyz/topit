module UsersHelper
  def liked_it?(user,post,posttype)
  	return false if user.nil?
  	user.liked?(post,posttype)
  end
  def subscribed_it?(user,post)
  	return false if user.nil?
  	user.subscribed?(post)
  end
end

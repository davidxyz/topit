class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remote_image_url
end

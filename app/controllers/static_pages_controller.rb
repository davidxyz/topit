class StaticPagesController < ApplicationController
	def home
		@micropost=Micropost.first
		current_user.justify(@micropost) if signed_in?
		@comments=@micropost.comment_threads
	end
	def about
	end
end
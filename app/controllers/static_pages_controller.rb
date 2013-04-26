class StaticPagesController < ApplicationController
	def home
		@microposts=Micropost.calcFeed(:popular).paginate(page: params[:page])
		@recommends=current_user.recommends if signed_in?
	end
	def about
	end
end
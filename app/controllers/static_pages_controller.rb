class StaticPagesController < ApplicationController
	def home
		@micropost=Micropost.first
	end
	def about
	end
end
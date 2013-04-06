module MicropostsHelper
	def path(post)
		'/post/'+post.id.to_s+'/'+urlify(post.title)
	end
	def urlify(title)
    URI::escape(title.split("").map{|x| if x=="\s" then "_" else x end}.join(""))
  end
end
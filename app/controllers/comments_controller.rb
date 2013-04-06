class CommentsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy,:edit]
  def increment
     @comment=Comment.find(params[:id])
      @type=current_user.liked?(@comment,"Comment")
      if @type==false #make a new relationship
        current_user.like!(@comment,"Comment")
        @comment.inc
      else
        current_user.hate!(@comment,"Comment")
        @comment.dec
      end
      respond_to do |format|
      format.json { render :json => { :valid=>true}}
      format.html { render root_path}
      end
    end
  def create#reply or make one
    if params[:parent_id].nil?
      @comment=Comment.build_from(Micropost.find(params[:micropost_id]),current_user.id,params[:body])
    else
       @comment= Comment.build_from(Comment.find(params[:parent_id]),current_user.id,params[:body]);
    end
    @micropost=Micropost.find(params[:micropost_id])
    if @comment.save
      respond_to do |format|
        format.html {redirect_to "/posts/"+@micropost.id.to_s+'/'+urlify(@micropost.title)}
        format.json {render :json => { valid: true }}
      end
    else
      respond_to do |format|
        format.html {redirect_to "/posts/"+@micropost.id.to_s+'/'+urlify(@micropost.title)}
        format.json {render :json => { valid: true,error: errors[:base] }}
      end
    end
  end
  def destroy
    @comment.destroy
    redirect_back_or root_path
  end
    def correct_user
      @comment=Comment.find(params[:id])
      redirect_to root_path if current_user?(@comment.user)==false
    end
end
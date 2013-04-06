class MinipostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy,:increment]
  before_filter :correct_user, only: :destroy
  
  #have to incoporate some type of user controls so they can get more from their fee
def increment
      @minipost=Minipost.find(params[:id])
      @type=current_user.liked?(@minipost,"Minipost")
      if @type==false #make a new relationship
        current_user.like!(@minipost,"Minipost")
        @minipost.inc
      else
        current_user.hate!(@minipost,"Minipost")
        @minipost.dec
      end
      respond_to do |format|
      format.json { render :json => { :valid=>true}}
      format.html { render root_path}
      end
    end#else someone is tamepring with he app and nothing happens
  def create
    @minipost =current_user.miniposts.build(name:params[:name],micropost_id:params[:micropost_id],content: params[:content])
    if @minipost.save!
 	  respond_to do |format|
      format.json { render :json => { :valid=>true}}
      format.html {}
      end
    else
    	respond_to do |format|
      format.json { render :json => { :valid=>false}}
      format.html {}
      end
    end
  end
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  private
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
end
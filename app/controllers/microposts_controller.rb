class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:new,:create, :destroy]
  before_filter :correct_user, only: :destroy
  
  #have to incoporate some type of user controls so they can get more from their fee
  def new
    
  end
  def create
    @micropost =current_user.microposts.build(title:params[:title],posttype: 5)
    if @micropost.save!
 	  respond_to do |format|
      format.json { render :json => { :valid=>true,:url=>@micropost.id}}
      format.html {
      flash[:success]= "Top it created!"
      redirect_to "/"
  }
      end
    else
    	respond_to do |format|
      format.json { render :json => { :valid=>false}}
      format.html {render 'new'}
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

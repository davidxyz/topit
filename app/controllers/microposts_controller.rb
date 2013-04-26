require 'will_paginate/array'
class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:new,:create, :destroy,:increment,:subscribe,:subscriptions]
  before_filter :correct_user, only: :destroy
  
  #have to incoporate some type of user controls so they can get more from their fee
  def new
    
  end
  def show
    @micropost=Micropost.find(params[:id])
    not_found if @micropost.nil?
    @comments=@micropost.comments.paginate(page: params[:page])
    current_user.justify(@micropost) if signed_in?
    @next=@micropost.next
    @prev=@micropost.prev
  end
  def subscriptions
    microposts=current_user.subscribeds
    miniposts=[]
    microposts.each{|m| miniposts<<m.miniposts.limit(5)}
    respond_to do |format|
      format.json { render :json => { :microposts=>microposts,:miniposts=>miniposts,:comments=>microposts.map{|m| m.comment_threads.count},:subscribers=>microposts.map{|m| m.subscribers.count}}}
      format.html { render root_path}
      end
  end
  def search
  microposts=Micropost.search(params[:search])
  miniposts=[]
  microposts.each{|m| miniposts<<m.miniposts.limit(5)}
  respond_to do |format|
      format.json { render :json => { :microposts=>microposts,:miniposts=>miniposts,:comments=>microposts.map{|m| m.comment_threads.count},:subscribers=>microposts.map{|m| m.subscribers.count}}}
      format.html { render root_path}
      end
  end
  def increment
      @micropost=Micropost.find(params[:id])
      @type=current_user.liked?(@micropost,"Micropost")
      if @type==false #make a new relationship
        current_user.like!(@micropost,"Micropost")
        @micropost.inc
      else
        current_user.hate!(@micropost,"Micropost")
        @micropost.dec
      end
      respond_to do |format|
      format.json { render :json => { :valid=>true}}
      format.html { render root_path}
      end
    end#else someone is tamepring with he app and nothing happens
      def subscribe
    @micropost=Micropost.find(params[:id])
    if @micropost.nil? then redirect_to "/" end
    if current_user.subscribed?(@micropost)
     current_user.unsubscribe!(@micropost)
    else
      current_user.subscribe!(@micropost)
    end
    respond_to do |format|
      format.json { render :json => { :valid=>false}}
      format.html {render '/'}
      end
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

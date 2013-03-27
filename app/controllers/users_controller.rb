class UsersController < ApplicationController
  def new
  end
  def edit
    @user=User.find(params[:id])
  end
  def show
    @user=User.find_by_name(params[:name]) unless params[:name].nil?
    @user=User.find(params[:id]) unless params[:id].nil?
    begin#no method error
    @name=@user.name
    rescue
      not_found
    end
    @followeds=@user.followed_users
    @followers=@user.followers
    result=determine_pagination(@user.microposts,if params[:page].to_i<1 or params[:page].to_i.to_s=="0" then 1 else params[:page].to_i end)
   @microposts =result[:feed]
   @medfeed_height=result[:medfeed_height]
  end
  def no_other_users#check to see if there are no other users with your name ajax
    user=User.find_by_name(params[:name])
    if user.nil? then user=false else user=true end
    respond_to do |format|
      format.json { render :json => { :user=>user}}
    end
  end
  def no_other_emails
     email=User.find_by_email(params[:email])
    if email.nil? then email=false else email=true end
    respond_to do |format|
      format.json { render :json => { :email=>email}}
    end
  end
  def create
    @user=User.new(name:params[:name],password:params[:password],email:params[:email],password_confirmation:params[:password_confirmation])
    if @user.save
      sign_in @user
      flash[:success]="welcome to Topit"
      redirect_to "/"
    else
      render 'new',:@user=>@user 
    end
  end
  def update
    #No other user check
    @user =User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end
  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end

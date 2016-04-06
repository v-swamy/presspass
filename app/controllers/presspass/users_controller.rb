class Presspass::UsersController < ApplicationController

  protect_from_forgery except: :create

  def create
    @user = User.new
    @user.email = params[:email]
    @user.device_token = params[:deviceToken]
    @user.save
    render nothing: true
  end


end
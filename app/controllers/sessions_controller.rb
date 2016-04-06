class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You've logged in!"
      redirect_to root_path
    else
      flash[:danger] = "There is something wrong with your email or password."
      redirect_to sign_in_path
    end
  end

  def create_with_presspass
    user = User.find_by(email: params[:email])
    token = redis.get(user.email)


    if user && token == params[:presspassToken]
      session[:user_id] = user.id
      flash[:success] = "You've logged in!"
      redirect_to root_path
    else
      flash[:danger] = "There is something wrong with your email or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:warning] = "You've signed out"
    redirect_to root_path
  end

  private

  def redis
    Redis.current
  end 

end
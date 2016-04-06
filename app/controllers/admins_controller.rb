class AdminsController < ApplicationController

  def new
    @user = User.new
  end

end
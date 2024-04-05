class LoginController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username].downcase)
    if @user
      if @user.authentictae(params[:user][:hashed_password])
        flash.now[:alert] = "logged in"
      else
        flash.now[:alert] = "Incorrect username or password"
      end
    else
      flash.now[:alert] = "Incorrect username or password"
    end
  end
end

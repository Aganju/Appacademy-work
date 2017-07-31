class UsersController < ApplicationController

  def new
    render :new
  end

  def show

  end

  def create
    user = User.new(user_params)
    puts user
    if user.save
      log_in_user!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def check_login
    redirect_to bands_url, status: 303 if logged_in?
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

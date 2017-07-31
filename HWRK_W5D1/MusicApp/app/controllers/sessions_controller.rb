class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:email], user_params[:password])
    if user
      log_in_user!(user)
      redirect_to bands_url
    else
      flash[:errors] = ['Incorrect credentials']
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def check_login
    redirect_to bands_url, status: 303 if logged_in?
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :check_login

  def check_login
    redirect_to(new_session_url, status: 303) unless logged_in?
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end
end

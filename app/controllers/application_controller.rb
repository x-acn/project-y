class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find_by_password_digest(session[:password_digest]) if session[:password_digest]
  end
  
  helper_method :current_user
  
end

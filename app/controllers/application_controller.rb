class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find_by_password_digest(session[:password_digest]) if session[:password_digest]
  end
  
  helper_method :current_user
  
  def require_authentication!
    #redirect_to root_url(:host => DOMAIN) unless current_user
    #flash.now[:error] = "Please log in to complete that action."
    puts "****************************"
    puts current_user.inspect
    puts session[:password_digest]
    puts session.inspect
    
    
    render_not_logged_in unless current_user
  end
  
  def ignore_non_html_request
    unless request.format.html?
      logger.info "ignoring non HTML request"
      render :nothing => true, :status => :not_found
    end
  end
  
  def render_not_logged_in
    flash.now[:error] = "Please log in to complete that action."
    render_error
  end
  
  def render_error
    render 'layouts/error'
  end
  
  def layout_path(site, page)
    "layouts/themes/#{site.theme}/#{page.layout}"
  end
  
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find_by_password_digest(session[:password_digest]) if session[:password_digest]
  end
  
  helper_method :current_user
  
  def ignore_non_html_request
    unless request.format.html?
      logger.info "ignoring non HTML request"
      render :nothing => true, :status => :forbidden
    end
  end
  
  def require_authentication!
    render_not_logged_in unless current_user
  end
  
  def render_not_logged_in
    flash.now[:error] = "Please log in to complete that action."
    render_error(:unauthorized)
  end
  
  def render_error(status=:not_found)
    render 'layouts/error', :status => status
  end
  
  def template_path(site, page)
    "layouts/themes/#{site.theme}/#{page.layout}"
  end
  
  def layout_path(site)
   "layouts/themes/#{site.theme}/base"
  end
  
end

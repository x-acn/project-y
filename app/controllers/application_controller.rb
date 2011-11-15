class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find_by_password_digest(session[:password_digest]) if session[:password_digest]
  end
  
  helper_method :current_user
  
  #TODO Move to lib?
  def require_site
    return true if current_site
    render_no_site_error and return false
  end
  
  def current_site
    @current_site || fetch_site
  end
  
  def fetch_site
    Rails.log "[fetch site] host = #{request.host} / #{request.env['HTTP_HOST']}"
    Site.find_by_domain(request.host)
  end
  
  def render_no_site_error
    ##TODO Create this error template
    render :template => '/admin/errors/no_site', :layout => false, :status => :not_found
  end

#  def validate_site_membership
#    return true if current_site.present? && current_site.accounts.include?(current_admin)

#    sign_out(current_admin)
#    flash[:alert] = I18n.t(:no_membership, :scope => [:devise, :failure, :admin])
#    redirect_to new_admin_session_url and return false
#  end
  
end

class PagesController < ApplicationController
  
  before_filter :ignore_non_html_request, :except => [:update]
  before_filter :require_authentication!, :except => [:show]  
  before_filter :require_site_auth, :except => [:show]
  before_filter :require_site, :only => [:show]
  before_filter :fetch_page, :only => [:show, :edit, :update]
  
#  def create
#    #@page = current_site.pages.new()
#  end
#  
#  def new
#    @page = current_site.pages.new
#  end
  
  def show
    ##TODO browser cache
    render :text => @page.raw, :layout => false
  end
  
  def edit
    @edit = true
    render template_path(current_site, @page), :layout => layout_path(current_site)
  end
  
  def update
    @page.contents = params[:contents] || {}
    render_and_save
    render :text => 'Saved'
  end
  
  private
  
  def render_and_save
    @page.raw = render_to_string template_path(current_site, @page), :layout => layout_path(current_site)
    @page.save
  end
  
  #TODO Move to module/lib?
  def fetch_page
    slug = params[:slug]
    query = if slug.blank?
      logger.info "[fetch page] default page for site_id = #{current_site.id}"
      {:default => true}
    else
      logger.info "[fetch page] slug = #{slug} and site_id = #{current_site.id}"
      {:slug => slug}
    end
    @page = current_site.pages.where(query).limit(1).first
    
    if @page.nil?
      if !slug.blank?
        logger.info "[fetch page] failed to load page with slug = #{slug}"
        #redirect in order to show the user the url of actual page being returned
        if request.xhr?
          render :text => 'Page not found', :status => :not_found
        else
          redirect_to show_page_path, :notice => "The page with #{slug} path could not be found"
        end
      else
        logger.info "[fetch page] failed to load a page with default=true. Loading first page"
        @page = current_site.pages.first
        
        if !@page.nil?
          @page.default = true
          @page.save
        else
          logger.info "[fetch page] no pages for site. redirecting to 'new'"
          #redirect_to new_page_path ##TODO
        end
      end
    end
  end
  
  def require_site_auth
    require_site(current_user)
  end
  
  def require_site(user=nil)
    return true if current_site(user)
    render_no_site_error and return false
  end
  
  def current_site(user=nil)
    @current_site ||= fetch_site(user)
  end
  
  def fetch_site(user)
    if user
      logger.info "[fetch site] where user_id = #{user.id}"
      user.site
    else
      logger.info "[fetch site] with host = #{request.host}" # / #{request.env['HTTP_HOST']}"
      Site.find_by_domain(request.host)
    end
  end
  
  def render_no_site_error
    flash.now[:error] = "We're sorry but we couldn't find a site configured with the domain '#{request.host}'."
    render 'layouts/error', :status => :not_found
  end
  
  helper_method :current_site
  
end

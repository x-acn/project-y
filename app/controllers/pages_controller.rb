class PagesController < ApplicationController
  
  before_filter :ignore_non_html_request, :except => [:update]
  before_filter :require_authentication!, :except => [:show]  
  before_filter :require_site_auth, :except => [:show]
  before_filter :require_site, :only => [:show]
  before_filter :fetch_page, :only => [:show, :edit, :update]
  ##TODO csrf and auth check on update
  
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
    render :inline => '', :layout => layout_path(current_site, @page)
  end
  
  def update
    @page.contents = params[:contents] || {}
    render_and_save
    render :text => 'Saved'
  end
  
  private
  
  def render_and_save
    #@meta_title = "Hello" #"#{@page.meta_title} - #{@cfg.site_page_title}".truncate(70, :omission => '')
    #@meta_description = "Hello World" #{@page.meta_description}".truncate(140, :omission => '')
    #@meta_keywords = "Meta Keywords" #"#{@page.meta_keywords}"
    @page.raw = render_to_string :inline => '', :layout => layout_path(current_site, @page)
    @page.save
  end
  
  #TODO Move to module/lib?
  def fetch_page
    slug = params[:slug]
    query = if slug.blank?
      logger.info "[fetch page] default page"
      {:default => true}
    else
      logger.info "[fetch page] slug = #{slug}"
      {:slug => slug}
    end
    @page = current_site.pages.where(query).limit(1).first
    
    if @page.nil?
      if !slug.blank?
        logger.info "[fetch page] Failed to load page with slug = #{slug}"
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
      logger.info "[fetch user site for edit]"
      user.site
    else
      logger.info "[fetch site] host = #{request.host}" # / #{request.env['HTTP_HOST']}"
      Site.find_by_domain(request.host)
    end
  end
  
  def render_no_site_error
    flash.now[:error] = "We're sorry but we couldn't find a site configured with the domain '#{request.host}'."
    render 'layouts/error', :status => :not_found
  end
  
end

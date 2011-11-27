class PagesController < ApplicationController
  
  before_filter :ignore_non_html, :except => [:update]
  before_filter :require_site
  before_filter :fetch_page, :only => [:show, :edit, :update]
  ##TODO csrf and auth check on update
  
  def create
    #@page = current_site.pages.new()
  end
  
  def new
    @page = current_site.pages.new
  end
  
  def show
    ##TODO browser cache
    render :text => @page.raw, :layout => false
  end
  
  def edit
    @edit = true
    render :nothing => true, :layout => @page.layout
  end
  
  def update
    @page.contents = params[:contents] || {}
    rerender_and_save
    render :text => 'Saved'
  end
  
  private
  
  
  def ignore_non_html
    unless request.format.html?
      logger.info "ignoring non HTML request"
      render :nothing => true, :status => :not_found
    end
  end
  
  ##TODO Move to Page model
  def rerender_and_save
    #@meta_title = "Hello" #"#{@page.meta_title} - #{@cfg.site_page_title}".truncate(70, :omission => '')
    #@meta_description = "Hello World" #{@page.meta_description}".truncate(140, :omission => '')
    #@meta_keywords = "Meta Keywords" #"#{@page.meta_keywords}"
    rerender
    @page.save
  end
  
  ##TODO Move to Page model
  def rerender
    ##TODO Discussion Point: Should re-rendering a previously rendered page be done from the template or from the existing raw text
    @page.raw = render_to_string :layout => @page.layout
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
          render :nothing => 'Page not found', :status => :not_found
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
  
  def require_site
    return true if current_site
    render_no_site_error and return false
  end
  
  def current_site
    @current_site ||= fetch_site
  end
  
  def fetch_site
    #puts root_path
    #puts root_url
    #if request.host == DOMAIN || request.host == "localhost"
    #  redirect_to root_path
    #  return true
    #end
    logger.info "[fetch site] host = #{request.host}" # / #{request.env['HTTP_HOST']}"
    Site.find_by_domain(request.host)
  end
  
  def render_no_site_error
    logger.info "in render no site error"
    ##TODO Create this error template and make it look nice and fix the words
    render :inline => "<div><h2>We're sorry but we couldn't find the site for #{request.host}.</h2></div>", :layout => true, :status => :not_found
  end
  
end

class PagesController < ApplicationController
  
  before_filter :require_site
  
  def show
    slug = params[:slug].to_s
    query = slug.empty? ? {:default => true} : {:slug => slug}
    @page = current_site.pages.where(query).first
    
    if @page.nil? && !slug.to_s.blank?
      redirect_to default_path, :notice => "The page with #{slug} path could not be found"
      return true
    elsif @page.nil?
      ##TODO implement acts_as_list or tree to have the user order the pages (needed for nav)
      @page = @site.pages.first
    end
    
    ##TODO browser cache
    render :text => @page.raw, :layout => false
  end
  
  
  def update
    html = render_to_string :nothing => true, :layout => "layouts/fixed-width-12"
    #@meta_title = "Hello" #"#{@page.meta_title} - #{@cfg.site_page_title}".truncate(70, :omission => '')
    #@meta_description = "Hello World" #{@page.meta_description}".truncate(140, :omission => '')
    #@meta_keywords = "Meta Keywords" #"#{@page.meta_keywords}"
    #render :layout => Layout.find(@site.theme, @page.layout_name).path
  end
  
  
  private
  
  #TODO Move to module/lib?
  def require_site
    return true if current_site
    render_no_site_error and return false
  end
  
  def current_site
    @current_site ||= fetch_site
  end
  
  def fetch_site
    logger.info "[fetch site] host = #{request.host} / #{request.env['HTTP_HOST']}"
    if request.host == DOMAIN 
      redirect_to main_index_path
      return true
    end
    Site.find_by_domain(request.host)
  end
  
  def render_no_site_error
    ##TODO Create this error template and make it look nice and fix the words
    render :inline => "<div><h2>We're sorry but we couldn't find the site for #{request.host}.</h2></div>", :layout => true, :status => :not_found
  end
  
end

class SitesController < ApplicationController
  
  before_filter :require_authentication!
  before_filter :force_one_site, :only => [:new, :create]
  
  def new
    @site = current_user.build_site
  end
  
  def create
    site = current_user.build_site(params[:site])
    site.title = 'Site' unless site.title
    site.subdomain = current_user.slug
    site.theme = 'bootstrap'
    site.save
    
    page = site.pages.create(:title => 'Home', :layout => "header_main_side")
    page.slug = 'home'
    page.default = true
    page.save
    
    redirect_to edit_page_url(:host => "#{site.subdomain}.#{DOMAIN}")
  end
  
  private
  
  def force_one_site
    if current_user.site
      redirect_to root_url, :flash => {:error => 'You already have a site'} ##TODO decide on where to really send them
    end
  end
  
end

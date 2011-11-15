class PagesController < ApplicationController
  
  before_filter :require_site
  
  def show
    @page = Page.find(params[:id])
  end
  
end

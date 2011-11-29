class TemplatesController < ApplicationController
  
  respond_to :json
  
  def index
    @templates = Template.all
    respond_with @templates
  end
  
end

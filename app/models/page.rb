class Page < ActiveRecord::Base

  ## Non-Mass-Assignment Attributes: site, slug, default
  ## Mass-Assignment Attributes ##
  attr_accessible :title, :raw, :contents, :layout
  serialize :contents
  
  ## Associations ##
  belongs_to :site
  
  ## Validations ##
  validates_presence_of :site
  validates_presence_of :title
  validates_presence_of :slug
  ##TODO slug validation with regex
  ##TODO slug uniqueness withing scope of site
  
  ## Callbacks ##
  
  ## Instance Methods ##
#  def layout_path
#    "layouts/themes/#{self.site.theme}/#{self.layout}"
#  end
#  
  
  ## Singleton Methods ##
#  def self.find_by_title(title)
#    Page.where(:title => title)
#  end
#  
end

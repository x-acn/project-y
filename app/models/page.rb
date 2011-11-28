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
  validates_uniqueness_of :slug, :scope => :site_id
  
  ## Callbacks ##
  
  
  ## Instance Methods ##
  def slug=(new_slug)
    write_attribute(:slug, new_slug.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-'))
  end
  
  ## Singleton Methods ##
#  def self.find_by_title(title)
#    Page.where(:title => title)
#  end
#  
end

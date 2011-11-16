class Page < ActiveRecord::Base

  ## Editable Attributes ##
  attr_accessible :title, :raw
  
  ## Associations ##
  belongs_to :site
  
  ## Validations ##
  validates_presence_of :site
  validates_presence_of :title
  
  ## Singleton Methods ##
#  def self.find_by_title(title)
#    Page.where(:title => title)
#  end
#  
end

class Page < ActiveRecord::Base

  ## Editable Attributes ##
  attr_accessible :title
  
  ## Associations ##
  belongs_to :site
  
  ## Validations ##
  validates_presence_of :site
  validates_presence_of :title
  
end

class Domain < ActiveRecord::Base
  
  ## Editable Attributes ##
  attr_accessible :domain
  
  ## Associations ##
  belongs_to :site
  
  ## Validations ##
  validates_presence_of :site
  validates_presence_of :domain #TODO domain regex
end

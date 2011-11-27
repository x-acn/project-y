class Domain < ActiveRecord::Base
  
  ## Editable Attributes ##
  attr_accessible :domain
  
  ## Associations ##
  belongs_to :site
  
  ## Validations ##
  validates_presence_of :site
  validates_presence_of :domain
  validates_format_of :domain, :with => /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  ## Callabacks ##
  before_save :downcase
  
  ## Instance Methods ##
  def downcase
    self.domain.downcase!
  end
  
end

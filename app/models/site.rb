class Site < ActiveRecord::Base
  
  ## Editable Attributes ##
  # None
  
  ## Associations ##
  has_many :domains, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  ## Validations ##
  ## TODO discuss which standard to use (old vs new)
  validates_presence_of :subdomain #TODO subdomain regex
  
  def self.find_by_domain(domain)
    
  end
  
end

class Site < ActiveRecord::Base
  
  has_many :domains, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  ## TODO discuss which standard to use
  ## TODO regex here for better subdomain check
  validates_presence_of :subdomain
  
  def self.find_by_domain(domain)
    
  end
  
end

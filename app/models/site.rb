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
    domain = domain.downcase
    if domain.end_with?(DOMAIN) and not DOMAIN.empty?
      subdomain = domain.chomp(".#{DOMAIN}")
      Site.where(:subdomain => subdomain).limit(1).first
    else
      Domain.where(:domain => domain).includes(:site).limit(1).first.try(:site)
    end
  end
  
end

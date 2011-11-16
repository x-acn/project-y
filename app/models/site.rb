class Site < ActiveRecord::Base
  
  ## Editable Attributes ##
  attr_accessible :theme
  
  ## Associations ##
  has_many :domains, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  ## Validations ##
  ## TODO discuss which standard to use (old vs new)
  validates_presence_of :subdomain #TODO subdomain regex
  
  def self.find_by_domain(domain)
    domain = domain.downcase
    if domain.end_with?(DOMAIN) && !DOMAIN.blank?
      subdomain = domain.chomp(".#{DOMAIN}")
      #if subdomain
      ## TODO put the list of reserved subdomains in config
#      if ["www"].include? subdomain
#        redirect_to main_index_path and return true
#      end
      Site.where(:subdomain => subdomain).limit(1).first
    else
      Domain.where(:domain => domain).includes(:site).limit(1).first.try(:site)
    end
  end
  
end

class Site < ActiveRecord::Base
  
  ## Editable Attributes ##
  attr_accessible :theme
  
  ## Associations ##
  belongs_to :user
  has_many :domains, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  ## Validations ##
  validates_presence_of :user
  validates_presence_of :subdomain #TODO subdomain regex
  
  ## Callbacks ##
  before_create :downcase_subdomain
  
  ## Instance Methods ##
  def downcase_subdomain
    self.subdomain.downcase!
  end
  
  ## Singleton Methods ##
  def self.find_by_domain(domain)
    domain = domain.downcase
    if domain.end_with?(DOMAIN) && !DOMAIN.blank?
      subdomain = domain.chomp(".#{DOMAIN}")
      #if subdomain
      ## TODO put the list of reserved subdomains in config
      #if ["www"].include? subdomain
      #  redirect_to main_index_path and return true
      #end
      Site.where(:subdomain => subdomain).limit(1).first
    else
      Domain.where(:domain => domain).includes(:site).limit(1).first.try(:site)
    end
  end
  
end

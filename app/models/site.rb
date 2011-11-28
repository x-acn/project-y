class Site < ActiveRecord::Base
  
  ## Non-mass-assignment Attributes: user, subdomain
  ## Mass-Assignment Attributes ##
  attr_accessible :theme, :title
  
  ## Associations ##
  belongs_to :user
  has_many :domains, :dependent => :destroy
  has_many :pages, :dependent => :destroy
  
  ## Validations ##
  validates_presence_of :user
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
  
  ## Callbacks ##
  before_create :downcase_subdomain
  
  ## Instance Methods ##
  def downcase_subdomain
    self.subdomain.downcase!
  end
  
  ## Singleton Methods ##
  def self.find_by_domain(domain)
    domain = domain.downcase
    if domain.end_with?(Config::DOMAIN)
      subdomain = request.subdomain #domain.chomp(".#{Config::DOMAIN}")
      Site.where(:subdomain => subdomain).limit(1).first
    else
      Domain.where(:domain => domain).includes(:site).limit(1).first.try(:site)
    end
  end
  
end

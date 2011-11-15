class Domain < ActiveRecord::Base
  attr_accessible :domain
  belongs_to :site
  validates_presence_of :site
end

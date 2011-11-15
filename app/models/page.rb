class Page < ActiveRecord::Base
  attr_accessible :title
  belongs_to :site
  validates_presence_of :site
  validates_presence_of :title
end

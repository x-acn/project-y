class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create, :message => "can't be blank"
  validates_format_of :email, :with => /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/, :on => :create, :message => "is invalid"
end

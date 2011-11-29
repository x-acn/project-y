if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source :rubygems

gem 'rails', '3.1.3'
#gem 'pg'
# gem 'sorcery'
gem 'jquery-rails', '~>1.0.17'
gem 'bcrypt-ruby', '~>3.0.1' # To use ActiveModel has_secure_password

group :production do
  gem 'pg'
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass', '~> 0.12.alpha'
  gem 'compass-bootstrap', :git => "git://github.com/r-murphy/compass-bootstrap.git"
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :development do
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
  gem 'factory_girl_rails'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl_notify'
end


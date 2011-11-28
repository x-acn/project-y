source :rubygems 

gem 'rails', '3.1.1'
#gem 'pg'
# gem 'sorcery'

gem 'jquery-rails', '1.0.17'
#gem 'tinymce-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass', '~> 0.12.alpha'
  gem 'compass-bootstrap' #, :git => "git://github.com/r-murphy/compass-bootstrap.git"
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
  # remove options from below before heroku
  #gem 'rb-fsevent' , :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
  gem 'factory_girl_rails'
end

group :production do
   gem 'pg', '0.11.0'
   #igem 'thin'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.0.1' #'~>3.0.1'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


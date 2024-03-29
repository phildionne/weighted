source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'pg'
gem 'activerecord-postgres-hstore'
gem 'thin'
gem 'foreman'
gem 'devise'
gem 'omniauth-twitter'
gem 'high_voltage'
gem 'flutie'
gem 'friendly_id'
gem 'simple_form'
gem 'sanitize'
gem 'addressable'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'asset_sync'
end

group :production do
  gem 'exception_notification', github: 'smartinez87/exception_notification'
end

group :development do
  gem 'quiet_assets'
  gem 'bullet'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'debugger'
  gem 'simplecov', :require => false
  gem 'sqlite3'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'spork-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-spork'
  gem 'rb-fsevent'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers'
  gem 'i18n-spec'
  gem 'guard-brakeman'
  gem 'awesome_print'
  gem 'faker'
end

group :profiling do
  gem 'ruby-prof'
end

gem 'jquery-rails'

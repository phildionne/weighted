source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'pg'
gem 'activerecord-postgres-hstore'
gem 'thin'
gem 'foreman'
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'omniauth-twitter'
gem 'high_voltage'
gem 'flutie'
gem 'friendly_id', github: 'FriendlyId/friendly_id'
gem 'simple_form'
gem 'sanitize'
gem 'addressable'

gem 'rails-observers'
gem 'protected_attributes'

gem 'less-rails'
gem 'therubyracer', platforms: :ruby
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'asset_sync'

gem 'jquery-rails'
gem 'turbolinks'

group :production do
  gem 'exception_notification', github: 'smartinez87/exception_notification'
end

group :development, :test do
  gem 'debugger'
  gem 'simplecov', :require => false
  gem 'sqlite3'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'awesome_print'
  gem 'faker'
end

group :development do
  gem 'quiet_assets'
  gem 'bullet'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'guard-brakeman'
  gem 'i18n-spec'
  gem 'rspec-rails'
  # gem 'spork-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-spork'
  gem 'rb-fsevent'
  gem 'database_cleaner'
end

group :profiling do
  gem 'ruby-prof'
end

gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

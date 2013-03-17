source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'thin'
gem 'devise'
gem 'omniauth-twitter'
gem 'high_voltage'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'debugger'
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
  gem 'awesome_print'
  gem 'faker'
end

group :profiling do
  gem 'ruby-prof'
end

gem 'jquery-rails'

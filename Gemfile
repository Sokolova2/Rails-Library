# frozen_string_literal: true

source 'https://rubygems.org'

gem 'cssbundling-rails'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 8.0.2'
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'
gem 'kaminari'
gem 'kaminari-mongoid'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem 'kamal', require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem 'thruster', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem 'rubocop-rails-omakase', require: false

  gem 'rspec-rails'
end

group :development do
  gem 'html2haml'
  gem 'web-console'

  gem 'rubocop'
  gem 'rubocop-haml'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'devise'

gem 'omniauth'

gem 'omniauth-google-oauth2'

gem 'omniauth-rails_csrf_protection', '~> 1.0'

gem 'haml-rails'
gem 'mongoid'

gem 'dotenv', groups: %i[development test]

gem 'bootstrap'
gem 'bootstrap_icons_rails'
gem 'jquery-rails'

gem 'carrierwave', '~> 3.0'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'mini_magick'
gem 'rails-bootstrap-tabs', '~> 0.3.4'
gem 'stimulus-rails'
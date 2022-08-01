source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

## Environment
gem 'dotenv-rails', require: 'dotenv/rails-now', github: "majioa/dotenv"

gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.6.1'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Use SCSS for stylesheets

## Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.2'

# js
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.5'
gem 'oj'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'tzinfo-data'

# API
# gem 'tiun', path: '../tiun'
# gem 'tiun', github: 'majioa/tiun'

# auth
gem 'devise'
gem 'omniauth'

# mailing / required
gem 'net-smtp'
gem 'net-pop'
gem 'net-imap'

# pagination
gem 'kaminari', '>= 1.1.1'

# caching
## Use Redis adapter to run Action Cable in production
## cache, session, rack / json, with usage delayed_jobs
gem 'hiredis', '~> 0.6'
gem 'redis', '~> 4.0', require: %w(redis redis/connection/hiredis)
gem 'redis-rails', '~> 5.0'
gem 'redis-rack-cache'
gem 'redis-namespace'
gem 'jsonize'
gem 'redisize', '~> 0.1.1'
#gem 'jsonize', path: '/usr/local/home/majioa/git/jsonize'
# gem 'redisize', path: '/usr/local/home/majioa/git/redisize'
gem 'snappy'
gem 'sidekiq', ">= 6.4.0", "< 6.5.0", require: %w(sidekiq sidekiq/web)
gem 'sidekiq-worker-killer'
gem 'sidekiq-limit_fetch'

# database
gem 'activerecord-postgres-array', path: '/usr/local/home/majioa/git/activerecord-postgres-array'

group :development, :test do
   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
   gem 'pry-byebug'
   # gem 'rspec'
   gem 'shoulda-matchers-cucumber', '>= 1.0.1'
   gem 'cucumber-rails', require: false
   gem 'database_rewinder'
   gem 'factory_bot'
   gem 'faker'
   gem 'ffaker'
end

group :development do
   # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
   gem 'web-console', '>= 3.3.0'
   gem 'listen', '>= 3.0.5', '< 3.2'
   # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
   gem 'spring'
   gem 'spring-watcher-listen', '~> 2.0.0'
   gem 'capistrano', '~> 3.17'
   gem 'capistrano-rails', '~> 1.6'
   gem 'capistrano3-nginx', git: 'https://github.com/treenewbee/capistrano3-nginx.git'
   gem 'capistrano-bundler'
   gem 'capistrano-rvm'
   gem 'capistrano-systemd-multiservice', require: false, git: 'https://github.com/majioa/capistrano-systemd-multiservice.git'
   gem 'ed25519', '~> 1.2'
   gem 'bcrypt_pbkdf', '~> 1.0'
end

group :test do
   # Adds support for Capybara system testing and selenium driver
   gem 'capybara', '>= 2.15'
   gem 'selenium-webdriver'
   # Easy installation and use of chromedriver to run system tests with Chrome
   gem 'chromedriver-helper'
end

group :production do
   gem "sentry-ruby"
   gem "sentry-rails"
   gem 'sentry-sidekiq'
   gem 'rack-cors', require: 'rack/cors'
end

source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '>= 2.7', '< 4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 5.6'
gem 'puma_worker_killer'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

gem 'cssbundling-rails'
gem 'propshaft'

gem 'turbo-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'activerecord-import'
gem 'oanda_api'

gem 'resque'
gem 'resque-scheduler'

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'erb_lint', require: false
  gem 'rubocop-minitest', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.3'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'minitest-ci'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
  gem 'webdrivers'
end

group :itamae do
  gem 'god'
  gem 'itamae'
end

source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '>= 2.5', '< 2.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
gem 'puma_worker_killer'
gem 'sys-proctable', platforms: [:mingw, :mswin, :x64_mingw]
# Use SCSS for stylesheets
gem 'sassc-rails'

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass', '>= 3.4.1'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'momentjs-rails', '>= 2.9.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'minitest-ci'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :itamae do
  gem 'god'
  gem 'itamae'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'activerecord-import'
gem 'oanda_api'

gem 'resque'
gem 'resque-scheduler'

source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '4.1.8'
#gem 'rails', '4.2.0'
gem 'rails'
# Use sqlite3 as the database for Active Record
#gem 'mysql2', '~> 0.3.18'  
gem 'mysql2'  

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'
gem "haml-rails", "~> 0.9"

# Use SCSS for stylesheets
# gem 'sass-rails', '~> 4.0.3'
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
# gem 'uglifier', '>= 1.3.0'
gem 'uglifier'
# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

#gem 'will_paginate', '~> 3.0.6'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
gem 'jbuilder'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'axlsx_rails'

gem 'pry'
gem 'pry-rails'

gem 'kaminari'
# gem 'passenger'
# gem 'localtunnel'

gem 'nokogiri', require: false
gem 'mechanize', require: false

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', '~>1.3.6',        group: :development
gem 'web-console', '~> 2.0',    group: :development

#gem 'wice_grid', '3.4.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-rbenv'
gem 'capistrano-unicorn-nginx', '~> 2.0'
gem 'capistrano-npm'

# Use the Unicorn app server

gem 'unicorn'


group :test do
  gem 'factory_girl'
  gem "factory_girl_rails", "~> 4.0"
  gem 'rspec-rails', '~> 3.0'
end

group :production do
end

# Use debugger
gem 'byebug' , group: [:development, :test]

gem 'schema_to_scaffold'

gem 'jquery-ui-rails'

gem 'devise'
gem "select2-rails"

gem "browserify-rails"

gem 'react-rails'
# gem 'lodash-rails'

# custom validations
gem "schema_validations"

# workers for select exports
gem 'redis'
gem "resque"

gem 'simple_form'

group :development do
  gem 'traceroute'
  # gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'rails_best_practices'
  gem 'rubocop', require: false
  gem "rubycritic", :require => false
end

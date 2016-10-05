source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '4.0.13'
# gem 'rails', '4.1.16'
gem 'rails', '4.2.7.1'

gem 'delayed_job_active_record'
# gem "delayed_paperclip"

# May not need the responders gem ... have to find out 
gem 'responders', '~> 2.0' 


gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'


# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# postgres for the database (persistance layer)
gem 'pg', '0.18.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.5.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'devise'
gem 'paperclip'
# gem 'paperclip', github: 'thoughtbot/paperclip'
gem 'paperclip-av-transcoder'

gem 'thin'

gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'
gem 'rails_best_practices'

# gem 'sweet-alert'
# gem 'sweet-alert-confirm'

# gem 'active_model_serializers'

# gem "bullet", :group => "development"

gem 'cancancan', '~> 1.10'

gem 'jquery-turbolinks'

# gem 'state_machine'
gem 'state_machine', github: 'seuros/state_machine'

gem 'public_activity'
gem 'paper_trail', '~> 3.0.2'

 # gem 'faker'
 gem 'test-unit'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# group :production do
#   gem 'rails_12factor'
# end

group :development do
  gem "letter_opener"
  gem 'quiet_assets'
  gem 'brakeman', :require => false
  gem "better_errors"
  gem "binding_of_caller"
  gem "awesome_print"
  gem 'meta_request'
  # gem 'jazz_hands'
  # gem "lograge"
  # gem 'quiet_assets'
  gem 'awesome_print'
gem 'rails_semantic_logger'
end

group :development, :test do
  # gem 'rspec-rails', '2.13.1'
	# gem 'rspec-rails', '2.13.1'
  gem 'rspec-rails', '3.5'
	 gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_girl_rails'
  # gem "rails_best_practices"
end

group :test do
  gem 'selenium-webdriver'
  gem "chromedriver-helper"
  gem 'capybara'
  # gem 'shoulda'
  # gem 'shoulda-context'
  gem 'faker'
  gem 'database_cleaner'
  gem 'simplecov', :require => false, :group => :test
  gem 'launchy', '~> 2.4.3'
  # gem 'launchy'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# gem 'rails_12factor', group: :production
ruby "2.3.0"
source 'http://rubygems.org'

#Rails core
gem 'rails', '4.0.0'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem "therubyracer"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

#servers
gem 'pg'
gem 'sidekiq'
gem 'unicorn'
gem 'redis'
gem 'sinatra', require: false
gem 'slim'

#UI - added
gem 'devise'
gem 'will_paginate'
gem 'simple_form'
gem 'nested_form'
gem 'figaro'
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'rmagick'
gem 'jquery-ui-rails'
gem 'RedCloth'

#bootstrap stuff
gem "less-rails"
gem 'will_paginate-bootstrap'
#gem "twitter-bootstrap-rails"
#gem 'bootstrap-datepicker-rails'
gem 'skeuocard-rails'

#general
gem 'cancan'
gem "rest-client", :require => 'rest_client'
gem 'mailman', :require => false
gem 'state_machine'
gem 'ancestry'

#3rd party access
gem 'activemerchant'
gem "fog"
gem "unf"

#Testing and dev
group :test, :development do
  gem "rspec-rails"
  gem 'pry'
  gem 'pry-debugger'
  gem 'rb-inotify', :require => false
  gem 'ruby-prof'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
 #  gem 'faker'
	# gem "factory_girl_rails"
  gem "capybara"
  gem 'guard-rspec', require: false
  gem "rb-fsevent"
  gem 'rb-readline', '~> 0.4.2' #for guard readline errors https://github.com/pry/pry/issues/921
  gem 'railroady'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#TEMPORARY for seeding
gem 'faker'
gem "factory_girl_rails"

# Use unicorn as the app server
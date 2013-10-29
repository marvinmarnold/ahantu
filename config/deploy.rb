require "dotenv/capistrano"

# set :stages, %w(lixele ahantu staging)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'

set :rvm_ruby_string, :local        # use the same ruby as used locally for deployment
set :use_sudo, false # To install rvm on system.
set :rvm_type, :system
set :rvm_autolibs_flag, :enable
set :rvm_install_with_sudo, true

server "www.ahantu.com", :web, :app, :db, primary: true
set :branch, "master"

before 'deploy:install', 'rvm:install_rvm'  # update RVM
before 'deploy:install', 'rvm:install_ruby' # install Ruby and create gemset (both if missing)

require "rvm/capistrano"
require 'bundler/capistrano'

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/redis"
load "config/recipes/check"

set :application, "ahantu"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache

set :bundle_without, [:development, :test]

set :scm, "git"
set :repository, "git@github.com:marvinmarnold/ahantu.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "seed:fake"
before "seed:fake", "copy_environment"

namespace :seed do
  desc "Seed db with fake data"
  task :fake, roles: :web do
  	run("cd #{deploy_to}/current && bundle exec rake db:reset RAILS_ENV=production")
  end
end

# namespace :brand do
	desc "copy over environment variables"
  task :copy_environment, roles: :web do
    upload("public/tempindex.html", "#{deploy_to}/current/public/index.html", :via => :scp)
    # upload(".env.production", "#{deploy_to}/current/.env.production", :via => :scp)
  end
# end

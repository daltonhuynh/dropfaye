require "bundler/capistrano"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :application, "dropfaye"
set :scm, "git"
set :user, "ubuntu"
set :repository,  "git@github.com:huydalton/dropfaye.git"
set :branch, "master"

set :deploy_to, "~/apps/#{application}"
set :deploy_via, :remote_cache
set :rails_env, :production
set :current_path, "#{deploy_to}/current"

# add nginx later
role :app, "ec2-23-21-32-47.compute-1.amazonaws.com"

environment = 'production'

after "deploy:restart", "deploy:cleanup"

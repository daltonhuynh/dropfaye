# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require "rvm/capistrano"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user  # Don't use system-wide RVM

set :application, "dropfaye"
set :scm, "git"
set :user, "ubuntu"
set :repository,  "git@github.com:huydalton/dropfaye.git"
set :branch, "master"
set :use_sudo, false

set :deploy_to, "~/apps/#{application}"
set :deploy_via, :remote_cache
set :rails_env, :production
set :current_path, "#{deploy_to}/current"

# add nginx later
role :app, "ec2-23-21-48-173.compute-1.amazonaws.com"

environment = 'production'

after "deploy:restart", "deploy:cleanup"

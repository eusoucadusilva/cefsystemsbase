require "bundler/capistrano"
require "capistrano_colors"

set :database, "mysql"
#set :database, "postgresql"

set :domain, "cefsystems.com.br"
set :subdomain, false #or false


load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/#{database}"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/unix_user"

server "173.246.40.107", :web, :app, :db, primary: true

set :root_user, "root"
set :user, "ruby"
set :application, "cefsystemsbase"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:cefs/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

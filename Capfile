# frozen_string_literal: true

require "pry"

# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require "capistrano/bundler" # Rails needs Bundler, right?
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/nginx"
require "capistrano/rvm"

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Nginx

require "capistrano/systemd/multiservice"
install_plugin Capistrano::Systemd::MultiService.new_service("sidekiq")
install_plugin Capistrano::Systemd::MultiService.new_service("core")

require "capistrano-db-tasks"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

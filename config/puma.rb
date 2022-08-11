# frozen_string_literal: true

require "rails"
require "active_record"

rails_env = Rails.env.to_s

environment ENV.fetch("RAILS_ENV") { "production" }

$stdout.puts "{puma.rb}: rails_env: #{rails_env}, ENV[RAILS_ENV]: #{ENV.fetch('RAILS_ENV', nil)}"

environment rails_env

def root
   File.expand_path("../..", __FILE__)
end

if Rails.env.production?
   app_dir = File.expand_path("../..", __FILE__)
   shared_dir = File.expand_path("#{app_dir}/../../shared")
   threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }

   workers Integer(ENV["WEB_CONCURRENCY"] || 2)
   bind "unix:#{shared_dir}/tmp/sockets/puma.sock"
   stdout_redirect "#{shared_dir}/log/stdout.log", "#{shared_dir}/log/stderr.log", true
   pidfile ENV.fetch("PIDFILE") { "#{shared_dir}/tmp/pids/puma.pid" }
   state_path "#{shared_dir}/tmp/pids/puma.state"
   activate_control_app
   plugin :tmp_restart
elsif Rails.env.development?
   shared_dir = "."
   threads_count = Integer(ENV["MAX_THREADS"] || 2)
   port = ENV.fetch("PORT") { 33333 }
   host = ENV["HOST"] || "localhost"
   key = ENV["SSL_KEY_PATH"] || File.join(Dir.home, ".ssh", "dneslov.dev.server.key")
   cert = ENV["SSL_CERT_PATH"] || File.join(root, "config/server.crt")

   worker_timeout 3600
   workers Integer(ENV["WEB_CONCURRENCY"] || 2)
   if File.exist?(cert)
      ssl_bind host, port, {
         key:,
         cert:,
         verify_mode: "none"
      }
   else
      port(port)
   end

   rackup DefaultRackup
end

threads threads_count, threads_count

preload_app!

on_worker_boot do
   # Worker specific setup for Rails 4.1+
   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
   ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
   if Rails.env.production?
      ActiveRecord::Base.establish_connection(YAML.load_file("#{shared_dir}/config/database.yml")[rails_env])
   end
end

# frozen_string_literal: true

server "176.113.80.84", port: "222", user: "_nginx", roles: %w{app db web}, primary: true

set :pty, false

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, "staging-api.allslavic.org"
set :deploy_to, "/var/www/allslavic-staging"

set :rails_env, :staging
set :enable_ssl, false

# nginx
set :nginx_domains, "staging-api.allslavic.org"
set :nginx_read_timeout, 60
set :app_server_socket, "#{shared_path}/tmp/sockets/puma.sock"

set :nginx_use_ssl, false
set :nginx_http_port, 34567
set :nginx_https_port, 34568
set :nginx_ssl_certificate_path, "/etc/nginx/ssl"
set :nginx_ssl_certificate, "allslavic-staging.org.pem"
set :nginx_ssl_certificate_key_path, "/etc/nginx/ssl"
set :nginx_ssl_certificate_key, "allslavic-staging.org.key"
set :nginx_sites_available_dir, "/etc/nginx/sites-available.d"
set :nginx_sites_enabled_dir, "/etc/nginx/sites-enabled.d"
set :stage, :staging
set :branch, ENV["BRANCH"] || "master"

# db-tasks
set :disallow_pushing, false
set :skip_data_sync_confirm, true

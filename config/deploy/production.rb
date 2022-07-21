server "185.133.42.61", port: "222", user: "_nginx", roles: %w{app db web}, primary: true

set :pty, false

# nginx
set :nginx_domains, "api.allslavic.org"
set :nginx_read_timeout, 60
set :app_server_socket, "#{shared_path}/tmp/sockets/puma.sock"

set :nginx_use_ssl, true
set :nginx_ssl_certificate_path, '/etc/nginx/ssl'
set :nginx_ssl_certificate, 'allslavic.org.pem'
set :nginx_ssl_certificate_key_path, '/etc/nginx/ssl'
set :nginx_ssl_certificate_key, 'allslavic.org.key'
set :nginx_sites_available_dir, "/etc/nginx/sites-available.d"
set :nginx_sites_enabled_dir, "/etc/nginx/sites-enabled.d"
set :stage, :production
set :branch, ENV['BRANCH'] || "master"


set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, "api.allslavic.org"
set :deploy_to, "/var/www/allslavic"

set :rails_env, :production
set :enable_ssl, true


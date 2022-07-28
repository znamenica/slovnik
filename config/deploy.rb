# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :user, 'majioa'
set :application, "allslavic"
set :deploy_user, '_nginx'

set :repo_url, "git@github.com:znamenica/allslavic.git"

append :linked_files, "config/database.yml", "config/secrets.yml", ".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "node_modules"

set :tests, []

set(:config_files, %w(
   secrets.example.yml
   database.example.yml
))

set(:symlinks, [
   {
      source: "config/webpack/production.js",
      link: "webpack.config.js"
   },
])

set :migration_role, :app

# Default value for default_env is {}
set :default_env, { path: "#{release_path}/node_modules/yarn/bin:#{release_path}/bin:$PATH" }

set :nginx_roles, :web
set :nginx_static_dir, "public"
set :nginx_template, "#{stage_config_path}/#{fetch :stage}/nginx.conf.erb"

set :rvm_type, :user                      # Defaults to: :auto
set :rvm_ruby_version, '3.1.2@allslavic --create'    # Defaults to: 'default'
# set :rvm_custom_path, '~/.rvm'          # only needed if not detected
set :rvm_roles, [:app, :web]

set :systemd_redis_service, "redis"

task :setup do
   after 'setup', 'systemd:core:setup'
   after 'setup', 'nginx:site:add'
   after 'setup', 'systemd:sidekiq:setup'
end

# deploy
after 'deploy:publishing', 'systemd:sidekiq:enable'
after 'deploy:publishing', 'systemd:core:enable'
after 'deploy:finishing', 'deploy:cleanup'

# deploy:restart
before 'nginx:reload', 'nginx:create_log_paths'
before 'deploy:cleanup', 'nginx:restart'
before 'nginx:restart', 'nginx:site:enable'
before 'deploy:restart', 'nginx:restart'
after 'deploy:restart', 'systemd:sidekiq:reload-or-restart'
after 'deploy:restart', 'systemd:core:reload-or-restart'

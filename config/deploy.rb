# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'djet'

set :deploy_user, 'dev'

set :repo_url, 'git@bitbucket.org:denstepa/djet.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

set :pty, true

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set(:symlinks, [
                 {
                     source: "nginx.conf",
                     link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
                 },
                 {
                     source: "unicorn_init.sh",
                     link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
                 },
                 {
                     source: "log_rotation",
                     link: "/etc/logrotate.d/#{fetch(:full_app_name)}"
                 }#,
                 #{
                 #    source: "monit",
                 #    link: "/etc/monit/conf.d/#{fetch(:full_app_name)}.conf"
                 #}
             ])

set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
))

set(:executable_config_files, %w(
  unicorn_init.sh
))

namespace :deploy do

  # make sure we're deploying what we think we're deploying
  #before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  #before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  #after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  #after :finishing, 'deploy:cleanup'

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  #before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  #after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  # after 'deploy:setup_config', 'monit:restart'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

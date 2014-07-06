# config valid only for Capistrano 3.2
lock '3.2.1'

set :application, 'swiftcrowd'
set :repo_url, 'git@github.com:appunite/swiftcrowd-rails.git'

set :linked_files, %w{config/database.yml config/settings.yml db/production.sqlite3}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 10
set :pty, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end

after 'deploy:finishing', 'deploy:restart'
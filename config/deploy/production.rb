set :application, 'swiftcrowd'
set :stage, :staging
set :user, :rails
set :deploy_to, '/u/apps/swiftcrowd'

set :rvm_ruby_version, '2.0.0-p247'      # Defaults to: 'default'

set :scm_verbose, true
set :ssh_options, { forward_agent: true }
set :monit_groups, [:gistr]

set :rails_env, 'production'

server 'swiftcrowd.appunite.com', user: 'rails', roles: %w{web app db}
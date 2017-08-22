require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'foobar'
set :domain, 'foobar.com'
set :deploy_to, '/var/www/foobar.com'
set :repository, 'git://...'
set :branch, 'master'

set :application_name, 'codenohito_cp'
set :domain, 'codenohito.server' # cp.codenohito.ru
set :deploy_to, '/home/dymio/www/codenohito_cp'
set :repository, 'git@github.com:codenohito/cp.git'
set :branch, 'master'

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.

set :forward_agent, true # SSH forward_agent.
# probably you will need to add RSA key of repository server manually once before deploy
# just enter your server with `ssh user@server -A` and clone your repo to any folder

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('node_modules',
                                               'public/uploads',
                                               'public/content',
                                               'public/packs')
set :shared_files, fetch(:shared_files, []).push('config/application.yml',
                                                 'config/cable.yml',
                                                 'config/database.yml',
                                                 'config/secrets.yml')

set :asset_dirs, fetch(:shared_dirs, []).push('app/javascript')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
  comment "Don't forget to create shared/config/application.yml file"
  comment "Don't forget to create shared/config/cable.yml file"
  comment "Don't forget to create shared/config/database.yml file"
  comment "Don't forget to create shared/config/secrets.yml file"
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs

# REMEMBER:
# Create github private project
#  $ git remote add origin git@github.com:drnic/default-twitter-auth-app.git
#  $ git push origin master
#

require 'deprec'

set :application, "default-twitter-auth-app"
set :domain,      "default-twitter-auth-app.mocra.com"
set :repository,  "git://github.com/drnic/#{application}.git"
# set :repository,  "git@github.com:drnic/#{application}.git"

set :scm, :git
set :git_enable_submodules, 1

set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

set(:mysql_admin_pass) { db_password }

ssh_options[:forward_agent] = true
# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed
# set :gems_for_project, %w() # list of gems to be installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db, domain, :primary => true

# If you aren't deploying to /opt/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/opt/apps/#{application}"

before 'deploy:cold', 'deploy:upload_database_yml'
before 'deploy:cold', 'deploy:ping_ssh_github'
after 'deploy:symlink', 'deploy:create_symlinks'

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.app.restart
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    top.deprec.app.restart
  end

  desc "Uploads database.yml file to shared path"
  task :upload_database_yml, :roles => :app do
    put(File.read('config/database.yml'), "#{shared_path}/config/database.yml", :mode => 0644)
  end

  desc "Symlinks database.yml file from shared folder"
  task :create_symlinks, :roles => :app do
    run "rm -f #{current_path}/config/database.yml"
    run "ln -s #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

  desc "ssh git@github.com"
  task :ping_ssh_github do
    run 'ssh -o "StrictHostKeyChecking no" git@github.com || true'
  end
end

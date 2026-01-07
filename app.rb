require 'sinatra'
require 'sqlite3'

set :port, 8080
set :bind, '0.0.0.0'
enable :sissions

DB = SQLite3::Database.new("db/manager.db")
DB.results_as_hash=true

require_relative 'routes/routes_users.rb'
require_relative 'routes/routes_projects.rb'
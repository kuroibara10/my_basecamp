require 'sinatra'
require 'sqlite3'
require 'securerandom'

set :port, 8080
set :port, ENV.fetch("PORT", 3000)
enable :sissions

use Rack::Session::Cookie,
  key: 'app.session',
  path: '/',
  secret: SecureRandom.hex(64),  # generates 128-character hex string
  expire_after: 3600,
  same_site: :lax


DB = SQLite3::Database.new("db/manager.db")
DB.results_as_hash=true

require_relative 'routes/routes_users.rb'
require_relative 'routes/routes_auth.rb'
require_relative 'routes/routes_projects.rb'
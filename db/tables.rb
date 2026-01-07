require 'sqlite3'
DB = SQLite3::Database.new "manager.db"

# Tabale usesrs
DB.execute <<-SQL 
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    email TEXT UNIQUE,
    password TEXT
  );
SQL
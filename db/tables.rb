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

#Table projects
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS projects(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    email_origin TEXT,
    user_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id)
  );
SQL
#Table members
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS members(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT,
    is_admin INTEGER DEFAULT 0,
    project_id INTEGER,
    FOREIGN KEY(project_id) REFERENCES projects(id)
  );
SQL

#Table discussions
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS discussions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT,
    message TEXT,
    project_id INTEGER,
    FOREIGN KEY(project_id) REFERENCES projects(id)
  );
SQL

#Table tasks
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS tasks(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task TEXT,
    email TEXT,
    project_id INTEGER,
    FOREIGN KEY(project_id) REFERENCES projects(id)
  );
SQL

#Table attachements
DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS attachements(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    url_place TEXT,
    email TEXT,
    project_id INTEGER,
    FOREIGN KEY(project_id) REFERENCES projects(id)
  );
SQL
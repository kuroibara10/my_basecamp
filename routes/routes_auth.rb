# INDEX
get '/' do
  erb :index
end

# SIGNUP PAGE
get '/signup' do
  erb :signup
end

# LOGIN PAGE
get '/login' do
  erb :login
end

# LOGOUT
get '/logout' do
  session.clear
  redirect '/'
end

# HOME (PROTECTED)
get '/home' do
  redirect '/login' unless session[:user_id]

  @user = DB.execute("SELECT * FROM users WHERE id = ?", [session[:user_id]]).first

  unless @user
    session.clear
    redirect '/login'
  end

  # Projects created by user
  @projects_created = DB.execute(
    "SELECT * FROM projects WHERE user_id = ?",
    [@user["id"]]
  )

  # Projects shared with user
  @projects_shared = DB.execute(
    "SELECT * FROM projects WHERE email_origin = ? AND user_id != ?",
    [@user["email"], @user["id"]]
  )

  # All projects relevant to user
  @projects_all = @projects_created + @projects_shared

  erb :home
end

# ----------------------------
# POST SIGNUP
# ----------------------------
post '/signup' do
  username = params[:username]&.strip
  email = params[:email]&.strip
  password = params[:password]
  password_again = params[:password_again]

  # Validate input
  if [username, email, password, password_again].any?(&:nil?) || [username, email, password, password_again].any?(&:empty?)
    session[:type] = "error"
    session[:message] = "All fields are required"
    redirect '/signup'
  end

  if password != password_again
    session[:type] = "error"
    session[:message] = "Passwords do not match"
    redirect '/signup'
  end

  begin
    DB.execute(
      "INSERT INTO users (username, email, password) VALUES (?, ?, ?)",
      [username, email, password] # plain text
    )
    session[:type] = "success"
    session[:message] = "Registration successful. Please login."
    redirect '/login'

  rescue SQLite3::ConstraintException
    session[:type] = "error"
    session[:message] = "Email already exists"
    redirect '/signup'
  rescue => e
    halt 500, "Registration failed: #{e.message}"
  end
end

# ----------------------------
# POST LOGIN
# ----------------------------
post '/login' do
  email = params[:email]&.strip
  password = params[:password]

  user = DB.execute("SELECT * FROM users WHERE email = ?", [email]).first

  if user.nil?
    session[:type] = "error"
    session[:message] = "Email not found"
    redirect '/login'
  end

  if user["password"] == password
    session[:user_id] = user["id"]
    session[:type] = "success"
    session[:message] = "Welcome #{user['username']}"
    redirect '/home'
  else
    session[:type] = "error"
    session[:message] = "Incorrect password"
    redirect '/login'
  end
end

# ----------------------------
# OPTIONAL: SESSION TEST
# ----------------------------
get '/session-test' do
  session[:count] ||= 0
  session[:count] += 1
  "Session counter: #{session[:count]}"
end
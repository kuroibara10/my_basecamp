get '/' do
  content_type :html
  begin
    erb :index
  rescue => e
    halt 500, "Failed to load page index : #{e.message}"
  end
end
get '/login' do 
  content_type :html
  begin 
    erb :login
  rescue => e
    halt 500, "Fail to load page Login: #{e.message}"
  end
end

get '/home' do
  content_type :html
  begin
    erb :home
  rescue => e
    halt 500, "Failed to load page Home : #{e.message}"
  end
end


post '/singUp' do 
    username = params[:username] 
    email = params[:email] 
    password = params[:password] 
    password_again = params[:password_again]
    begin
      if (password != password_again)
        session[:type] = "error"
        session[:message] = "passwords not match, Please check and try again"
      end
      hashpassword = BCrypt::Password.create(password)
      DB.execute("INSERT INTO users (username, email, password) VALUES (?,?,?)",[username, email, hashpassword])
      session[:type] = "success"
      session[:message] = "Your Registration was Successful"
    rescue => e
      halt 500, "Failed to Registration : #{e.message}"
    end
end
post '/login' do
  email = params[:email]
  password = params[:password]
  user = DB.execute("SELECT * FROM users WHERE email = ?",[email]).first
  if(user.nil?)
    session[:type] = "error"
    session[:message] = "Email Not Found"
  elsif (BCrypt::Password.new(user["password"]) == password)
    session[:type] = "success"
    session[:message] = "Hello #{user["username"]}"
    session[:user_id] = user["id"]
    @user = user
    redirect "/home"
  else
    session[:type] = "error"
    session[:message] = "Password Not correct"
  end
end


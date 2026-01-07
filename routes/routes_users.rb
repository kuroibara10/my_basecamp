# Routes : 4 types requests
# get : fetch data
# post : Send or add data
# put : update data
# delete : delete data
require_relative '../models/user.rb'

get '/users' do
  content_type :html
  begin
    @users = User.all
    # @users = DB.execute("SELECT * FROM users")
    erb :index
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

get '/showUser/:id' do
  content_type :html
  id = params[:id]
  begin
    @user = User.show(id)
    erb :profile
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

post '/newUser' do 
  username = params[:username]
  email = params[:email]
  password = params[:password]
  begin
    user_id = User.create(username, email, password)
    # DB.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?);",[username, email, password])
    # user_id = DB.last_insert_row_id
    redirect "/showUser/#{user_id}"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

get '/editUser/:id' do
  content_type :html
  id = params[:id]
  begin
    @user = User.edit(id)
    erb :editUser
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

put '/updateUser' do 
  id = params[:id]
  username = params[:username]
  email = params[:email]
  begin
    User.update(username, email, id)
    # DB.execute("UPDATE users SET username = ?,  email = ? WHERE id = ?",[username, email, id])
    redirect "/showUser/#{id}"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

put '/changePassword' do 
  id = params[:id]
  username = params[:username]
  password = params[:password]
  password_again = params[:password_again]
  begin
    if password == password_again
      User.changePassword(password, id)
      # DB.execute("UPDATE users SET password = ? WHERE id = ?",[password, id])
      session[:type_chpass] = "success"
      session[:message_chpass] = "Update successfully user : #{username}"
      redirect "/showUser/#{id}"
    else
      session[:type_chpass] = "error"
      session[:message_chpass] = "password & password again is diff"
      redirect "/editUser/#{id}"
    end
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

delete '/deleteUser/:id' do 
  id = params[:id]
  begin
    User.destroy(id)
    # DB.execute("DELETE FROM users WHERE id = ?",[id])
    redirect "/users"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end
require_relative '../models/project.rb'

get '/projects' do
  content_type :html
  begin
    @projects = Project.all
    erb :"projects/projects"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

get '/home/create_project' do
  content_type :html
  id = params[:id]
  begin
    erb :"projects/createProject"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

get '/home/show_project/:id' do
  content_type :html
  id = params[:id]
  begin
    @project = Project.show(id)
    @owner = DB.execute("SELECT * FROM users WHERE id = ?;",[@project["user_id"]]).first
    erb :"projects/showProject"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

post '/projects/newProject' do 
  name = params[:name]
  description = params[:description]
  email_origin = params[:email_origin]
  user_id = params[:user_id]
  begin
    project_id = Project.create(name, description, email_origin, user_id)
    redirect "/home/show_project/#{project_id}"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

get '/home/edit_project/:id' do
  content_type :html
  id = params[:id]
  begin
    @project = Project.edit(id)
    erb :"projects/editProject"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

put '/projects/updateProject/:id' do 
  id = params[:id]
  name = params[:name]
  description = params[:description]
  email_origin = params[:email_origin]
  user_id = params[:user_id]
  begin
    Project.update(id, name, description, email_origin, user_id)
    redirect "/home/show_project/#{id}"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end

delete '/projects/deleteProject/:id' do 
  id = params[:id]
  begin
    Project.destroy(id)
    redirect "/home"
  rescue => e
    halt 500, "Error is #{e.message}"
  end
end
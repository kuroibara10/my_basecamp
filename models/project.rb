class Project 
  def self.all
    DB.execute("SELECT * FROM projects")
  end
  def self.show(id)
    DB.execute("SELECT * FROM projects WHERE id = ?;",[id]).first
  end
  def self.create(name, description, email_origin, user_id)
    DB.execute("INSERT INTO projects (name, description, email_origin, user_id) VALUES (?, ?, ?, ?);",[name, description, email_origin, user_id])
    project_id = DB.last_insert_row_id
    return project_id
  end
  def self.edit(id)
    DB.execute("SELECT * FROM projects WHERE id = ?;",[id]).first
  end
  def self.update(id, name, description, email_origin, user_id)
    DB.execute("UPDATE projects SET name = ?,  description = ?, email_origin = ?, user_id = ? WHERE id = ?",[name, description, email_origin, user_id, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM projects WHERE id = ?",[id])
  end
end
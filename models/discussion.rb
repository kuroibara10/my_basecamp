class Discussion 
  def self.all
    DB.execute("SELECT * FROM discussions")
  end
  def self.show(id)
    DB.execute("SELECT * FROM discussions WHERE id = ?;",[id]).first
  end
  def self.create(email, message, project_id)
    DB.execute("INSERT INTO discussions (email, message, project_id) VALUES (?, ?, ?);",[email, message, project_id])
  end
  def self.edit(id)
    DB.execute("SELECT * FROM discussions WHERE id = ?;",[id]).first
  end
  def self.update(email, message, id)
    DB.execute("UPDATE discussions SET email = ?,  message = ? WHERE id = ?",[email, message, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM discussions WHERE id = ?",[id])
  end
end
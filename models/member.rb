class Member 
  def self.all
    DB.execute("SELECT * FROM members")
  end
  def self.show(id)
    DB.execute("SELECT * FROM members WHERE id = ?;",[id]).first
  end
  def self.create(email, is_admin, project_id)
    DB.execute("INSERT INTO members (email, is_admin, project_id) VALUES (?, ?, ?);",[email, is_admin, project_id])
  end
  def self.edit(id)
    DB.execute("SELECT * FROM members WHERE id = ?;",[id]).first
  end
  def self.update(email, is_admin, id)
    DB.execute("UPDATE members SET email = ?,  is_admin = ? WHERE id = ?",[email, is_admin, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM members WHERE id = ?",[id])
  end
end
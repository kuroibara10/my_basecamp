class Attachement
  def self.all
    DB.execute("SELECT * FROM attachements")
  end
  def self.show(id)
    DB.execute("SELECT * FROM attachements WHERE id = ?;",[id]).first
  end
  def self.create(url_place, email, project_id)
    DB.execute("INSERT INTO attachements (url_place, email, project_id) VALUES (?, ?, ?);",[url_place, email, project_id])
  end
  def self.edit(id)
    DB.execute("SELECT * FROM attachements WHERE id = ?;",[id]).first
  end
  def self.update(url_place, email, id)
    DB.execute("UPDATE attachements SET url_place = ?, email = ?,   ? WHERE id = ?",[url_place, email, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM attachements WHERE id = ?",[id])
  end
end
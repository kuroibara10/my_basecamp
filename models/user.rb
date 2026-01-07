class User 
  def self.all
    DB.execute("SELECT * FROM users")
  end
  def self.show(id)
    DB.execute("SELECT * FROM users WHERE id = ?;",[id]).first
  end
  def self.create(username, email, password)
    DB.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?);",[username, email, password])
    user_id = DB.last_insert_row_id
    return user_id
  end
  def self.edit(id)
    DB.execute("SELECT * FROM users WHERE id = ?;",[id]).first
  end
  def self.update(username, email, id)
    DB.execute("UPDATE users SET username = ?,  email = ? WHERE id = ?",[username, email, id])
  end
  def self.changePassword(password, id)
    DB.execute("UPDATE users SET password = ? WHERE id = ?",[password, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM users WHERE id = ?",[id])
  end
end
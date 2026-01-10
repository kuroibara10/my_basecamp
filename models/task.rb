class Task
  def self.all
    DB.execute("SELECT * FROM tasks")
  end
  def self.show(id)
    DB.execute("SELECT * FROM tasks WHERE id = ?;",[id]).first
  end
  def self.create(task, email, project_id)
    DB.execute("INSERT INTO tasks (task, email, project_id) VALUES (?, ?, ?);",[task, email, project_id])
  end
  def self.edit(id)
    DB.execute("SELECT * FROM tasks WHERE id = ?;",[id]).first
  end
  def self.update(task, email, id)
    DB.execute("UPDATE tasks SET task = ?, email = ?,   ? WHERE id = ?",[task, email, id])
  end
  def self.destroy(id)
    DB.execute("DELETE FROM tasks WHERE id = ?",[id])
  end
end
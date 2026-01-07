class User 
  def self.all
    users = DB.execute("SELECT * FROM users")
  end
end
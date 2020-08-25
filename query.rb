require_relative "database"

module Query
  def save()
    self.class.delete(self.id)
    Database.instance.save(self.class.to_s.to_sym, self)
  end

  def create(field)
    Database.instance.save(self.name.to_s.to_sym, self.new(field))
  end

  def find(id)
    Database.instance.find(self.name.to_s.to_sym, id)
  end

  def delete(id)
    Database.instance.delete(self.name.to_s.to_sym, id)
  end
end

require_relative "database"


module Query
  @@database = Database.instance
  def save()
    attrs = Hash.new
    instance_variables.each do |var|
      str = var.to_s.gsub /^@/, ''
      if respond_to? "#{str}="
        attrs[str.to_sym] = instance_variable_get var
      end
    end
    columns = attrs.keys.join(" = ? , ")+"  = ? "
    table_name = self.class.name.downcase
    
    query =<<~SQL
    UPDATE #{table_name} SET #{columns} WHERE id = #{self.id}
    SQL
    values = attrs.values
    query_field = {
      :string => query,
      :value => values
    }
    @@database.save(query_field)
  end

  def create(field)
    table_name = self.name.downcase
    columns = field.keys.join(",")
    slots = field.keys.map { |key| key = "?"}.join(",")
    values = field.values
    query =<<~SQL
    INSERT INTO "#{table_name}"(#{columns}) 
    VALUES(#{slots})
    SQL
    query_field = {
      :string => query,
      :value => values,
    }
    @@database.create(query_field)
  end

  def find(hash_field)
    table_name = self.name.to_s.downcase
    key = hash_field.keys[0]
    query =<<~SQL
    SELECT * FROM #{table_name} WHERE  #{key} = #{hash_field[key]}
    SQL
    if @@database.find(query) != 0
      new(@@database.find(query))
    else
      return 0
    end
  end

  def delete(id)
    table_name = self.name.to_s.downcase
    query =<<~SQL
    DELETE FROM #{table_name} WHERE id = #{id};
    SQL

    @@database.delete(query)
  end
end

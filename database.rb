require 'singleton'
class Database
  include Singleton
  attr_accessor :database
  def initialize
    @database = { }
  end

  def save(table_name, record)
    if !@database[table_name]
      @database[table_name] = [record]
    else
      @database[table_name].push(record)
    end
    @database[table_name].last
  end

  def find(table_name, id)
    record =  @database[table_name].select { |record| record.id == id}
    if !@database[table_name] or record == []
      return 0
    else
      return record.last
    end
  end

  def delete(table_name, id)
    record =  @database[table_name].select { |record| record.id == id}
    @database[table_name].delete(record.last)
    return record 
  end
end


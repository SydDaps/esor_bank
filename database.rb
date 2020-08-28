require 'singleton'
require "sqlite3"

db = SQLite3::Database.open("./database/esor_bank_test.db")
class Database
  include Singleton
  attr_accessor :database
  def initialize
    @db = SQLite3::Database.open("./database/esor_bank_test.db")
    @db.results_as_hash = true
  end

  def create(query_field)
    begin
      @db.execute(query_field[:string], *query_field[:value])
      id = @db.last_insert_row_id
    rescue SQLite3::Exception => e
      print e
    end  
  end

  def save(query_field)
    begin
      @db.execute(query_field[:string], *query_field[:value])
    rescue SQLite3::Exception => e
      print e
    end  
  end



  def find(query)
    begin
      row =  @db.execute(query)
      if row.last
        return row.last.transform_keys(&:to_sym)
      else 
        return 0
      end
    rescue SQLite3::Exception => e
      print e
    end  
  end

  def delete(query)
    begin
      @db.execute(query)
    rescue SQLite3::Exception => e
      print e
    end  
  end
end


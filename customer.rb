require_relative "user"
require_relative "account"
require_relative "database"
require_relative "query"

class Customer < User
  include Query
  extend Query

  attr_accessor :account, :database, :id, :customer_id
  @@customer_id = 1001
  
  def initialize(fields)
    super
    @account = {fields[:account].type => fields[:account]}
    @id = @@customer_id
    @@customer_id += 1
  end

  def balance(type)
    @account[type].balance
  end
end




    
   
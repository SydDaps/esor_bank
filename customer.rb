require_relative "user"
require_relative "account"
require_relative "database"
require_relative "query"

class Customer < User
  include Query
  extend Query

  attr_accessor :account, :database, :id, :customer_id

  def initialize(fields)
    super
  end
end

fields = {
  :first_name => "kweku",
  :last_name => "Daps",
  :phone_number => "2222222222",
  :age => 23,
  :address => "23-455-445",
  
}

hash_field = {
  :phone_number => 2222222222
}
#Customer.create(fields)
#print Customer.find(hash_field)
    
   
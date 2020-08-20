require_relative "transaction"

class Vault < Account
  attr_accessor :balance, :records
  def initialize
    @records = []
    @balance = 0.0
  end


  def add(statement)
    @records.push(statement)
  end
 

end


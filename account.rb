require_relative "query"

class Account
  include Query
  extend Query

  attr_accessor :type, :id
  def initialize(field)
    @type = field[:type]
    @balance = field[:balance]
    @id =  field[:id]
  end

  # def deposit(amount)
  #   @balance += amount
  # end

  # def withdraw(amount)
  #   @balance -= amount
  # end

  # def add(statement)
  #   @statement.push(statement)
  # end

end
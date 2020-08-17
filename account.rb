class Account
  attr_accessor :type, :balance, :statement
  def initialize(type)
    @type = type
    @balance = 0.0
    @statement = []
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end


  def add(statement)
    @statement.push(statement)
  end
end
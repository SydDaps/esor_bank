class Account
  attr_accessor :type, :balance 
  def initialize(type)
    @type = type
    @balance = 0.0
  end

  def depositFunds(amount)
    @balance += amount
  end

  def withdrawFunds(amount)
    @balance -= amount
  end
end
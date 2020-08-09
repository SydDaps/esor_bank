class Account
  attr_accessor :type, :balance 
  def initialize(type)
    @type = type
    @balance = 0.0
  end

  def deposit_funds(amount)
    @balance += amount
  end

  def withdraw_funds(amount)
    @balance -= amount
  end

  # def ==(other)
  #   self.balance == other.balance &&
  #   self.type == other.type
  # end
end
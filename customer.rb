require_relative "user"
require_relative "account"

class Customer < User
  attr_accessor :account
  def initialize(fields)
    super
    @account = {fields[:account].type => fields[:account]}
  end

  def balance(type)
    @account[type].balance
  end

end

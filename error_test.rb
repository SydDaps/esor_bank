require "minitest/autorun"
require_relative "vault"
require_relative "error"

class TestVault < Minitest::Test

  def test_error
    balance = 50.0
    withdrawal_amount = 60.0

    
    assert_raises TransactionError do 
      raise TransactionError.new("insufficient_balance", "") if balance < withdrawal_amount
    end
  end 
end